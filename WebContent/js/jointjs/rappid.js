(function(root, factory) {

    if (typeof define === 'function' && define.amd) {

        // For AMD.

        define(['backbone', 'lodash', 'jquery'], function(Backbone, _, $) {

            Backbone.$ = $;

            return factory(root, Backbone, _, $);
        });

    } else if (typeof exports !== 'undefined') {

        // For Node.js or CommonJS.

        var Backbone = require('backbone');
        var _ = require('lodash');
        var $ = Backbone.$ = require('jquery');

        module.exports = factory(root, Backbone, _, $);

    } else {

        // As a browser global.

        var Backbone = root.Backbone;
        var _ = root._;
        var $ = Backbone.$ = root.jQuery || root.$;

        root.joint = factory(root, Backbone, _, $);
        root.g = root.joint.g;
        root.V = root.Vectorizer = root.joint.V;
    }

}(this, function(root, Backbone, _, $) {


    var g = function() {
        var a = {},
            b = Math,
            c = b.abs,
            d = b.cos,
            e = b.sin,
            f = b.sqrt,
            g = b.min,
            h = b.max,
            i = b.atan2,
            j = b.round,
            k = b.floor,
            l = b.PI,
            m = b.random;
        a.bezier = {
            curveThroughPoints: function(a) {
                for (var b = this.getCurveControlPoints(a), c = ["M", a[0].x, a[0].y], d = 0; d < b[0].length; d++) c.push("C", b[0][d].x, b[0][d].y, b[1][d].x, b[1][d].y, a[d + 1].x, a[d + 1].y);
                return c
            },
            getCurveControlPoints: function(a) {
                var b, c = [],
                    d = [],
                    e = a.length - 1;
                if (1 == e) return c[0] = p((2 * a[0].x + a[1].x) / 3, (2 * a[0].y + a[1].y) / 3), d[0] = p(2 * c[0].x - a[0].x, 2 * c[0].y - a[0].y), [c, d];
                var f = [];
                for (b = 1; b < e - 1; b++) f[b] = 4 * a[b].x + 2 * a[b + 1].x;
                f[0] = a[0].x + 2 * a[1].x, f[e - 1] = (8 * a[e - 1].x + a[e].x) / 2;
                var g = this.getFirstControlPoints(f);
                for (b = 1; b < e - 1; ++b) f[b] = 4 * a[b].y + 2 * a[b + 1].y;
                f[0] = a[0].y + 2 * a[1].y, f[e - 1] = (8 * a[e - 1].y + a[e].y) / 2;
                var h = this.getFirstControlPoints(f);
                for (b = 0; b < e; b++) c.push(p(g[b], h[b])), b < e - 1 ? d.push(p(2 * a[b + 1].x - g[b + 1], 2 * a[b + 1].y - h[b + 1])) : d.push(p((a[e].x + g[e - 1]) / 2, (a[e].y + h[e - 1]) / 2));
                return [c, d]
            },
            getCurveDivider: function(a, b, c, d) {
                return function(e) {
                    var f = o(a, b).pointAt(e),
                        g = o(b, c).pointAt(e),
                        h = o(c, d).pointAt(e),
                        i = o(f, g).pointAt(e),
                        j = o(g, h).pointAt(e),
                        k = o(i, j).pointAt(e);
                    return [{
                        p0: a,
                        p1: f,
                        p2: i,
                        p3: k
                    }, {
                        p0: k,
                        p1: j,
                        p2: h,
                        p3: d
                    }]
                }
            },
            getFirstControlPoints: function(a) {
                var b = a.length,
                    c = [],
                    d = [],
                    e = 2;
                c[0] = a[0] / e;
                for (var f = 1; f < b; f++) d[f] = 1 / e, e = (f < b - 1 ? 4 : 3.5) - d[f], c[f] = (a[f] - c[f - 1]) / e;
                for (f = 1; f < b; f++) c[b - f - 1] -= d[b - f] * c[b - f];
                return c
            },
            getInversionSolver: function(a, b, c, d) {
                function e(a, b) {
                    var c = f[a],
                        d = f[b];
                    return function(e) {
                        var f = (a % 3 ? 3 : 1) * (b % 3 ? 3 : 1),
                            g = e.x * (c.y - d.y) + e.y * (d.x - c.x) + c.x * d.y - c.y * d.x;
                        return f * g
                    }
                }
                var f = arguments;
                return function(c) {
                    var d = 3 * e(2, 3)(b),
                        f = e(1, 3)(a) / d,
                        g = -e(2, 3)(a) / d,
                        h = f * e(3, 1)(c) + g * (e(3, 0)(c) + e(2, 1)(c)) + e(2, 0)(c),
                        i = f * e(3, 0)(c) + g * e(2, 0)(c) + e(1, 0)(c);
                    return i / (i - h)
                }
            }
        };
        var n = a.Ellipse = function(a, b, c) {
            return this instanceof n ? a instanceof n ? new n(p(a), a.a, a.b) : (a = p(a), this.x = a.x, this.y = a.y, this.a = b, void(this.b = c)) : new n(a, b, c)
        };
        a.Ellipse.fromRect = function(a) {
            return a = q(a), n(a.center(), a.width / 2, a.height / 2)
        }, a.Ellipse.prototype = {
            bbox: function() {
                return q(this.x - this.a, this.y - this.b, 2 * this.a, 2 * this.b)
            },
            clone: function() {
                return n(this)
            },
            normalizedDistance: function(a) {
                var b = a.x,
                    c = a.y,
                    d = this.a,
                    e = this.b,
                    f = this.x,
                    g = this.y;
                return (b - f) * (b - f) / (d * d) + (c - g) * (c - g) / (e * e)
            },
            containsPoint: function(a) {
                return this.normalizedDistance(a) <= 1
            },
            center: function() {
                return p(this.x, this.y)
            },
            tangentTheta: function(b) {
                var c, d, e = 30,
                    f = b.x,
                    g = b.y,
                    h = this.a,
                    i = this.b,
                    j = this.bbox().center(),
                    k = j.x,
                    l = j.y,
                    m = f > j.x + h / 2,
                    n = f < j.x - h / 2;
                return m || n ? (c = f > j.x ? g - e : g + e, d = h * h / (f - k) - h * h * (g - l) * (c - l) / (i * i * (f - k)) + k) : (d = g > j.y ? f + e : f - e, c = i * i / (g - l) - i * i * (f - k) * (d - k) / (h * h * (g - l)) + l), a.point(d, c).theta(b)
            },
            equals: function(a) {
                return a = n(a), a.x === this.x && a.y === this.y && a.a === this.a && a.b === this.b
            },
            intersectionWithLineFromCenterToPoint: function(a, b) {
                a = p(a), b && a.rotate(p(this.x, this.y), b);
                var c, d = a.x - this.x,
                    e = a.y - this.y;
                if (0 === d) return c = this.bbox().pointNearestToPoint(a), b ? c.rotate(p(this.x, this.y), -b) : c;
                var g = e / d,
                    h = g * g,
                    i = this.a * this.a,
                    j = this.b * this.b,
                    k = f(1 / (1 / i + h / j));
                k = d < 0 ? -k : k;
                var l = g * k;
                return c = p(this.x + k, this.y + l), b ? c.rotate(p(this.x, this.y), -b) : c
            },
            toString: function() {
                return p(this.x, this.y).toString() + " " + this.a + " " + this.b
            }
        };
        var o = a.Line = function(a, b) {
            return this instanceof o ? (this.start = p(a), void(this.end = p(b))) : new o(a, b)
        };
        a.Line.prototype = {
            bearing: function() {
                var a = u(this.start.y),
                    b = u(this.end.y),
                    c = this.start.x,
                    f = this.end.x,
                    g = u(f - c),
                    h = e(g) * d(b),
                    j = d(a) * e(b) - e(a) * d(b) * d(g),
                    k = t(i(h, j)),
                    l = ["NE", "E", "SE", "S", "SW", "W", "NW", "N"],
                    m = k - 22.5;
                return m < 0 && (m += 360), m = parseInt(m / 45), l[m]
            },
            clone: function() {
                return o(this)
            },
            intersection: function(a) {
                var b = p(this.end.x - this.start.x, this.end.y - this.start.y),
                    c = p(a.end.x - a.start.x, a.end.y - a.start.y),
                    d = b.x * c.y - b.y * c.x,
                    e = p(a.start.x - this.start.x, a.start.y - this.start.y),
                    f = e.x * c.y - e.y * c.x,
                    g = e.x * b.y - e.y * b.x;
                if (0 === d || f * d < 0 || g * d < 0) return null;
                if (d > 0) {
                    if (f > d || g > d) return null
                } else if (f < d || g < d) return null;
                return p(this.start.x + f * b.x / d, this.start.y + f * b.y / d)
            },
            length: function() {
                return f(this.squaredLength())
            },
            midpoint: function() {
                return p((this.start.x + this.end.x) / 2, (this.start.y + this.end.y) / 2)
            },
            pointAt: function(a) {
                var b = (1 - a) * this.start.x + a * this.end.x,
                    c = (1 - a) * this.start.y + a * this.end.y;
                return p(b, c)
            },
            pointOffset: function(a) {
                return ((this.end.x - this.start.x) * (a.y - this.start.y) - (this.end.y - this.start.y) * (a.x - this.start.x)) / 2
            },
            squaredLength: function() {
                var a = this.start.x,
                    b = this.start.y,
                    c = this.end.x,
                    d = this.end.y;
                return (a -= c) * a + (b -= d) * b
            },
            toString: function() {
                return this.start.toString() + " " + this.end.toString()
            }
        };
        var p = a.Point = function(a, b) {
            if (!(this instanceof p)) return new p(a, b);
            if ("string" == typeof a) {
                var c = a.split(a.indexOf("@") === -1 ? " " : "@");
                a = parseInt(c[0], 10), b = parseInt(c[1], 10)
            } else Object(a) === a && (b = a.y, a = a.x);
            this.x = void 0 === a ? 0 : a, this.y = void 0 === b ? 0 : b
        };
        a.Point.fromPolar = function(a, b, f) {
            f = f && p(f) || p(0, 0);
            var g = c(a * d(b)),
                h = c(a * e(b)),
                i = r(t(b));
            return i < 90 ? h = -h : i < 180 ? (g = -g, h = -h) : i < 270 && (g = -g), p(f.x + g, f.y + h)
        }, a.Point.random = function(a, b, c, d) {
            return p(k(m() * (b - a + 1) + a), k(m() * (d - c + 1) + c))
        }, a.Point.prototype = {
            adhereToRect: function(a) {
                return a.containsPoint(this) ? this : (this.x = g(h(this.x, a.x), a.x + a.width), this.y = g(h(this.y, a.y), a.y + a.height), this)
            },
            bearing: function(a) {
                return o(this, a).bearing()
            },
            changeInAngle: function(a, b, c) {
                return p(this).offset(-a, -b).theta(c) - this.theta(c)
            },
            clone: function() {
                return p(this)
            },
            difference: function(a) {
                return p(this.x - a.x, this.y - a.y)
            },
            distance: function(a) {
                return o(this, a).length()
            },
            equals: function(a) {
                return this.x === a.x && this.y === a.y
            },
            magnitude: function() {
                return f(this.x * this.x + this.y * this.y) || .01
            },
            manhattanDistance: function(a) {
                return c(a.x - this.x) + c(a.y - this.y)
            },
            move: function(a, b) {
                var c = u(p(a).theta(this));
                return this.offset(d(c) * b, -e(c) * b)
            },
            normalize: function(a) {
                var b = (a || 1) / this.magnitude();
                return this.scale(b, b)
            },
            offset: function(a, b) {
                return this.x += a || 0, this.y += b || 0, this
            },
            reflection: function(a) {
                return p(a).move(this, this.distance(a))
            },
            rotate: function(a, b) {
                b = (b + 360) % 360, this.toPolar(a), this.y += u(b);
                var c = p.fromPolar(this.x, this.y, a);
                return this.x = c.x, this.y = c.y, this
            },
            round: function(a) {
                return this.x = a ? this.x.toFixed(a) : j(this.x), this.y = a ? this.y.toFixed(a) : j(this.y), this
            },
            scale: function(a, b, c) {
                return c = c && p(c) || p(0, 0), this.x = c.x + a * (this.x - c.x), this.y = c.y + b * (this.y - c.y), this
            },
            snapToGrid: function(a, b) {
                return this.x = s(this.x, a), this.y = s(this.y, b || a), this
            },
            theta: function(a) {
                a = p(a);
                var b = -(a.y - this.y),
                    c = a.x - this.x,
                    d = 10,
                    e = 0 == b.toFixed(d) && 0 == c.toFixed(d) ? 0 : i(b, c);
                return e < 0 && (e = 2 * l + e), 180 * e / l
            },
            toJSON: function() {
                return {
                    x: this.x,
                    y: this.y
                }
            },
            toPolar: function(a) {
                a = a && p(a) || p(0, 0);
                var b = this.x,
                    c = this.y;
                return this.x = f((b - a.x) * (b - a.x) + (c - a.y) * (c - a.y)), this.y = u(a.theta(p(b, c))), this
            },
            toString: function() {
                return this.x + "@" + this.y
            },
            update: function(a, b) {
                return this.x = a || 0, this.y = b || 0, this
            }
        };
        var q = a.Rect = function(a, b, c, d) {
            return this instanceof q ? (Object(a) === a && (b = a.y, c = a.width, d = a.height, a = a.x), this.x = void 0 === a ? 0 : a, this.y = void 0 === b ? 0 : b, this.width = void 0 === c ? 0 : c, void(this.height = void 0 === d ? 0 : d)) : new q(a, b, c, d)
        };
        a.Rect.fromEllipse = function(a) {
            return a = n(a), q(a.x - a.a, a.y - a.b, 2 * a.a, 2 * a.b)
        }, a.Rect.prototype = {
            bbox: function(a) {
                var b = u(a || 0),
                    f = c(e(b)),
                    g = c(d(b)),
                    h = this.width * g + this.height * f,
                    i = this.width * f + this.height * g;
                return q(this.x + (this.width - h) / 2, this.y + (this.height - i) / 2, h, i)
            },
            bottomLeft: function() {
                return p(this.x, this.y + this.height)
            },
            bottomMiddle: function() {
                return p(this.x + this.width / 2, this.y + this.height)
            },
            center: function() {
                return p(this.x + this.width / 2, this.y + this.height / 2)
            },
            clone: function() {
                return q(this)
            },
            containsPoint: function(a) {
                return a = p(a), a.x >= this.x && a.x <= this.x + this.width && a.y >= this.y && a.y <= this.y + this.height
            },
            containsRect: function(a) {
                var b = q(this).normalize(),
                    c = q(a).normalize(),
                    d = b.width,
                    e = b.height,
                    f = c.width,
                    g = c.height;
                if (!(d && e && f && g)) return !1;
                var h = b.x,
                    i = b.y,
                    j = c.x,
                    k = c.y;
                return f += j, d += h, g += k, e += i, h <= j && f <= d && i <= k && g <= e
            },
            corner: function() {
                return p(this.x + this.width, this.y + this.height)
            },
            equals: function(a) {
                var b = q(this).normalize(),
                    c = q(a).normalize();
                return b.x === c.x && b.y === c.y && b.width === c.width && b.height === c.height
            },
            intersect: function(a) {
                var b = this.origin(),
                    c = this.corner(),
                    d = a.origin(),
                    e = a.corner();
                if (e.x <= b.x || e.y <= b.y || d.x >= c.x || d.y >= c.y) return null;
                var f = Math.max(b.x, d.x),
                    g = Math.max(b.y, d.y);
                return q(f, g, Math.min(c.x, e.x) - f, Math.min(c.y, e.y) - g)
            },
            intersectionWithLineFromCenterToPoint: function(a, b) {
                a = p(a);
                var c, d = p(this.x + this.width / 2, this.y + this.height / 2);
                b && a.rotate(d, b);
                for (var e = [o(this.origin(), this.topRight()), o(this.topRight(), this.corner()), o(this.corner(), this.bottomLeft()), o(this.bottomLeft(), this.origin())], f = o(d, a), g = e.length - 1; g >= 0; --g) {
                    var h = e[g].intersection(f);
                    if (null !== h) {
                        c = h;
                        break
                    }
                }
                return c && b && c.rotate(d, -b), c
            },
            leftMiddle: function() {
                return p(this.x, this.y + this.height / 2)
            },
            moveAndExpand: function(a) {
                return this.x += a.x || 0, this.y += a.y || 0, this.width += a.width || 0, this.height += a.height || 0, this
            },
            normalize: function() {
                var a = this.x,
                    b = this.y,
                    c = this.width,
                    d = this.height;
                return this.width < 0 && (a = this.x + this.width, c = -this.width), this.height < 0 && (b = this.y + this.height, d = -this.height), this.x = a, this.y = b, this.width = c, this.height = d, this
            },
            origin: function() {
                return p(this.x, this.y)
            },
            pointNearestToPoint: function(a) {
                if (a = p(a), this.containsPoint(a)) {
                    var b = this.sideNearestToPoint(a);
                    switch (b) {
                        case "right":
                            return p(this.x + this.width, a.y);
                        case "left":
                            return p(this.x, a.y);
                        case "bottom":
                            return p(a.x, this.y + this.height);
                        case "top":
                            return p(a.x, this.y)
                    }
                }
                return a.adhereToRect(this)
            },
            rightMiddle: function() {
                return p(this.x + this.width, this.y + this.height / 2)
            },
            round: function(a) {
                return this.x = a ? this.x.toFixed(a) : j(this.x), this.y = a ? this.y.toFixed(a) : j(this.y), this.width = a ? this.width.toFixed(a) : j(this.width), this.height = a ? this.height.toFixed(a) : j(this.height), this
            },
            scale: function(a, b, c) {
                return c = this.origin().scale(a, b, c), this.x = c.x, this.y = c.y, this.width *= a, this.height *= b, this
            },
            sideNearestToPoint: function(a) {
                a = p(a);
                var b = a.x - this.x,
                    c = this.x + this.width - a.x,
                    d = a.y - this.y,
                    e = this.y + this.height - a.y,
                    f = b,
                    g = "left";
                return c < f && (f = c, g = "right"), d < f && (f = d, g = "top"), e < f && (f = e, g = "bottom"), g
            },
            snapToGrid: function(a, b) {
                var c = this.origin().snapToGrid(a, b),
                    d = this.corner().snapToGrid(a, b);
                return this.x = c.x, this.y = c.y, this.width = d.x - c.x, this.height = d.y - c.y, this
            },
            topMiddle: function() {
                return p(this.x + this.width / 2, this.y)
            },
            topRight: function() {
                return p(this.x + this.width, this.y)
            },
            toJSON: function() {
                return {
                    x: this.x,
                    y: this.y,
                    width: this.width,
                    height: this.height
                }
            },
            toString: function() {
                return this.origin().toString() + " " + this.corner().toString()
            },
            union: function(a) {
                var b = this.origin(),
                    c = this.corner(),
                    d = a.origin(),
                    e = a.corner(),
                    f = Math.min(b.x, d.x),
                    g = Math.min(b.y, d.y),
                    h = Math.max(c.x, e.x),
                    i = Math.max(c.y, e.y);
                return q(f, g, h - f, i - g)
            }
        };
        var r = a.normalizeAngle = function(a) {
            return a % 360 + (a < 0 ? 360 : 0)
        };
        a.scale = {
            linear: function(a, b, c) {
                var d = a[1] - a[0],
                    e = b[1] - b[0];
                return (c - a[0]) / d * e + b[0] || 0
            }
        };
        var s = a.snapToGrid = function(a, b) {
                return b * Math.round(a / b)
            },
            t = a.toDeg = function(a) {
                return 180 * a / l % 360
            },
            u = a.toRad = function(a, b) {
                return b = b || !1, a = b ? a : a % 360, a * l / 180
            };
        return a.ellipse = a.Ellipse, a.line = a.Line, a.point = a.Point, a.rect = a.Rect, a
    }();
    var V, Vectorizer;
    V = Vectorizer = function() {
        "use strict";
        var a = "object" == typeof window && !(!window.SVGAngle && !document.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#BasicStructure", "1.1"));
        if (!a) return function() {
            throw new Error("SVG is required to use Vectorizer.")
        };
        var b = {
                xmlns: "http://www.w3.org/2000/svg",
                xml: "http://www.w3.org/XML/1998/namespace",
                xlink: "http://www.w3.org/1999/xlink"
            },
            c = "1.1",
            d = function(a, c, e) {
                if (!(this instanceof d)) return d.apply(Object.create(d.prototype), arguments);
                if (a) {
                    if (d.isV(a) && (a = a.node), c = c || {}, d.isString(a))
                        if ("svg" === a.toLowerCase()) a = d.createSvgDocument();
                        else if ("<" === a[0]) {
                        var f = d.createSvgDocument(a);
                        if (f.childNodes.length > 1) {
                            var g, h, i = [];
                            for (g = 0, h = f.childNodes.length; g < h; g++) {
                                var j = f.childNodes[g];
                                i.push(new d(document.importNode(j, !0)))
                            }
                            return i
                        }
                        a = document.importNode(f.firstChild, !0)
                    } else a = document.createElementNS(b.xmlns, a);
                    return this.node = a, this.node.id || (this.node.id = d.uniqueId()), this.setAttributes(c), e && this.append(e), this
                }
            };
        d.prototype.getTransformToElement = function(a) {
            return a.getScreenCTM().inverse().multiply(this.node.getScreenCTM())
        }, d.prototype.transform = function(a, b) {
            if (d.isUndefined(a)) return this.node.parentNode ? this.getTransformToElement(this.node.parentNode) : this.node.getScreenCTM();
            var c = this.node.transform.baseVal;
            b && b.absolute && c.clear();
            var e = d.createSVGTransform(a);
            return c.appendItem(e), this
        }, d.prototype.translate = function(a, b, c) {
            c = c || {}, b = b || 0;
            var e = this.attr("transform") || "",
                f = d.parseTransformString(e);
            if (d.isUndefined(a)) return f.translate;
            e = e.replace(/translate\([^\)]*\)/g, "").trim();
            var g = c.absolute ? a : f.translate.tx + a,
                h = c.absolute ? b : f.translate.ty + b,
                i = "translate(" + g + "," + h + ")";
            return this.attr("transform", (i + " " + e).trim()), this
        }, d.prototype.rotate = function(a, b, c, e) {
            e = e || {};
            var f = this.attr("transform") || "",
                g = d.parseTransformString(f);
            if (d.isUndefined(a)) return g.rotate;
            f = f.replace(/rotate\([^\)]*\)/g, "").trim(), a %= 360;
            var h = e.absolute ? a : g.rotate.angle + a,
                i = void 0 !== b && void 0 !== c ? "," + b + "," + c : "",
                j = "rotate(" + h + i + ")";
            return this.attr("transform", (f + " " + j).trim()), this
        }, d.prototype.scale = function(a, b) {
            b = d.isUndefined(b) ? a : b;
            var c = this.attr("transform") || "",
                e = d.parseTransformString(c);
            if (d.isUndefined(a)) return e.scale;
            c = c.replace(/scale\([^\)]*\)/g, "").trim();
            var f = "scale(" + a + "," + b + ")";
            return this.attr("transform", (c + " " + f).trim()), this
        }, d.prototype.bbox = function(a, b) {
            if (!this.node.ownerSVGElement) return {
                x: 0,
                y: 0,
                width: 0,
                height: 0
            };
            var c;
            try {
                c = this.node.getBBox(), c = {
                    x: c.x,
                    y: c.y,
                    width: c.width,
                    height: c.height
                }
            } catch (a) {
                c = {
                    x: this.node.clientLeft,
                    y: this.node.clientTop,
                    width: this.node.clientWidth,
                    height: this.node.clientHeight
                }
            }
            if (a) return c;
            var e = this.getTransformToElement(b || this.node.ownerSVGElement);
            return d.transformRect(c, e)
        }, d.prototype.text = function(a, b) {
            a = d.sanitizeText(a), b = b || {};
            var c, e = a.split("\n"),
                f = this.attr("y");
            f || this.attr("y", "0.8em"), this.attr("display", a ? null : "none"), this.attr("xml:space", "preserve"), this.node.textContent = "";
            var g = this.node;
            if (b.textPath) {
                var h = this.find("defs");
                0 === h.length && (h = d("defs"), this.append(h));
                var i = Object(b.textPath) === b.textPath ? b.textPath.d : b.textPath;
                if (i) {
                    var j = d("path", {
                        d: i
                    });
                    h.append(j)
                }
                var k = d("textPath");
                !b.textPath["xlink:href"] && j && k.attr("xlink:href", "#" + j.node.id), Object(b.textPath) === b.textPath && k.attr(b.textPath), this.append(k), g = k.node
            }
            for (var l = 0, m = 0; m < e.length; m++) {
                var n = e[m],
                    o = b.lineHeight || "1em";
                "auto" === b.lineHeight && (o = "1.5em");
                var p = d("tspan", {
                    dy: 0 == m ? "0em" : o,
                    x: this.attr("x") || 0
                });
                if (p.addClass("v-line"), n)
                    if (b.annotations) {
                        for (var q = 0, r = d.annotateString(e[m], d.isArray(b.annotations) ? b.annotations : [b.annotations], {
                                offset: -l,
                                includeAnnotationIndices: b.includeAnnotationIndices
                            }), s = 0; s < r.length; s++) {
                            var t = r[s];
                            if (d.isObject(t)) {
                                var u = parseInt(t.attrs["font-size"], 10);
                                u && u > q && (q = u), c = d("tspan", t.attrs), b.includeAnnotationIndices && c.attr("annotations", t.annotations), t.attrs.class && c.addClass(t.attrs.class), c.node.textContent = t.t
                            } else c = document.createTextNode(t || " ");
                            p.append(c)
                        }
                        "auto" === b.lineHeight && q && 0 !== m && p.attr("dy", 1.2 * q + "px")
                    } else p.node.textContent = n;
                else p.addClass("v-empty-line"), p.node.style.fillOpacity = 0, p.node.style.strokeOpacity = 0, p.node.textContent = "-";
                d(g).append(p), l += n.length + 1
            }
            return this
        }, d.prototype.removeAttr = function(a) {
            var b = d.qualifyAttr(a),
                c = this.node;
            return b.ns ? c.hasAttributeNS(b.ns, b.local) && c.removeAttributeNS(b.ns, b.local) : c.hasAttribute(a) && c.removeAttribute(a), this
        }, d.prototype.attr = function(a, b) {
            if (d.isUndefined(a)) {
                for (var c = this.node.attributes, e = {}, f = 0; f < c.length; f++) e[c[f].name] = c[f].value;
                return e
            }
            if (d.isString(a) && d.isUndefined(b)) return this.node.getAttribute(a);
            if ("object" == typeof a)
                for (var g in a) a.hasOwnProperty(g) && this.setAttribute(g, a[g]);
            else this.setAttribute(a, b);
            return this
        }, d.prototype.remove = function() {
            return this.node.parentNode && this.node.parentNode.removeChild(this.node), this
        }, d.prototype.empty = function() {
            for (; this.node.firstChild;) this.node.removeChild(this.node.firstChild);
            return this
        }, d.prototype.setAttributes = function(a) {
            for (var b in a) a.hasOwnProperty(b) && this.setAttribute(b, a[b]);
            return this
        }, d.prototype.append = function(a) {
            d.isArray(a) || (a = [a]);
            for (var b = 0, c = a.length; b < c; b++) this.node.appendChild(d.toNode(a[b]));
            return this
        }, d.prototype.prepend = function(a) {
            var b = this.node.firstChild;
            return b ? d(b).before(a) : this.append(a)
        }, d.prototype.before = function(a) {
            var b = this.node,
                c = b.parentNode;
            if (c) {
                d.isArray(a) || (a = [a]);
                for (var e = 0, f = a.length; e < f; e++) c.insertBefore(d.toNode(a[e]), b)
            }
            return this
        }, d.prototype.svg = function() {
            return this.node instanceof window.SVGSVGElement ? this : d(this.node.ownerSVGElement)
        }, d.prototype.defs = function() {
            var a = this.svg().node.getElementsByTagName("defs");
            return a && a.length ? d(a[0]) : void 0
        }, d.prototype.clone = function() {
            var a = d(this.node.cloneNode(!0));
            return a.node.id = d.uniqueId(), a
        }, d.prototype.findOne = function(a) {
            var b = this.node.querySelector(a);
            return b ? d(b) : void 0
        }, d.prototype.find = function(a) {
            var b = [],
                c = this.node.querySelectorAll(a);
            if (c)
                for (var e = 0; e < c.length; e++) b.push(d(c[e]));
            return b
        }, d.prototype.index = function() {
            for (var a = 0, b = this.node.previousSibling; b;) 1 === b.nodeType && a++, b = b.previousSibling;
            return a
        }, d.prototype.findParentByClass = function(a, b) {
            for (var c = this.node.ownerSVGElement, e = this.node.parentNode; e && e !== b && e !== c;) {
                var f = d(e);
                if (f.hasClass(a)) return f;
                e = e.parentNode
            }
            return null
        }, d.prototype.toLocalPoint = function(a, b) {
            var c = this.svg().node,
                d = c.createSVGPoint();
            d.x = a, d.y = b;
            try {
                var e = d.matrixTransform(c.getScreenCTM().inverse()),
                    f = this.getTransformToElement(c).inverse()
            } catch (a) {
                return d
            }
            return e.matrixTransform(f)
        }, d.prototype.translateCenterToPoint = function(a) {
            var b = this.bbox(),
                c = g.rect(b).center();
            this.translate(a.x - c.x, a.y - c.y)
        }, d.prototype.translateAndAutoOrient = function(a, b, c) {
            var e = this.scale();
            this.attr("transform", ""), this.scale(e.sx, e.sy);
            var f = this.svg().node,
                h = this.bbox(!1, c),
                i = f.createSVGTransform();
            i.setTranslate(-h.x - h.width / 2, -h.y - h.height / 2);
            var j = f.createSVGTransform(),
                k = g.point(a).changeInAngle(a.x - b.x, a.y - b.y, b);
            j.setRotate(k, 0, 0);
            var l = f.createSVGTransform(),
                m = g.point(a).move(b, h.width / 2);
            l.setTranslate(a.x + (a.x - m.x), a.y + (a.y - m.y));
            var n = this.getTransformToElement(c),
                o = f.createSVGTransform();
            o.setMatrix(l.matrix.multiply(j.matrix.multiply(i.matrix.multiply(n))));
            var p = d.decomposeMatrix(o.matrix);
            return this.translate(p.translateX, p.translateY), this.rotate(p.rotation), this
        }, d.prototype.animateAlongPath = function(a, b) {
            var c = d("animateMotion", a),
                e = d("mpath", {
                    "xlink:href": "#" + d(b).node.id
                });
            c.append(e), this.append(c);
            try {
                c.node.beginElement()
            } catch (a) {
                if ("fake" === document.documentElement.getAttribute("smiling")) {
                    var f = c.node;
                    f.animators = [];
                    var g = f.getAttribute("id");
                    g && (id2anim[g] = f);
                    for (var h = getTargets(f), i = 0, j = h.length; i < j; i++) {
                        var k = h[i],
                            l = new Animator(f, k, i);
                        animators.push(l), f.animators[i] = l, l.register()
                    }
                }
            }
        }, d.prototype.hasClass = function(a) {
            return new RegExp("(\\s|^)" + a + "(\\s|$)").test(this.node.getAttribute("class"))
        }, d.prototype.addClass = function(a) {
            if (!this.hasClass(a)) {
                var b = this.node.getAttribute("class") || "";
                this.node.setAttribute("class", (b + " " + a).trim())
            }
            return this
        }, d.prototype.removeClass = function(a) {
            if (this.hasClass(a)) {
                var b = this.node.getAttribute("class").replace(new RegExp("(\\s|^)" + a + "(\\s|$)", "g"), "$2");
                this.node.setAttribute("class", b)
            }
            return this
        }, d.prototype.toggleClass = function(a, b) {
            var c = d.isUndefined(b) ? this.hasClass(a) : !b;
            return c ? this.removeClass(a) : this.addClass(a), this
        }, d.prototype.sample = function(a) {
            a = a || 1;
            for (var b, c = this.node, d = c.getTotalLength(), e = [], f = 0; f < d;) b = c.getPointAtLength(f), e.push({
                x: b.x,
                y: b.y,
                distance: f
            }), f += a;
            return e
        }, d.prototype.convertToPath = function() {
            var a = d("path");
            a.attr(this.attr());
            var b = this.convertToPathData();
            return b && a.attr("d", b), a
        }, d.prototype.convertToPathData = function() {
            var a = this.node.tagName.toUpperCase();
            switch (a) {
                case "PATH":
                    return this.attr("d");
                case "LINE":
                    return d.convertLineToPathData(this.node);
                case "POLYGON":
                    return d.convertPolygonToPathData(this.node);
                case "POLYLINE":
                    return d.convertPolylineToPathData(this.node);
                case "ELLIPSE":
                    return d.convertEllipseToPathData(this.node);
                case "CIRCLE":
                    return d.convertCircleToPathData(this.node);
                case "RECT":
                    return d.convertRectToPathData(this.node)
            }
            throw new Error(a + " cannot be converted to PATH.")
        }, d.prototype.findIntersection = function(a, b) {
            var c = this.svg().node;
            b = b || c;
            var e = g.rect(this.bbox(!1, b)),
                f = e.center();
            if (e.intersectionWithLineFromCenterToPoint(a)) {
                var h, i = this.node.localName.toUpperCase();
                if ("RECT" === i) {
                    var j = g.rect(parseFloat(this.attr("x") || 0), parseFloat(this.attr("y") || 0), parseFloat(this.attr("width")), parseFloat(this.attr("height"))),
                        k = this.getTransformToElement(b),
                        l = d.decomposeMatrix(k),
                        m = c.createSVGTransform();
                    m.setRotate(-l.rotation, f.x, f.y);
                    var n = d.transformRect(j, m.matrix.multiply(k));
                    h = g.rect(n).intersectionWithLineFromCenterToPoint(a, l.rotation)
                } else if ("PATH" === i || "POLYGON" === i || "POLYLINE" === i || "CIRCLE" === i || "ELLIPSE" === i) {
                    var o, p, q, r, s, t, u = "PATH" === i ? this : this.convertToPath(),
                        v = u.sample(),
                        w = 1 / 0,
                        x = [];
                    for (o = 0; o < v.length; o++) p = v[o], q = d.createSVGPoint(p.x, p.y), q = q.matrixTransform(this.getTransformToElement(b)), p = g.point(q), r = p.distance(f), s = 1.1 * p.distance(a), t = r + s, t < w ? (w = t, x = [{
                        sample: p,
                        refDistance: s
                    }]) : t < w + 1 && x.push({
                        sample: p,
                        refDistance: s
                    });
                    x.sort(function(a, b) {
                        return a.refDistance - b.refDistance
                    }), x[0] && (h = x[0].sample)
                }
                return h
            }
        }, d.prototype.setAttribute = function(a, b) {
            var c = this.node;
            if (null === b) return this.removeAttr(a), this;
            var e = d.qualifyAttr(a);
            return e.ns ? c.setAttributeNS(e.ns, a, b) : "id" === a ? c.id = b : c.setAttribute(a, b), this
        }, d.createSvgDocument = function(a) {
            var e = '<svg xmlns="' + b.xmlns + '" xmlns:xlink="' + b.xlink + '" version="' + c + '">' + (a || "") + "</svg>",
                f = d.parseXML(e, {
                    async: !1
                });
            return f.documentElement
        }, d.idCounter = 0, d.uniqueId = function() {
            var a = ++d.idCounter + "";
            return "v-" + a
        }, d.sanitizeText = function(a) {
            return (a || "").replace(/ /g, "\xa0")
        }, d.isUndefined = function(a) {
            return "undefined" == typeof a
        }, d.isString = function(a) {
            return "string" == typeof a
        }, d.isObject = function(a) {
            return a && "object" == typeof a
        }, d.isArray = Array.isArray, d.parseXML = function(a, b) {
            b = b || {};
            var c;
            try {
                var e = new DOMParser;
                d.isUndefined(b.async) || (e.async = b.async), c = e.parseFromString(a, "text/xml")
            } catch (a) {
                c = void 0
            }
            if (!c || c.getElementsByTagName("parsererror").length) throw new Error("Invalid XML: " + a);
            return c
        }, d.qualifyAttr = function(a) {
            if (a.indexOf(":") !== -1) {
                var c = a.split(":");
                return {
                    ns: b[c[0]],
                    local: c[1]
                }
            }
            return {
                ns: null,
                local: a
            }
        }, d.parseTransformString = function(a) {
            var b, c, d;
            if (a) {
                var e = /[ ,]+/,
                    f = a.match(/translate\((.*)\)/);
                f && (b = f[1].split(e));
                var g = a.match(/rotate\((.*)\)/);
                g && (c = g[1].split(e));
                var h = a.match(/scale\((.*)\)/);
                h && (d = h[1].split(e))
            }
            var i = d && d[0] ? parseFloat(d[0]) : 1;
            return {
                translate: {
                    tx: b && b[0] ? parseInt(b[0], 10) : 0,
                    ty: b && b[1] ? parseInt(b[1], 10) : 0
                },
                rotate: {
                    angle: c && c[0] ? parseInt(c[0], 10) : 0,
                    cx: c && c[1] ? parseInt(c[1], 10) : void 0,
                    cy: c && c[2] ? parseInt(c[2], 10) : void 0
                },
                scale: {
                    sx: i,
                    sy: d && d[1] ? parseFloat(d[1]) : i
                }
            }
        }, d.deltaTransformPoint = function(a, b) {
            var c = b.x * a.a + b.y * a.c + 0,
                d = b.x * a.b + b.y * a.d + 0;
            return {
                x: c,
                y: d
            }
        }, d.decomposeMatrix = function(a) {
            var b = d.deltaTransformPoint(a, {
                    x: 0,
                    y: 1
                }),
                c = d.deltaTransformPoint(a, {
                    x: 1,
                    y: 0
                }),
                e = 180 / Math.PI * Math.atan2(b.y, b.x) - 90,
                f = 180 / Math.PI * Math.atan2(c.y, c.x);
            return {
                translateX: a.e,
                translateY: a.f,
                scaleX: Math.sqrt(a.a * a.a + a.b * a.b),
                scaleY: Math.sqrt(a.c * a.c + a.d * a.d),
                skewX: e,
                skewY: f,
                rotation: e
            }
        }, d.isV = function(a) {
            return a instanceof d
        }, d.isVElement = d.isV;
        var e = d("svg").node;
        return d.createSVGMatrix = function(a) {
            var b = e.createSVGMatrix();
            for (var c in a) b[c] = a[c];
            return b
        }, d.createSVGTransform = function(a) {
            return d.isUndefined(a) ? e.createSVGTransform() : (a instanceof SVGMatrix || (a = d.createSVGMatrix(a)), e.createSVGTransformFromMatrix(a))
        }, d.createSVGPoint = function(a, b) {
            var c = e.createSVGPoint();
            return c.x = a, c.y = b, c
        }, d.transformRect = function(a, b) {
            var c = e.createSVGPoint();
            c.x = a.x, c.y = a.y;
            var d = c.matrixTransform(b);
            c.x = a.x + a.width, c.y = a.y;
            var f = c.matrixTransform(b);
            c.x = a.x + a.width, c.y = a.y + a.height;
            var g = c.matrixTransform(b);
            c.x = a.x, c.y = a.y + a.height;
            var h = c.matrixTransform(b),
                i = Math.min(d.x, f.x, g.x, h.x),
                j = Math.max(d.x, f.x, g.x, h.x),
                k = Math.min(d.y, f.y, g.y, h.y),
                l = Math.max(d.y, f.y, g.y, h.y);
            return {
                x: i,
                y: k,
                width: j - i,
                height: l - k
            }
        }, d.transformPoint = function(a, b) {
            return d.createSVGPoint(a.x, a.y).matrixTransform(b)
        }, d.styleToObject = function(a) {
            for (var b = {}, c = a.split(";"), d = 0; d < c.length; d++) {
                var e = c[d],
                    f = e.split("=");
                b[f[0].trim()] = f[1].trim()
            }
            return b
        }, d.createSlicePathData = function(a, b, c, d) {
            var e = 2 * Math.PI - 1e-6,
                f = a,
                g = b,
                h = c,
                i = d,
                j = (i < h && (j = h, h = i, i = j), i - h),
                k = j < Math.PI ? "0" : "1",
                l = Math.cos(h),
                m = Math.sin(h),
                n = Math.cos(i),
                o = Math.sin(i);
            return j >= e ? f ? "M0," + g + "A" + g + "," + g + " 0 1,1 0," + -g + "A" + g + "," + g + " 0 1,1 0," + g + "M0," + f + "A" + f + "," + f + " 0 1,0 0," + -f + "A" + f + "," + f + " 0 1,0 0," + f + "Z" : "M0," + g + "A" + g + "," + g + " 0 1,1 0," + -g + "A" + g + "," + g + " 0 1,1 0," + g + "Z" : f ? "M" + g * l + "," + g * m + "A" + g + "," + g + " 0 " + k + ",1 " + g * n + "," + g * o + "L" + f * n + "," + f * o + "A" + f + "," + f + " 0 " + k + ",0 " + f * l + "," + f * m + "Z" : "M" + g * l + "," + g * m + "A" + g + "," + g + " 0 " + k + ",1 " + g * n + "," + g * o + "L0,0Z"
        }, d.mergeAttrs = function(a, b) {
            for (var c in b) "class" === c ? a[c] = a[c] ? a[c] + " " + b[c] : b[c] : "style" === c ? d.isObject(a[c]) && d.isObject(b[c]) ? a[c] = d.mergeAttrs(a[c], b[c]) : d.isObject(a[c]) ? a[c] = d.mergeAttrs(a[c], d.styleToObject(b[c])) : d.isObject(b[c]) ? a[c] = d.mergeAttrs(d.styleToObject(a[c]), b[c]) : a[c] = d.mergeAttrs(d.styleToObject(a[c]), d.styleToObject(b[c])) : a[c] = b[c];
            return a
        }, d.annotateString = function(a, b, c) {
            b = b || [], c = c || {};
            for (var e, f, g, h = c.offset || 0, i = [], j = [], k = 0; k < a.length; k++) {
                f = j[k] = a[k];
                for (var l = 0; l < b.length; l++) {
                    var m = b[l],
                        n = m.start + h,
                        o = m.end + h;
                    k >= n && k < o && (d.isObject(f) ? f.attrs = d.mergeAttrs(d.mergeAttrs({}, f.attrs), m.attrs) : f = j[k] = {
                        t: a[k],
                        attrs: m.attrs
                    }, c.includeAnnotationIndices && (f.annotations || (f.annotations = [])).push(l))
                }
                g = j[k - 1], g ? d.isObject(f) && d.isObject(g) ? JSON.stringify(f.attrs) === JSON.stringify(g.attrs) ? e.t += f.t : (i.push(e), e = f) : d.isObject(f) ? (i.push(e), e = f) : d.isObject(g) ? (i.push(e), e = f) : e = (e || "") + f : e = f
            }
            return e && i.push(e), i
        }, d.findAnnotationsAtIndex = function(a, b) {
            var c = [];
            return a && a.forEach(function(a) {
                a.start < b && b <= a.end && c.push(a)
            }), c
        }, d.findAnnotationsBetweenIndexes = function(a, b, c) {
            var d = [];
            return a && a.forEach(function(a) {
                (b >= a.start && b < a.end || c > a.start && c <= a.end || a.start >= b && a.end < c) && d.push(a)
            }), d
        }, d.shiftAnnotations = function(a, b, c) {
            return a && a.forEach(function(a) {
                a.start < b && a.end >= b ? a.end += c : a.start >= b && (a.start += c, a.end += c)
            }), a
        }, d.convertLineToPathData = function(a) {
            a = d(a);
            var b = ["M", a.attr("x1"), a.attr("y1"), "L", a.attr("x2"), a.attr("y2")].join(" ");
            return b
        }, d.convertPolygonToPathData = function(a) {
            var b = d.getPointsFromSvgNode(d(a).node);
            return b.length > 0 ? d.svgPointsToPath(b) + " Z" : null
        }, d.convertPolylineToPathData = function(a) {
            var b = d.getPointsFromSvgNode(d(a).node);
            return b.length > 0 ? d.svgPointsToPath(b) : null
        }, d.svgPointsToPath = function(a) {
            var b;
            for (b = 0; b < a.length; b++) a[b] = a[b].x + " " + a[b].y;
            return "M " + a.join(" L")
        }, d.getPointsFromSvgNode = function(a) {
            var b, c = [];
            for (b = 0; b < a.points.numberOfItems; b++) c.push(a.points.getItem(b));
            return c
        }, d.KAPPA = .5522847498307935, d.convertCircleToPathData = function(a) {
            a = d(a);
            var b = parseFloat(a.attr("cx")) || 0,
                c = parseFloat(a.attr("cy")) || 0,
                e = parseFloat(a.attr("r")),
                f = e * d.KAPPA,
                g = ["M", b, c - e, "C", b + f, c - e, b + e, c - f, b + e, c, "C", b + e, c + f, b + f, c + e, b, c + e, "C", b - f, c + e, b - e, c + f, b - e, c, "C", b - e, c - f, b - f, c - e, b, c - e, "Z"].join(" ");
            return g
        }, d.convertEllipseToPathData = function(a) {
            a = d(a);
            var b = parseFloat(a.attr("cx")) || 0,
                c = parseFloat(a.attr("cy")) || 0,
                e = parseFloat(a.attr("rx")),
                f = parseFloat(a.attr("ry")) || e,
                g = e * d.KAPPA,
                h = f * d.KAPPA,
                i = ["M", b, c - f, "C", b + g, c - f, b + e, c - h, b + e, c, "C", b + e, c + h, b + g, c + f, b, c + f, "C", b - g, c + f, b - e, c + h, b - e, c, "C", b - e, c - h, b - g, c - f, b, c - f, "Z"].join(" ");
            return i
        }, d.convertRectToPathData = function(a) {
            a = d(a);
            var b, c = parseFloat(a.attr("x")) || 0,
                e = parseFloat(a.attr("y")) || 0,
                f = parseFloat(a.attr("width")) || 0,
                h = parseFloat(a.attr("height")) || 0,
                i = parseFloat(a.attr("rx")) || 0,
                j = parseFloat(a.attr("ry")) || 0,
                k = g.rect(c, e, f, h);
            if (i || j) {
                var l = c + f,
                    m = e + h;
                b = ["M", c + i, e, "L", l - i, e, "Q", l, e, l, e + j, "L", l, e + h - j, "Q", l, m, l - i, m, "L", c + i, m, "Q", c, m, c, m - i, "L", c, e + j, "Q", c, e, c + i, e, "Z"].join(" ")
            } else b = ["M", k.origin().x, k.origin().y, "H", k.corner().x, "V", k.corner().y, "H", k.origin().x, "V", k.origin().y, "Z"].join(" ");
            return b
        }, d.rectToPath = function(a) {
            var b = a.rx || a["top-rx"] || 0,
                c = a.rx || a["bottom-rx"] || 0,
                d = a.ry || a["top-ry"] || 0,
                e = a.ry || a["bottom-ry"] || 0;
            return ["M", a.x, a.y + d, "v", a.height - d - e, "a", c, e, 0, 0, 0, c, e, "h", a.width - 2 * c, "a", c, e, 0, 0, 0, c, -e, "v", -(a.height - e - d), "a", b, d, 0, 0, 0, -b, -d, "h", -(a.width - 2 * b), "a", b, d, 0, 0, 0, -b, d].join(" ")
        }, d.toNode = function(a) {
            return d.isV(a) ? a.node : a.nodeName && a || a[0]
        }, d
    }();
    var joint = {
        version: "1.0.3",
        config: {
            classNamePrefix: "joint-",
            defaultTheme: "default"
        },
        dia: {},
        ui: {},
        layout: {},
        shapes: {},
        format: {},
        connectors: {},
        highlighters: {},
        routers: {},
        mvc: {
            views: {}
        },
        setTheme: function(a, b) {
            b = b || {}, _.invoke(joint.mvc.views, "setTheme", a, b), joint.mvc.View.prototype.defaultTheme = a
        },
        env: {
            _results: {},
            _tests: {
                svgforeignobject: function() {
                    return !!document.createElementNS && /SVGForeignObject/.test({}.toString.call(document.createElementNS("http://www.w3.org/2000/svg", "foreignObject")))
                }
            },
            addTest: function(a, b) {
                return joint.env._tests[a] = b
            },
            test: function(a) {
                var b = joint.env._tests[a];
                if (!b) throw new Error('Test not defined ("' + a + '"). Use `joint.env.addTest(name, fn) to add a new test.`');
                var c = joint.env._results[a];
                if ("undefined" != typeof c) return c;
                try {
                    c = b()
                } catch (a) {
                    c = !1
                }
                return joint.env._results[a] = c, c
            }
        },
        util: {
            hashCode: function(a) {
                var b = 0;
                if (0 == a.length) return b;
                for (var c = 0; c < a.length; c++) {
                    var d = a.charCodeAt(c);
                    b = (b << 5) - b + d, b &= b
                }
                return b
            },
            getByPath: function(a, b, c) {
                c = c || "/";
                for (var d, e = b.split(c); e.length;) {
                    if (d = e.shift(), !(Object(a) === a && d in a)) return;
                    a = a[d]
                }
                return a
            },
            setByPath: function(a, b, c, d) {
                d = d || "/";
                var e = b.split(d),
                    f = a,
                    g = 0;
                if (b.indexOf(d) > -1) {
                    for (var h = e.length; g < h - 1; g++) f = f[e[g]] || (f[e[g]] = {});
                    f[e[h - 1]] = c
                } else a[b] = c;
                return a
            },
            unsetByPath: function(a, b, c) {
                c = c || "/";
                var d = b.lastIndexOf(c);
                if (d > -1) {
                    var e = joint.util.getByPath(a, b.substr(0, d), c);
                    e && delete e[b.slice(d + 1)]
                } else delete a[b];
                return a
            },
            flattenObject: function(a, b, c) {
                b = b || "/";
                var d = {};
                for (var e in a)
                    if (a.hasOwnProperty(e)) {
                        var f = "object" == typeof a[e];
                        if (f && c && c(a[e]) && (f = !1), f) {
                            var g = this.flattenObject(a[e], b, c);
                            for (var h in g) g.hasOwnProperty(h) && (d[e + b + h] = g[h])
                        } else d[e] = a[e]
                    }
                return d
            },
            uuid: function() {
                return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function(a) {
                    var b = 16 * Math.random() | 0,
                        c = "x" == a ? b : 3 & b | 8;
                    return c.toString(16)
                })
            },
            guid: function(a) {
                return this.guid.id = this.guid.id || 1, a.id = void 0 === a.id ? "j_" + this.guid.id++ : a.id, a.id
            },
            mixin: _.assign,
            supplement: _.defaults,
            deepMixin: _.mixin,
            deepSupplement: _.defaultsDeep,
            normalizeEvent: function(a) {
                var b = a.originalEvent && a.originalEvent.changedTouches && a.originalEvent.changedTouches[0];
                if (b) {
                    for (var c in a) void 0 === b[c] && (b[c] = a[c]);
                    return b
                }
                return a
            },
            nextFrame: function() {
                var a;
                if ("undefined" != typeof window && (a = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame), !a) {
                    var b = 0;
                    a = function(a) {
                        var c = (new Date).getTime(),
                            d = Math.max(0, 16 - (c - b)),
                            e = setTimeout(function() {
                                a(c + d)
                            }, d);
                        return b = c + d, e
                    }
                }
                return function(b, c) {
                    return a(c ? _.bind(b, c) : b)
                }
            }(),
            cancelFrame: function() {
                var a, b = "undefined" != typeof window;
                return b && (a = window.cancelAnimationFrame || window.webkitCancelAnimationFrame || window.webkitCancelRequestAnimationFrame || window.msCancelAnimationFrame || window.msCancelRequestAnimationFrame || window.oCancelAnimationFrame || window.oCancelRequestAnimationFrame || window.mozCancelAnimationFrame || window.mozCancelRequestAnimationFrame), a = a || clearTimeout, b ? _.bind(a, window) : a
            }(),
            shapePerimeterConnectionPoint: function(a, b, c, d) {
                var e, f;
                if (!c) {
                    var h = b.$(".scalable")[0],
                        i = b.$(".rotatable")[0];
                    h && h.firstChild ? c = h.firstChild : i && i.firstChild && (c = i.firstChild)
                }
                return c ? (f = V(c).findIntersection(d, a.paper.viewport), f || (e = g.rect(V(c).bbox(!1, a.paper.viewport)))) : (e = b.model.getBBox(), f = e.intersectionWithLineFromCenterToPoint(d)), f || e.center()
            },
            breakText: function(a, b, c, d) {
                d = d || {};
                var e = b.width,
                    f = b.height,
                    g = d.svgDocument || V("svg").node,
                    h = V("<text><tspan></tspan></text>").attr(c || {}).node,
                    i = h.firstChild,
                    j = document.createTextNode("");
                h.style.opacity = 0, h.style.display = "block", i.style.display = "block", i.appendChild(j), g.appendChild(h), d.svgDocument || document.body.appendChild(g);
                for (var k, l = a.split(" "), m = [], n = [], o = 0, p = 0, q = l.length; o < q; o++) {
                    var r = l[o];
                    if (j.data = n[p] ? n[p] + " " + r : r, i.getComputedTextLength() <= e) n[p] = j.data, k && (m[p++] = !0, k = 0);
                    else {
                        if (!n[p] || k) {
                            var s = !!k;
                            if (k = r.length - 1, s || !k) {
                                if (!k) {
                                    if (!n[p]) {
                                        n = [];
                                        break
                                    }
                                    l.splice(o, 2, r + l[o + 1]), q--, m[p++] = !0, o--;
                                    continue
                                }
                                l[o] = r.substring(0, k), l[o + 1] = r.substring(k) + l[o + 1]
                            } else l.splice(o, 1, r.substring(0, k), r.substring(k)), q++, p && !m[p - 1] && p--;
                            o--;
                            continue
                        }
                        p++, o--
                    }
                    if ("undefined" != typeof f) {
                        var t = t || 1.25 * h.getBBox().height;
                        if (t * n.length > f) {
                            n.splice(Math.floor(f / t));
                            break
                        }
                    }
                }
                return d.svgDocument ? g.removeChild(h) : document.body.removeChild(g), n.join("\n")
            },
            imageToDataUri: function(a, b) {
                if (!a || "data:" === a.substr(0, "data:".length)) return setTimeout(function() {
                    b(null, a)
                }, 0);
                var c = function(b, c) {
                        if (200 === b.status) {
                            var d = new FileReader;
                            d.onload = function(a) {
                                var b = a.target.result;
                                c(null, b)
                            }, d.onerror = function() {
                                c(new Error("Failed to load image " + a))
                            }, d.readAsDataURL(b.response)
                        } else c(new Error("Failed to load image " + a))
                    },
                    d = function(b, c) {
                        var d = function(a) {
                            for (var b = 32768, c = [], d = 0; d < a.length; d += b) c.push(String.fromCharCode.apply(null, a.subarray(d, d + b)));
                            return c.join("")
                        };
                        if (200 === b.status) {
                            var e = new Uint8Array(b.response),
                                f = a.split(".").pop() || "png",
                                g = {
                                    svg: "svg+xml"
                                },
                                h = "data:image/" + (g[f] || f) + ";base64,",
                                i = h + btoa(d(e));
                            c(null, i)
                        } else c(new Error("Failed to load image " + a))
                    },
                    e = new XMLHttpRequest;
                e.open("GET", a, !0), e.addEventListener("error", function() {
                    b(new Error("Failed to load image " + a))
                }), e.responseType = window.FileReader ? "blob" : "arraybuffer", e.addEventListener("load", function() {
                    window.FileReader ? c(e, b) : d(e, b)
                }), e.send()
            },
            getElementBBox: function(a) {
                var b = $(a);
                if (0 === b.length) throw new Error("Element not found");
                var c = b[0],
                    d = c.ownerDocument,
                    e = c.getBoundingClientRect(),
                    f = 0,
                    g = 0;
                if (c.ownerSVGElement) {
                    var h = V(c).bbox();
                    f = e.width - h.width, g = e.height - h.height
                }
                return {
                    x: e.left + window.pageXOffset - d.documentElement.offsetLeft + f / 2,
                    y: e.top + window.pageYOffset - d.documentElement.offsetTop + g / 2,
                    width: e.width - f,
                    height: e.height - g
                }
            },
            sortElements: function(a, b) {
                var c = $(a),
                    d = c.map(function() {
                        var a = this,
                            b = a.parentNode,
                            c = b.insertBefore(document.createTextNode(""), a.nextSibling);
                        return function() {
                            if (b === this) throw new Error("You can't sort elements if any one is a descendant of another.");
                            b.insertBefore(this, c), b.removeChild(c)
                        }
                    });
                return Array.prototype.sort.call(c, b).each(function(a) {
                    d[a].call(this)
                })
            },
            setAttributesBySelector: function(a, b) {
                var c = $(a);
                _.each(b, function(a, b) {
                    var d = c.find(b).addBack().filter(b);
                    _.has(a, "class") && (d.addClass(a.class), a = _.omit(a, "class")), d.attr(a)
                })
            },
            normalizeSides: function(a) {
                return Object(a) !== a ? (a = a || 0, {
                    top: a,
                    bottom: a,
                    left: a,
                    right: a
                }) : {
                    top: a.top || 0,
                    bottom: a.bottom || 0,
                    left: a.left || 0,
                    right: a.right || 0
                }
            },
            timing: {
                linear: function(a) {
                    return a
                },
                quad: function(a) {
                    return a * a
                },
                cubic: function(a) {
                    return a * a * a
                },
                inout: function(a) {
                    if (a <= 0) return 0;
                    if (a >= 1) return 1;
                    var b = a * a,
                        c = b * a;
                    return 4 * (a < .5 ? c : 3 * (a - b) + c - .75)
                },
                exponential: function(a) {
                    return Math.pow(2, 10 * (a - 1))
                },
                bounce: function(a) {
                    for (var b = 0, c = 1; 1; b += c, c /= 2)
                        if (a >= (7 - 4 * b) / 11) {
                            var d = (11 - 6 * b - 11 * a) / 4;
                            return -d * d + c * c
                        }
                },
                reverse: function(a) {
                    return function(b) {
                        return 1 - a(1 - b)
                    }
                },
                reflect: function(a) {
                    return function(b) {
                        return .5 * (b < .5 ? a(2 * b) : 2 - a(2 - 2 * b))
                    }
                },
                clamp: function(a, b, c) {
                    return b = b || 0, c = c || 1,
                        function(d) {
                            var e = a(d);
                            return e < b ? b : e > c ? c : e
                        }
                },
                back: function(a) {
                    return a || (a = 1.70158),
                        function(b) {
                            return b * b * ((a + 1) * b - a)
                        }
                },
                elastic: function(a) {
                    return a || (a = 1.5),
                        function(b) {
                            return Math.pow(2, 10 * (b - 1)) * Math.cos(20 * Math.PI * a / 3 * b)
                        }
                }
            },
            interpolate: {
                number: function(a, b) {
                    var c = b - a;
                    return function(b) {
                        return a + c * b
                    }
                },
                object: function(a, b) {
                    var c = _.keys(a);
                    return function(d) {
                        var e, f, g = {};
                        for (e = c.length - 1; e != -1; e--) f = c[e], g[f] = a[f] + (b[f] - a[f]) * d;
                        return g
                    }
                },
                hexColor: function(a, b) {
                    var c = parseInt(a.slice(1), 16),
                        d = parseInt(b.slice(1), 16),
                        e = 255 & c,
                        f = (255 & d) - e,
                        g = 65280 & c,
                        h = (65280 & d) - g,
                        i = 16711680 & c,
                        j = (16711680 & d) - i;
                    return function(a) {
                        var b = e + f * a & 255,
                            c = g + h * a & 65280,
                            d = i + j * a & 16711680;
                        return "#" + (1 << 24 | b | c | d).toString(16).slice(1)
                    }
                },
                unit: function(a, b) {
                    var c = /(-?[0-9]*.[0-9]*)(px|em|cm|mm|in|pt|pc|%)/,
                        d = c.exec(a),
                        e = c.exec(b),
                        f = e[1].indexOf("."),
                        g = f > 0 ? e[1].length - f - 1 : 0;
                    a = +d[1];
                    var h = +e[1] - a,
                        i = d[2];
                    return function(b) {
                        return (a + h * b).toFixed(g) + i
                    }
                }
            },
            filter: {
                outline: function(a) {
                    var b = '<filter><feFlood flood-color="${color}" flood-opacity="${opacity}" result="colored"/><feMorphology in="SourceAlpha" result="morphedOuter" operator="dilate" radius="${outerRadius}" /><feMorphology in="SourceAlpha" result="morphedInner" operator="dilate" radius="${innerRadius}" /><feComposite result="morphedOuterColored" in="colored" in2="morphedOuter" operator="in"/><feComposite operator="xor" in="morphedOuterColored" in2="morphedInner" result="outline"/><feMerge><feMergeNode in="outline"/><feMergeNode in="SourceGraphic"/></feMerge></filter>',
                        c = _.isFinite(a.margin) ? a.margin : 2,
                        d = _.isFinite(a.width) ? a.width : 1;
                    return joint.util.template(b)({
                        color: a.color || "blue",
                        opacity: _.isFinite(a.opacity) ? a.opacity : 1,
                        outerRadius: c + d,
                        innerRadius: c
                    })
                },
                highlight: function(a) {
                    var b = '<filter><feFlood flood-color="${color}" flood-opacity="${opacity}" result="colored"/><feMorphology result="morphed" in="SourceGraphic" operator="dilate" radius="${width}"/><feComposite result="composed" in="colored" in2="morphed" operator="in"/><feGaussianBlur result="blured" in="composed" stdDeviation="${blur}"/><feBlend in="SourceGraphic" in2="blured" mode="normal"/></filter>';
                    return joint.util.template(b)({
                        color: a.color || "red",
                        width: _.isFinite(a.width) ? a.width : 1,
                        blur: _.isFinite(a.blur) ? a.blur : 0,
                        opacity: _.isFinite(a.opacity) ? a.opacity : 1
                    })
                },
                blur: function(a) {
                    var b = _.isFinite(a.x) ? a.x : 2;
                    return joint.util.template('<filter><feGaussianBlur stdDeviation="${stdDeviation}"/></filter>')({
                        stdDeviation: _.isFinite(a.y) ? [b, a.y] : b
                    })
                },
                dropShadow: function(a) {
                    var b = "SVGFEDropShadowElement" in window ? '<filter><feDropShadow stdDeviation="${blur}" dx="${dx}" dy="${dy}" flood-color="${color}" flood-opacity="${opacity}"/></filter>' : '<filter><feGaussianBlur in="SourceAlpha" stdDeviation="${blur}"/><feOffset dx="${dx}" dy="${dy}" result="offsetblur"/><feFlood flood-color="${color}"/><feComposite in2="offsetblur" operator="in"/><feComponentTransfer><feFuncA type="linear" slope="${opacity}"/></feComponentTransfer><feMerge><feMergeNode/><feMergeNode in="SourceGraphic"/></feMerge></filter>';
                    return joint.util.template(b)({
                        dx: a.dx || 0,
                        dy: a.dy || 0,
                        opacity: _.isFinite(a.opacity) ? a.opacity : 1,
                        color: a.color || "black",
                        blur: _.isFinite(a.blur) ? a.blur : 4
                    })
                },
                grayscale: function(a) {
                    var b = _.isFinite(a.amount) ? a.amount : 1;
                    return joint.util.template('<filter><feColorMatrix type="matrix" values="${a} ${b} ${c} 0 0 ${d} ${e} ${f} 0 0 ${g} ${b} ${h} 0 0 0 0 0 1 0"/></filter>')({
                        a: .2126 + .7874 * (1 - b),
                        b: .7152 - .7152 * (1 - b),
                        c: .0722 - .0722 * (1 - b),
                        d: .2126 - .2126 * (1 - b),
                        e: .7152 + .2848 * (1 - b),
                        f: .0722 - .0722 * (1 - b),
                        g: .2126 - .2126 * (1 - b),
                        h: .0722 + .9278 * (1 - b)
                    })
                },
                sepia: function(a) {
                    var b = _.isFinite(a.amount) ? a.amount : 1;
                    return joint.util.template('<filter><feColorMatrix type="matrix" values="${a} ${b} ${c} 0 0 ${d} ${e} ${f} 0 0 ${g} ${h} ${i} 0 0 0 0 0 1 0"/></filter>')({
                        a: .393 + .607 * (1 - b),
                        b: .769 - .769 * (1 - b),
                        c: .189 - .189 * (1 - b),
                        d: .349 - .349 * (1 - b),
                        e: .686 + .314 * (1 - b),
                        f: .168 - .168 * (1 - b),
                        g: .272 - .272 * (1 - b),
                        h: .534 - .534 * (1 - b),
                        i: .131 + .869 * (1 - b)
                    })
                },
                saturate: function(a) {
                    var b = _.isFinite(a.amount) ? a.amount : 1;
                    return joint.util.template('<filter><feColorMatrix type="saturate" values="${amount}"/></filter>')({
                        amount: 1 - b
                    })
                },
                hueRotate: function(a) {
                    return joint.util.template('<filter><feColorMatrix type="hueRotate" values="${angle}"/></filter>')({
                        angle: a.angle || 0
                    })
                },
                invert: function(a) {
                    var b = _.isFinite(a.amount) ? a.amount : 1;
                    return joint.util.template('<filter><feComponentTransfer><feFuncR type="table" tableValues="${amount} ${amount2}"/><feFuncG type="table" tableValues="${amount} ${amount2}"/><feFuncB type="table" tableValues="${amount} ${amount2}"/></feComponentTransfer></filter>')({
                        amount: b,
                        amount2: 1 - b
                    })
                },
                brightness: function(a) {
                    return joint.util.template('<filter><feComponentTransfer><feFuncR type="linear" slope="${amount}"/><feFuncG type="linear" slope="${amount}"/><feFuncB type="linear" slope="${amount}"/></feComponentTransfer></filter>')({
                        amount: _.isFinite(a.amount) ? a.amount : 1
                    })
                },
                contrast: function(a) {
                    var b = _.isFinite(a.amount) ? a.amount : 1;
                    return joint.util.template('<filter><feComponentTransfer><feFuncR type="linear" slope="${amount}" intercept="${amount2}"/><feFuncG type="linear" slope="${amount}" intercept="${amount2}"/><feFuncB type="linear" slope="${amount}" intercept="${amount2}"/></feComponentTransfer></filter>')({
                        amount: b,
                        amount2: .5 - b / 2
                    })
                }
            },
            format: {
                number: function(a, b, c) {
                    function d(a) {
                        for (var b = a.length, d = [], e = 0, f = c.grouping[0]; b > 0 && f > 0;) d.push(a.substring(b -= f, b + f)), f = c.grouping[e = (e + 1) % c.grouping.length];
                        return d.reverse().join(c.thousands)
                    }
                    c = c || {
                        currency: ["$", ""],
                        decimal: ".",
                        thousands: ",",
                        grouping: [3]
                    };
                    var e = /(?:([^{])?([<>=^]))?([+\- ])?([$#])?(0)?(\d+)?(,)?(\.-?\d+)?([a-z%])?/i,
                        f = e.exec(a),
                        g = f[1] || " ",
                        h = f[2] || ">",
                        i = f[3] || "",
                        j = f[4] || "",
                        k = f[5],
                        l = +f[6],
                        m = f[7],
                        n = f[8],
                        o = f[9],
                        p = 1,
                        q = "",
                        r = "",
                        s = !1;
                    switch (n && (n = +n.substring(1)), (k || "0" === g && "=" === h) && (k = g = "0", h = "=", m && (l -= Math.floor((l - 1) / 4))), o) {
                        case "n":
                            m = !0, o = "g";
                            break;
                        case "%":
                            p = 100, r = "%", o = "f";
                            break;
                        case "p":
                            p = 100, r = "%", o = "r";
                            break;
                        case "b":
                        case "o":
                        case "x":
                        case "X":
                            "#" === j && (q = "0" + o.toLowerCase());
                            break;
                        case "c":
                        case "d":
                            s = !0, n = 0;
                            break;
                        case "s":
                            p = -1, o = "r"
                    }
                    "$" === j && (q = c.currency[0], r = c.currency[1]), "r" != o || n || (o = "g"), null != n && ("g" == o ? n = Math.max(1, Math.min(21, n)) : "e" != o && "f" != o || (n = Math.max(0, Math.min(20, n))));
                    var t = k && m;
                    if (s && b % 1) return "";
                    var u = b < 0 || 0 === b && 1 / b < 0 ? (b = -b, "-") : i,
                        v = r;
                    if (p < 0) {
                        var w = this.prefix(b, n);
                        b = w.scale(b), v = w.symbol + r
                    } else b *= p;
                    b = this.convert(o, b, n);
                    var x = b.lastIndexOf("."),
                        y = x < 0 ? b : b.substring(0, x),
                        z = x < 0 ? "" : c.decimal + b.substring(x + 1);
                    !k && m && c.grouping && (y = d(y));
                    var A = q.length + y.length + z.length + (t ? 0 : u.length),
                        B = A < l ? new Array(A = l - A + 1).join(g) : "";
                    return t && (y = d(B + y)), u += q, b = y + z, ("<" === h ? u + b + B : ">" === h ? B + u + b : "^" === h ? B.substring(0, A >>= 1) + u + b + B.substring(A) : u + (t ? b : B + b)) + v
                },
                string: function(a, b) {
                    for (var c, d = "{", e = !1, f = [];
                        (c = a.indexOf(d)) !== -1;) {
                        var g, h, i;
                        if (g = a.slice(0, c), e) {
                            h = g.split(":"), i = h.shift().split("."), g = b;
                            for (var j = 0; j < i.length; j++) g = g[i[j]];
                            h.length && (g = this.number(h, g))
                        }
                        f.push(g), a = a.slice(c + 1), d = (e = !e) ? "}" : "{"
                    }
                    return f.push(a), f.join("")
                },
                convert: function(a, b, c) {
                    switch (a) {
                        case "b":
                            return b.toString(2);
                        case "c":
                            return String.fromCharCode(b);
                        case "o":
                            return b.toString(8);
                        case "x":
                            return b.toString(16);
                        case "X":
                            return b.toString(16).toUpperCase();
                        case "g":
                            return b.toPrecision(c);
                        case "e":
                            return b.toExponential(c);
                        case "f":
                            return b.toFixed(c);
                        case "r":
                            return (b = this.round(b, this.precision(b, c))).toFixed(Math.max(0, Math.min(20, this.precision(b * (1 + 1e-15), c))));
                        default:
                            return b + ""
                    }
                },
                round: function(a, b) {
                    return b ? Math.round(a * (b = Math.pow(10, b))) / b : Math.round(a)
                },
                precision: function(a, b) {
                    return b - (a ? Math.ceil(Math.log(a) / Math.LN10) : 1)
                },
                prefix: function(a, b) {
                    var c = _.map(["y", "z", "a", "f", "p", "n", "\xb5", "m", "", "k", "M", "G", "T", "P", "E", "Z", "Y"], function(a, b) {
                            var c = Math.pow(10, 3 * Math.abs(8 - b));
                            return {
                                scale: b > 8 ? function(a) {
                                    return a / c
                                } : function(a) {
                                    return a * c
                                },
                                symbol: a
                            }
                        }),
                        d = 0;
                    return a && (a < 0 && (a *= -1), b && (a = this.round(a, this.precision(a, b))), d = 1 + Math.floor(1e-12 + Math.log(a) / Math.LN10), d = Math.max(-24, Math.min(24, 3 * Math.floor((d <= 0 ? d + 1 : d - 1) / 3)))), c[8 + d / 3]
                }
            },
            template: function(a) {
                var b = /<%= ([^ ]+) %>|\$\{ ?([^\{\} ]+) ?\}|\{\{([^\{\} ]+)\}\}/g;
                return function(c) {
                    return c = c || {}, a.replace(b, function(a) {
                        for (var b = Array.prototype.slice.call(arguments), d = _.find(b.slice(1, 4), function(a) {
                                return !!a
                            }), e = d.split("."), f = c[e.shift()]; !_.isUndefined(f) && e.length;) f = f[e.shift()];
                        return _.isUndefined(f) ? "" : f
                    })
                }
            },
            toggleFullScreen: function(a) {
                function b(a, b) {
                    for (var c = ["webkit", "moz", "ms", "o", ""], d = 0; d < c.length; d++) {
                        var e = c[d],
                            f = e ? e + b : b.substr(0, 1).toLowerCase() + b.substr(1);
                        if (!_.isUndefined(a[f])) return _.isFunction(a[f]) ? a[f]() : a[f]
                    }
                }
                a = a || document.body, b(document, "FullScreen") || b(document, "IsFullScreen") ? b(document, "CancelFullScreen") : b(a, "RequestFullScreen")
            },
            addClassNamePrefix: function(a) {
                return a ? _.map(a.toString().split(" "), function(a) {
                    return a.substr(0, joint.config.classNamePrefix.length) !== joint.config.classNamePrefix && (a = joint.config.classNamePrefix + a), a
                }).join(" ") : a
            },
            removeClassNamePrefix: function(a) {
                return a ? _.map(a.toString().split(" "), function(a) {
                    return a.substr(0, joint.config.classNamePrefix.length) === joint.config.classNamePrefix && (a = a.substr(joint.config.classNamePrefix.length)), a
                }).join(" ") : a
            },
            wrapWith: function(a, b, c) {
                if (_.isString(c)) {
                    if (!joint.util.wrappers[c]) throw new Error('Unknown wrapper: "' + c + '"');
                    c = joint.util.wrappers[c]
                }
                if (!_.isFunction(c)) throw new Error("Wrapper must be a function.");
                _.each(b, function(b) {
                    a[b] = c(a[b])
                })
            },
            wrappers: {
                cells: function(a) {
                    return function() {
                        var b = Array.prototype.slice.call(arguments),
                            c = b.length > 0 && _.first(b) || [],
                            d = b.length > 1 && _.last(b) || {};
                        return _.isArray(c) || (d instanceof joint.dia.Cell ? (c = b, d = {}) : c = _.initial(b)), a.call(this, c, d)
                    }
                }
            }
        }
    };
    joint.mvc.View = Backbone.View.extend({
            options: {},
            theme: null,
            themeClassNamePrefix: joint.util.addClassNamePrefix("theme-"),
            requireSetThemeOverride: !1,
            defaultTheme: joint.config.defaultTheme,
            constructor: function(a) {
                Backbone.View.call(this, a)
            },
            initialize: function(a) {
                this.requireSetThemeOverride = a && !!a.theme, this.options = _.extend({}, this.options, a), _.bindAll(this, "setTheme", "onSetTheme", "remove", "onRemove"), joint.mvc.views[this.cid] = this, this.setTheme(this.options.theme || this.defaultTheme), this._ensureElClassName(), this.init()
            },
            _ensureElClassName: function() {
                var a = _.result(this, "className"),
                    b = joint.util.addClassNamePrefix(a);
                this.$el.removeClass(a), this.$el.addClass(b)
            },
            init: function() {},
            onRender: function() {},
            setTheme: function(a, b) {
                if (b = b || {}, !this.theme || !this.requireSetThemeOverride || b.override) return this.removeThemeClassName(), this.addThemeClassName(a), this.onSetTheme(this.theme, a), this.theme = a, this
            },
            addThemeClassName: function(a) {
                a = a || this.theme;
                var b = this.themeClassNamePrefix + a;
                return this.$el.addClass(b), this
            },
            removeThemeClassName: function(a) {
                a = a || this.theme;
                var b = this.themeClassNamePrefix + a;
                return this.$el.removeClass(b), this
            },
            onSetTheme: function(a, b) {},
            remove: function() {
                return this.onRemove(), joint.mvc.views[this.cid] = null, Backbone.View.prototype.remove.apply(this, arguments), this
            },
            onRemove: function() {}
        }),
        function() {
            joint.mvc.View._extend = joint.mvc.View.extend, joint.mvc.View.extend = function(a, b) {
                a = a || {};
                var c = a.render || this.prototype.render || null;
                return a.render = function() {
                    return c && c.apply(this, arguments), this.onRender(), this
                }, joint.mvc.View._extend.call(this, a, b)
            }
        }(), joint.dia.GraphCells = Backbone.Collection.extend({
            cellNamespace: joint.shapes,
            initialize: function(a, b) {
                b.cellNamespace && (this.cellNamespace = b.cellNamespace), this.graph = b.graph
            },
            model: function(a, b) {
                var c = b.collection,
                    d = c.cellNamespace,
                    e = "link" === a.type ? joint.dia.Link : joint.util.getByPath(d, a.type, ".") || joint.dia.Element,
                    f = new e(a, b);
                return f.graph = c.graph, f
            },
            comparator: function(a) {
                return a.get("z") || 0
            }
        }), joint.dia.Graph = Backbone.Model.extend({
            _batches: {},
            initialize: function(a, b) {
                b = b || {};
                var c = new joint.dia.GraphCells([], {
                    model: b.cellModel,
                    cellNamespace: b.cellNamespace,
                    graph: this
                });
                Backbone.Model.prototype.set.call(this, "cells", c), c.on("all", this.trigger, this), this.on("change:z", this._sortOnChangeZ, this), this.on("batch:stop", this._onBatchStop, this), this._out = {}, this._in = {}, this._nodes = {}, this._edges = {}, c.on("add", this._restructureOnAdd, this), c.on("remove", this._restructureOnRemove, this), c.on("reset", this._restructureOnReset, this), c.on("change:source", this._restructureOnChangeSource, this), c.on("change:target", this._restructureOnChangeTarget, this), c.on("remove", this._removeCell, this)
            },
            _sortOnChangeZ: function() {
                this.hasActiveBatch("to-front") || this.hasActiveBatch("to-back") || this.get("cells").sort()
            },
            _onBatchStop: function(a) {
                var b = a && a.batchName;
                "to-front" !== b && "to-back" !== b || this.hasActiveBatch(b) || this.get("cells").sort()
            },
            _restructureOnAdd: function(a) {
                if (a.isLink()) {
                    this._edges[a.id] = !0;
                    var b = a.get("source"),
                        c = a.get("target");
                    b.id && ((this._out[b.id] || (this._out[b.id] = {}))[a.id] = !0), c.id && ((this._in[c.id] || (this._in[c.id] = {}))[a.id] = !0)
                } else this._nodes[a.id] = !0
            },
            _restructureOnRemove: function(a) {
                if (a.isLink()) {
                    delete this._edges[a.id];
                    var b = a.get("source"),
                        c = a.get("target");
                    b.id && this._out[b.id] && this._out[b.id][a.id] && delete this._out[b.id][a.id], c.id && this._in[c.id] && this._in[c.id][a.id] && delete this._in[c.id][a.id]
                } else delete this._nodes[a.id]
            },
            _restructureOnReset: function(a) {
                a = a.models, this._out = {}, this._in = {}, this._nodes = {}, this._edges = {}, _.each(a, this._restructureOnAdd, this)
            },
            _restructureOnChangeSource: function(a) {
                var b = a.previous("source");
                b.id && this._out[b.id] && delete this._out[b.id][a.id];
                var c = a.get("source");
                c.id && ((this._out[c.id] || (this._out[c.id] = {}))[a.id] = !0)
            },
            _restructureOnChangeTarget: function(a) {
                var b = a.previous("target");
                b.id && this._in[b.id] && delete this._in[b.id][a.id];
                var c = a.get("target");
                c.id && ((this._in[c.id] || (this._in[c.id] = {}))[a.id] = !0)
            },
            getOutboundEdges: function(a) {
                return this._out && this._out[a] || {}
            },
            getInboundEdges: function(a) {
                return this._in && this._in[a] || {}
            },
            toJSON: function() {
                var a = Backbone.Model.prototype.toJSON.apply(this, arguments);
                return a.cells = this.get("cells").toJSON(), a
            },
            fromJSON: function(a, b) {
                if (!a.cells) throw new Error("Graph JSON must contain cells array.");
                return this.set(a, b)
            },
            set: function(a, b, c) {
                var d;
                return "object" == typeof a ? (d = a, c = b) : (d = {})[a] = b, d.hasOwnProperty("cells") && (this.resetCells(d.cells, c), d = _.omit(d, "cells")), Backbone.Model.prototype.set.call(this, d, c)
            },
            clear: function(a) {
                a = _.extend({}, a, {
                    clear: !0
                });
                var b = this.get("cells");
                if (0 === b.length) return this;
                this.startBatch("clear", a);
                var c = b.sortBy(function(a) {
                    return a.isLink() ? 1 : 2
                });
                do c.shift().remove(a); while (c.length > 0);
                return this.stopBatch("clear"), this
            },
            _prepareCell: function(a, b) {
                var c;
                if (a instanceof Backbone.Model ? (c = a.attributes, a.graph || b && b.dry || (a.graph = this)) : c = a, !_.isString(c.type)) throw new TypeError("dia.Graph: cell type must be a string.");
                return a
            },
            maxZIndex: function() {
                var a = this.get("cells").last();
                return a ? a.get("z") || 0 : 0
            },
            addCell: function(a, b) {
                return _.isArray(a) ? this.addCells(a, b) : (a instanceof Backbone.Model ? a.has("z") || a.set("z", this.maxZIndex() + 1) : _.isUndefined(a.z) && (a.z = this.maxZIndex() + 1), this.get("cells").add(this._prepareCell(a, b), b || {}), this)
            },
            addCells: function(a, b) {
                return a.length && (a = _.flattenDeep(a), b.position = a.length, this.startBatch("add"), _.each(a, function(a) {
                    b.position--, this.addCell(a, b)
                }, this), this.stopBatch("add")), this
            },
            resetCells: function(a, b) {
                var c = _.map(a, _.bind(this._prepareCell, this, _, b));
                return this.get("cells").reset(c, b), this
            },
            removeCells: function(a, b) {
                return a.length && (this.startBatch("remove"), _.invoke(a, "remove", b), this.stopBatch("remove")), this
            },
            _removeCell: function(a, b, c) {
                c = c || {}, c.clear || (c.disconnectLinks ? this.disconnectLinks(a, c) : this.removeLinks(a, c)), this.get("cells").remove(a, {
                    silent: !0
                }), a.graph === this && (a.graph = null)
            },
            getCell: function(a) {
                return this.get("cells").get(a)
            },
            getCells: function() {
                return this.get("cells").toArray()
            },
            getElements: function() {
                return _.map(this._nodes, function(a, b) {
                    return this.getCell(b)
                }, this)
            },
            getLinks: function() {
                return _.map(this._edges, function(a, b) {
                    return this.getCell(b)
                }, this)
            },
            getFirstCell: function() {
                return this.get("cells").first()
            },
            getLastCell: function() {
                return this.get("cells").last()
            },
            getConnectedLinks: function(a, b) {
                b = b || {};
                var c = b.inbound,
                    d = b.outbound;
                _.isUndefined(c) && _.isUndefined(d) && (c = d = !0);
                var e = [],
                    f = {};
                if (d && _.each(this.getOutboundEdges(a.id), function(a, b) {
                        f[b] || (e.push(this.getCell(b)), f[b] = !0)
                    }, this), c && _.each(this.getInboundEdges(a.id), function(a, b) {
                        f[b] || (e.push(this.getCell(b)), f[b] = !0)
                    }, this), b.deep) {
                    var g = a.getEmbeddedCells({
                            deep: !0
                        }),
                        h = {};
                    _.each(g, function(a) {
                        a.isLink() && (h[a.id] = !0)
                    }), _.each(g, function(a) {
                        a.isLink() || (d && _.each(this.getOutboundEdges(a.id), function(a, b) {
                            f[b] || h[b] || (e.push(this.getCell(b)), f[b] = !0)
                        }, this), c && _.each(this.getInboundEdges(a.id), function(a, b) {
                            f[b] || h[b] || (e.push(this.getCell(b)), f[b] = !0)
                        }, this))
                    }, this)
                }
                return e
            },
            getNeighbors: function(a, b) {
                b = b || {};
                var c = b.inbound,
                    d = b.outbound;
                _.isUndefined(c) && _.isUndefined(d) && (c = d = !0);
                var e = _.transform(this.getConnectedLinks(a, b), function(e, f) {
                    var g = f.get("source"),
                        h = f.get("target"),
                        i = f.hasLoop(b);
                    if (c && _.has(g, "id") && !e[g.id]) {
                        var j = this.getCell(g.id);
                        !i && (!j || j === a || b.deep && j.isEmbeddedIn(a)) || (e[g.id] = j)
                    }
                    if (d && _.has(h, "id") && !e[h.id]) {
                        var k = this.getCell(h.id);
                        !i && (!k || k === a || b.deep && k.isEmbeddedIn(a)) || (e[h.id] = k)
                    }
                }, {}, this);
                return _.values(e)
            },
            getCommonAncestor: function() {
                var a = _.map(arguments, function(a) {
                    for (var b = [], c = a.get("parent"); c;) b.push(c), c = this.getCell(c).get("parent");
                    return b
                }, this);
                a = _.sortBy(a, "length");
                var b = _.find(a.shift(), function(b) {
                    return _.every(a, function(a) {
                        return _.contains(a, b)
                    })
                });
                return this.getCell(b)
            },
            getSuccessors: function(a, b) {
                b = b || {};
                var c = [];
                return this.search(a, function(b) {
                    b !== a && c.push(b)
                }, _.extend({}, b, {
                    outbound: !0
                })), c
            },
            cloneCells: function(a) {
                a = _.unique(a);
                var b = _.transform(a, function(a, b) {
                    a[b.id] = b.clone()
                }, {});
                return _.each(a, function(a) {
                    var c = b[a.id];
                    if (c.isLink()) {
                        var d = c.get("source"),
                            e = c.get("target");
                        d.id && b[d.id] && c.prop("source/id", b[d.id].id), e.id && b[e.id] && c.prop("target/id", b[e.id].id)
                    }
                    var f = a.get("parent");
                    f && b[f] && c.set("parent", b[f].id);
                    var g = _.reduce(a.get("embeds"), function(a, c) {
                        return b[c] && a.push(b[c].id), a
                    }, []);
                    _.isEmpty(g) || c.set("embeds", g)
                }), b
            },
            cloneSubgraph: function(a, b) {
                var c = this.getSubgraph(a, b);
                return this.cloneCells(c)
            },
            getSubgraph: function(a, b) {
                b = b || {};
                var c = [],
                    d = {},
                    e = [],
                    f = [];
                return _.each(a, function(a) {
                    if (d[a.id] || (c.push(a), d[a.id] = a, a.isLink() ? f.push(a) : e.push(a)), b.deep) {
                        var g = a.getEmbeddedCells({
                            deep: !0
                        });
                        _.each(g, function(a) {
                            d[a.id] || (c.push(a), d[a.id] = a, a.isLink() ? f.push(a) : e.push(a))
                        })
                    }
                }), _.each(f, function(a) {
                    var b = a.get("source"),
                        f = a.get("target");
                    if (b.id && !d[b.id]) {
                        var g = this.getCell(b.id);
                        c.push(g), d[g.id] = g, e.push(g)
                    }
                    if (f.id && !d[f.id]) {
                        var h = this.getCell(f.id);
                        c.push(this.getCell(f.id)), d[h.id] = h, e.push(h)
                    }
                }, this), _.each(e, function(a) {
                    var e = this.getConnectedLinks(a, b);
                    _.each(e, function(a) {
                        var b = a.get("source"),
                            e = a.get("target");
                        !d[a.id] && b.id && d[b.id] && e.id && d[e.id] && (c.push(a), d[a.id] = a)
                    })
                }, this), c
            },
            getPredecessors: function(a, b) {
                b = b || {};
                var c = [];
                return this.search(a, function(b) {
                    b !== a && c.push(b)
                }, _.extend({}, b, {
                    inbound: !0
                })), c
            },
            search: function(a, b, c) {
                c = c || {}, c.breadthFirst ? this.bfs(a, b, c) : this.dfs(a, b, c)
            },
            bfs: function(a, b, c) {
                c = c || {};
                var d = {},
                    e = {},
                    f = [];
                for (f.push(a), e[a.id] = 0; f.length > 0;) {
                    var g = f.shift();
                    if (!d[g.id]) {
                        if (d[g.id] = !0, b(g, e[g.id]) === !1) return;
                        _.each(this.getNeighbors(g, c), function(a) {
                            e[a.id] = e[g.id] + 1, f.push(a)
                        })
                    }
                }
            },
            dfs: function(a, b, c, d, e) {
                c = c || {};
                var f = d || {},
                    g = e || 0;
                b(a, g) !== !1 && (f[a.id] = !0, _.each(this.getNeighbors(a, c), function(a) {
                    f[a.id] || this.dfs(a, b, c, f, g + 1)
                }, this))
            },
            getSources: function() {
                var a = [];
                return _.each(this._nodes, function(b, c) {
                    this._in[c] && !_.isEmpty(this._in[c]) || a.push(this.getCell(c))
                }, this), a
            },
            getSinks: function() {
                var a = [];
                return _.each(this._nodes, function(b, c) {
                    this._out[c] && !_.isEmpty(this._out[c]) || a.push(this.getCell(c))
                }, this), a
            },
            isSource: function(a) {
                return !this._in[a.id] || _.isEmpty(this._in[a.id])
            },
            isSink: function(a) {
                return !this._out[a.id] || _.isEmpty(this._out[a.id])
            },
            isSuccessor: function(a, b) {
                var c = !1;
                return this.search(a, function(d) {
                    if (d === b && d !== a) return c = !0, !1
                }, {
                    outbound: !0
                }), c
            },
            isPredecessor: function(a, b) {
                var c = !1;
                return this.search(a, function(d) {
                    if (d === b && d !== a) return c = !0, !1
                }, {
                    inbound: !0
                }), c
            },
            isNeighbor: function(a, b, c) {
                c = c || {};
                var d = c.inbound,
                    e = c.outbound;
                _.isUndefined(d) && _.isUndefined(e) && (d = e = !0);
                var f = !1;
                return _.each(this.getConnectedLinks(a, c), function(a) {
                    var c = a.get("source"),
                        g = a.get("target");
                    return d && _.has(c, "id") && c.id === b.id ? (f = !0, !1) : e && _.has(g, "id") && g.id === b.id ? (f = !0, !1) : void 0
                }), f
            },
            disconnectLinks: function(a, b) {
                _.each(this.getConnectedLinks(a), function(c) {
                    c.set(c.get("source").id === a.id ? "source" : "target", g.point(0, 0), b)
                })
            },
            removeLinks: function(a, b) {
                _.invoke(this.getConnectedLinks(a), "remove", b)
            },
            findModelsFromPoint: function(a) {
                return _.filter(this.getElements(), function(b) {
                    return b.getBBox().containsPoint(a)
                })
            },
            findModelsInArea: function(a, b) {
                a = g.rect(a), b = _.defaults(b || {}, {
                    strict: !1
                });
                var c = b.strict ? "containsRect" : "intersect";
                return _.filter(this.getElements(), function(b) {
                    return a[c](b.getBBox())
                })
            },
            findModelsUnderElement: function(a, b) {
                b = _.defaults(b || {}, {
                    searchBy: "bbox"
                });
                var c = a.getBBox(),
                    d = "bbox" == b.searchBy ? this.findModelsInArea(c) : this.findModelsFromPoint(c[b.searchBy]());
                return _.reject(d, function(b) {
                    return a.id == b.id || b.isEmbeddedIn(a)
                })
            },
            getBBox: function(a, b) {
                return this.getCellsBBox(a || this.getElements(), b)
            },
            getCellsBBox: function(a, b) {
                return _.reduce(a, function(a, c) {
                    return c.isLink() ? a : a ? a.union(c.getBBox(b)) : c.getBBox(b)
                }, null)
            },
            translate: function(a, b, c) {
                var d = _.reject(this.getCells(), function(a) {
                    return a.isEmbedded()
                });
                _.invoke(d, "translate", a, b, c)
            },
            resize: function(a, b, c) {
                return this.resizeCells(a, b, this.getCells(), c)
            },
            resizeCells: function(a, b, c, d) {
                var e = this.getCellsBBox(c);
                if (e) {
                    var f = Math.max(a / e.width, 0),
                        g = Math.max(b / e.height, 0);
                    _.invoke(c, "scale", f, g, e.origin(), d)
                }
                return this
            },
            startBatch: function(a, b) {
                return b = b || {}, this._batches[a] = (this._batches[a] || 0) + 1, this.trigger("batch:start", _.extend({}, b, {
                    batchName: a
                }))
            },
            stopBatch: function(a, b) {
                return b = b || {}, this._batches[a] = (this._batches[a] || 0) - 1, this.trigger("batch:stop", _.extend({}, b, {
                    batchName: a
                }))
            },
            hasActiveBatch: function(a) {
                return a ? this._batches[a] : _.any(this._batches, function(a) {
                    return a > 0
                })
            }
        }), joint.util.wrapWith(joint.dia.Graph.prototype, ["resetCells", "addCells", "removeCells"], "cells"), joint.dia.Cell = Backbone.Model.extend({
            constructor: function(a, b) {
                var c, d = a || {};
                this.cid = _.uniqueId("c"), this.attributes = {}, b && b.collection && (this.collection = b.collection), b && b.parse && (d = this.parse(d, b) || {}), (c = _.result(this, "defaults")) && (d = _.merge({}, c, d)), this.set(d, b), this.changed = {}, this.initialize.apply(this, arguments)
            },
            translate: function(a, b, c) {
                throw new Error("Must define a translate() method.")
            },
            toJSON: function() {
                var a = this.constructor.prototype.defaults.attrs || {},
                    b = this.attributes.attrs,
                    c = {};
                _.each(b, function(b, d) {
                    var e = a[d];
                    _.each(b, function(a, b) {
                        _.isObject(a) && !_.isArray(a) ? _.each(a, function(a, f) {
                            e && e[b] && _.isEqual(e[b][f], a) || (c[d] = c[d] || {}, (c[d][b] || (c[d][b] = {}))[f] = a)
                        }) : e && _.isEqual(e[b], a) || (c[d] = c[d] || {}, c[d][b] = a)
                    })
                });
                var d = _.cloneDeep(_.omit(this.attributes, "attrs"));
                return d.attrs = c, d
            },
            initialize: function(a) {
                a && a.id || this.set("id", joint.util.uuid(), {
                    silent: !0
                }), this._transitionIds = {}, this.processPorts(), this.on("change:attrs", this.processPorts, this)
            },
            processPorts: function() {
                var a = this.ports,
                    b = {};
                _.each(this.get("attrs"), function(a, c) {
                    a && a.port && (_.isUndefined(a.port.id) ? b[a.port] = {
                        id: a.port
                    } : b[a.port.id] = a.port)
                });
                var c = {};
                if (_.each(a, function(a, d) {
                        b[d] || (c[d] = !0)
                    }), this.graph && !_.isEmpty(c)) {
                    var d = this.graph.getConnectedLinks(this, {
                        inbound: !0
                    });
                    _.each(d, function(a) {
                        c[a.get("target").port] && a.remove()
                    });
                    var e = this.graph.getConnectedLinks(this, {
                        outbound: !0
                    });
                    _.each(e, function(a) {
                        c[a.get("source").port] && a.remove()
                    })
                }
                this.ports = b
            },
            remove: function(a) {
                a = a || {};
                var b = this.graph;
                b && b.startBatch("remove");
                var c = this.get("parent");
                if (c) {
                    var d = b && b.getCell(c);
                    d.unembed(this)
                }
                return _.invoke(this.getEmbeddedCells(), "remove", a), this.trigger("remove", this, this.collection, a), b && b.stopBatch("remove"), this
            },
            toFront: function(a) {
                if (this.graph) {
                    a = a || {};
                    var b = (this.graph.getLastCell().get("z") || 0) + 1;
                    if (this.startBatch("to-front").set("z", b, a), a.deep) {
                        var c = this.getEmbeddedCells({
                            deep: !0,
                            breadthFirst: !0
                        });
                        _.each(c, function(c) {
                            c.set("z", ++b, a)
                        })
                    }
                    this.stopBatch("to-front")
                }
                return this
            },
            toBack: function(a) {
                if (this.graph) {
                    a = a || {};
                    var b = (this.graph.getFirstCell().get("z") || 0) - 1;
                    if (this.startBatch("to-back"), a.deep) {
                        var c = this.getEmbeddedCells({
                            deep: !0,
                            breadthFirst: !0
                        });
                        _.eachRight(c, function(c) {
                            c.set("z", b--, a)
                        })
                    }
                    this.set("z", b, a).stopBatch("to-back")
                }
                return this
            },
            embed: function(a, b) {
                if (this === a || this.isEmbeddedIn(a)) throw new Error("Recursive embedding not allowed.");
                this.startBatch("embed");
                var c = _.clone(this.get("embeds") || []);
                return c[a.isLink() ? "unshift" : "push"](a.id), a.set("parent", this.id, b), this.set("embeds", _.uniq(c), b), this.stopBatch("embed"), this
            },
            unembed: function(a, b) {
                return this.startBatch("unembed"), a.unset("parent", b), this.set("embeds", _.without(this.get("embeds"), a.id), b), this.stopBatch("unembed"), this
            },
            getAncestors: function() {
                var a = [],
                    b = this.get("parent");
                if (!this.graph) return a;
                for (; void 0 !== b;) {
                    var c = this.graph.getCell(b);
                    if (void 0 === c) break;
                    a.push(c), b = c.get("parent")
                }
                return a
            },
            getEmbeddedCells: function(a) {
                if (a = a || {}, this.graph) {
                    var b;
                    if (a.deep)
                        if (a.breadthFirst) {
                            b = [];
                            for (var c = this.getEmbeddedCells(); c.length > 0;) {
                                var d = c.shift();
                                b.push(d), c.push.apply(c, d.getEmbeddedCells())
                            }
                        } else b = this.getEmbeddedCells(), _.each(b, function(c) {
                            b.push.apply(b, c.getEmbeddedCells(a))
                        });
                    else b = _.map(this.get("embeds"), this.graph.getCell, this.graph);
                    return b
                }
                return []
            },
            isEmbeddedIn: function(a, b) {
                var c = _.isString(a) ? a : a.id,
                    d = this.get("parent");
                if (b = _.defaults({
                        deep: !0
                    }, b), this.graph && b.deep) {
                    for (; d;) {
                        if (d === c) return !0;
                        d = this.graph.getCell(d).get("parent")
                    }
                    return !1
                }
                return d === c
            },
            isEmbedded: function() {
                return !!this.get("parent")
            },
            clone: function(a) {
                if (a = a || {}, a.deep) return _.values(joint.dia.Graph.prototype.cloneCells.call(null, [this].concat(this.getEmbeddedCells({
                    deep: !0
                }))));
                var b = Backbone.Model.prototype.clone.apply(this, arguments);
                return b.set("id", joint.util.uuid()), b.unset("embeds"), b.unset("parent"), b
            },
            prop: function(a, b, c) {
                var d = "/";
                if (_.isString(a)) {
                    if (arguments.length > 1) {
                        var e = a,
                            f = e.split("/"),
                            g = f[0];
                        if (f.shift(), c = c || {}, c.propertyPath = e, c.propertyValue = b, 0 === f.length) return this.set(g, b, c);
                        var h = {},
                            i = h,
                            j = g;
                        _.each(f, function(a) {
                            i = i[j] = _.isFinite(Number(a)) ? [] : {}, j = a
                        }), h = joint.util.setByPath(h, e, b, "/");
                        var k = _.merge({}, this.attributes);
                        c.rewrite && joint.util.unsetByPath(k, e, "/");
                        var l = _.merge(k, h);
                        return this.set(g, l[g], c)
                    }
                    return joint.util.getByPath(this.attributes, a, d)
                }
                return this.set(_.merge({}, this.attributes, a), b)
            },
            removeProp: function(a, b) {
                b = b || {}, b.dirty = !0;
                var c = a.split("/");
                if (1 === c.length) return this.unset(a, b);
                var d = c[0],
                    e = c.slice(1).join("/"),
                    f = _.merge({}, this.get(d));
                return joint.util.unsetByPath(f, e, "/"), this.set(d, f, b)
            },
            attr: function(a, b, c) {
                var d = Array.prototype.slice.call(arguments);
                return _.isString(a) ? d[0] = "attrs/" + a : d[0] = {
                    attrs: a
                }, this.prop.apply(this, d)
            },
            removeAttr: function(a, b) {
                return _.isArray(a) ? (_.each(a, function(a) {
                    this.removeAttr(a, b)
                }, this), this) : this.removeProp("attrs/" + a, b)
            },
            transition: function(a, b, c, d) {
                d = d || "/";
                var e = {
                    duration: 100,
                    delay: 10,
                    timingFunction: joint.util.timing.linear,
                    valueFunction: joint.util.interpolate.number
                };
                c = _.extend(e, c);
                var f, g = 0,
                    h = _.bind(function(b) {
                        var d, e, i;
                        g = g || b, b -= g, e = b / c.duration, e < 1 ? this._transitionIds[a] = d = joint.util.nextFrame(h) : (e = 1, delete this._transitionIds[a]), i = f(c.timingFunction(e)), c.transitionId = d, this.prop(a, i, c), d || this.trigger("transition:end", this, a)
                    }, this),
                    i = _.bind(function(e) {
                        this.stopTransitions(a), f = c.valueFunction(joint.util.getByPath(this.attributes, a, d), b), this._transitionIds[a] = joint.util.nextFrame(e), this.trigger("transition:start", this, a)
                    }, this);
                return _.delay(i, c.delay, h)
            },
            getTransitions: function() {
                return _.keys(this._transitionIds)
            },
            stopTransitions: function(a, b) {
                b = b || "/";
                var c = a && a.split(b);
                return _(this._transitionIds).keys().filter(c && function(a) {
                    return _.isEqual(c, a.split(b).slice(0, c.length))
                }).each(function(a) {
                    joint.util.cancelFrame(this._transitionIds[a]), delete this._transitionIds[a], this.trigger("transition:end", this, a)
                }, this), this
            },
            addTo: function(a, b) {
                return a.addCell(this, b), this
            },
            findView: function(a) {
                return a.findViewByModel(this)
            },
            isElement: function() {
                return !1
            },
            isLink: function() {
                return !1
            },
            startBatch: function(a, b) {
                return this.graph && this.graph.startBatch(a, _.extend({}, b, {
                    cell: this
                })), this
            },
            stopBatch: function(a, b) {
                return this.graph && this.graph.stopBatch(a, _.extend({}, b, {
                    cell: this
                })), this
            }
        }), joint.dia.CellView = joint.mvc.View.extend({
            tagName: "g",
            className: function() {
                var a = ["cell"],
                    b = this.model.get("type");
                return b && _.each(b.toLowerCase().split("."), function(b, c, d) {
                    a.push("type-" + d.slice(0, c + 1).join("-"))
                }), a.join(" ")
            },
            attributes: function() {
                return {
                    "model-id": this.model.id
                }
            },
            constructor: function(a) {
                a.id = a.id || joint.util.guid(this), joint.mvc.View.call(this, a)
            },
            init: function() {
                _.bindAll(this, "remove", "update"), this.$el.data("view", this), this.$el.attr("data-type", this.model.get("type")), this.listenTo(this.model, "change:attrs", this.onChangeAttrs)
            },
            onChangeAttrs: function(a, b, c) {
                return c.dirty ? this.render() : this.update(a, b, c)
            },
            can: function(a) {
                var b = _.isFunction(this.options.interactive) ? this.options.interactive(this) : this.options.interactive;
                return _.isObject(b) && b[a] !== !1 || _.isBoolean(b) && b !== !1
            },
            _ensureElement: function() {
                var a;
                if (this.el) a = _.result(this, "el");
                else {
                    var b = _.extend({
                        id: this.id
                    }, _.result(this, "attributes"));
                    this.className && (b.class = _.result(this, "className")), a = V(_.result(this, "tagName"), b).node
                }
                this.setElement(a, !1)
            },
            _setElement: function(a) {
                this.$el = a instanceof Backbone.$ ? a : Backbone.$(a), this.el = this.$el[0], this.vel = V(this.el)
            },
            findBySelector: function(a) {
                var b = "." === a ? this.$el : this.$el.find(a);
                return b
            },
            notify: function(a) {
                if (this.paper) {
                    var b = Array.prototype.slice.call(arguments, 1);
                    this.trigger.apply(this, [a].concat(b)), this.paper.trigger.apply(this.paper, [a, this].concat(b))
                }
            },
            getStrokeBBox: function(a) {
                var b = !!a;
                a = a || this.el;
                var c, d = V(a).bbox(!1, this.paper.viewport);
                return c = b ? V(a).attr("stroke-width") : this.model.attr("rect/stroke-width") || this.model.attr("circle/stroke-width") || this.model.attr("ellipse/stroke-width") || this.model.attr("path/stroke-width"), c = parseFloat(c) || 0, g.rect(d).moveAndExpand({
                    x: -c / 2,
                    y: -c / 2,
                    width: c,
                    height: c
                })
            },
            getBBox: function() {
                return g.rect(this.vel.bbox())
            },
            highlight: function(a, b) {
                return a = a ? this.$(a)[0] || this.el : this.el, b = b || {}, b.partial = a !== this.el, this.notify("cell:highlight", a, b), this
            },
            unhighlight: function(a, b) {
                return a = a ? this.$(a)[0] || this.el : this.el, b = b || {}, b.partial = a != this.el, this.notify("cell:unhighlight", a, b), this
            },
            findMagnet: function(a) {
                var b = this.$(a),
                    c = this.$el;
                0 === b.length && (b = c);
                do {
                    var d = b.attr("magnet");
                    if ((d || b.is(c)) && "false" !== d) return b[0];
                    b = b.parent()
                } while (b.length > 0)
            },
            applyFilter: function(a, b) {
                var c = _.isString(a) ? this.findBySelector(a) : $(a),
                    d = b.name + this.paper.svg.id + joint.util.hashCode(JSON.stringify(b));
                if (!this.paper.svg.getElementById(d)) {
                    var e = joint.util.filter[b.name] && joint.util.filter[b.name](b.args || {});
                    if (!e) throw new Error("Non-existing filter " + b.name);
                    var f = V(e);
                    f.attr({
                        filterUnits: "objectBoundingBox",
                        x: -1,
                        y: -1,
                        width: 3,
                        height: 3
                    }), b.attrs && f.attr(b.attrs), f.node.id = d, V(this.paper.svg).defs().append(f)
                }
                c.each(function() {
                    V(this).attr("filter", "url(#" + d + ")")
                })
            },
            applyGradient: function(a, b, c) {
                var d = _.isString(a) ? this.findBySelector(a) : $(a),
                    e = c.type + this.paper.svg.id + joint.util.hashCode(JSON.stringify(c));
                if (!this.paper.svg.getElementById(e)) {
                    var f = ["<" + c.type + ">", _.map(c.stops, function(a) {
                            return '<stop offset="' + a.offset + '" stop-color="' + a.color + '" stop-opacity="' + (_.isFinite(a.opacity) ? a.opacity : 1) + '" />'
                        }).join(""), "</" + c.type + ">"].join(""),
                        g = V(f);
                    c.attrs && g.attr(c.attrs), g.node.id = e, V(this.paper.svg).defs().append(g)
                }
                d.each(function() {
                    V(this).attr(b, "url(#" + e + ")")
                })
            },
            getSelector: function(a, b) {
                if (a === this.el) return b;
                var c;
                if (a) {
                    var d = V(a).index() + 1;
                    c = a.tagName + ":nth-child(" + d + ")", b && (c += " > " + b), c = this.getSelector(a.parentNode, c)
                }
                return c
            },
            pointerdblclick: function(a, b, c) {
                this.notify("cell:pointerdblclick", a, b, c)
            },
            pointerclick: function(a, b, c) {
                this.notify("cell:pointerclick", a, b, c)
            },
            pointerdown: function(a, b, c) {
                this.model.graph && (this.model.startBatch("pointer"), this._graph = this.model.graph), this.notify("cell:pointerdown", a, b, c)
            },
            pointermove: function(a, b, c) {
                this.notify("cell:pointermove", a, b, c)
            },
            pointerup: function(a, b, c) {
                this.notify("cell:pointerup", a, b, c), this._graph && (this._graph.stopBatch("pointer", {
                    cell: this.model
                }), delete this._graph)
            },
            mouseover: function(a) {
                this.notify("cell:mouseover", a)
            },
            mouseout: function(a) {
                this.notify("cell:mouseout", a)
            },
            mousewheel: function(a, b, c, d) {
                this.notify("cell:mousewheel", a, b, c, d)
            },
            contextmenu: function(a, b, c) {
                this.notify("cell:contextmenu", a, b, c)
            },
            setInteractivity: function(a) {
                this.options.interactive = a
            }
        }), joint.dia.Element = joint.dia.Cell.extend({
            defaults: {
                position: {
                    x: 0,
                    y: 0
                },
                size: {
                    width: 1,
                    height: 1
                },
                angle: 0
            },
            initialize: function() {
                this._initializePorts(), joint.dia.Cell.prototype.initialize.apply(this, arguments)
            },
            _initializePorts: function() {},
            isElement: function() {
                return !0
            },
            position: function(a, b, c) {
                var d = _.isNumber(b);
                if (c = (d ? c : a) || {}, c.parentRelative) {
                    if (!this.graph) throw new Error("Element must be part of a graph.");
                    var e = this.graph.getCell(this.get("parent")),
                        f = e && !e.isLink() ? e.get("position") : {
                            x: 0,
                            y: 0
                        }
                }
                if (d) return c.parentRelative && (a += f.x, b += f.y), this.set("position", {
                    x: a,
                    y: b
                }, c);
                var h = g.point(this.get("position"));
                return c.parentRelative ? h.difference(f) : h
            },
            translate: function(a, b, c) {
                if (a = a || 0, b = b || 0, 0 === a && 0 === b) return this;
                c = c || {}, c.translateBy = c.translateBy || this.id;
                var d = this.get("position") || {
                    x: 0,
                    y: 0
                };
                if (c.restrictedArea && c.translateBy === this.id) {
                    var e = this.getBBox({
                            deep: !0
                        }),
                        f = c.restrictedArea,
                        g = d.x - e.x,
                        h = d.y - e.y,
                        i = Math.max(f.x + g, Math.min(f.x + f.width + g - e.width, d.x + a)),
                        j = Math.max(f.y + h, Math.min(f.y + f.height + h - e.height, d.y + b));
                    a = i - d.x, b = j - d.y
                }
                var k = {
                    x: d.x + a,
                    y: d.y + b
                };
                return c.tx = a, c.ty = b, c.transition ? (_.isObject(c.transition) || (c.transition = {}), this.transition("position", k, _.extend({}, c.transition, {
                    valueFunction: joint.util.interpolate.object
                }))) : this.set("position", k, c), _.invoke(this.getEmbeddedCells(), "translate", a, b, c), this
            },
            resize: function(a, b, c) {
                if (c = c || {}, this.startBatch("resize", c), c.direction) {
                    var d = this.get("size");
                    switch (c.direction) {
                        case "left":
                        case "right":
                            b = d.height;
                            break;
                        case "top":
                        case "bottom":
                            a = d.width
                    }
                    var e = g.normalizeAngle(this.get("angle") || 0),
                        f = {
                            "top-right": 0,
                            right: 0,
                            "top-left": 1,
                            top: 1,
                            "bottom-left": 2,
                            left: 2,
                            "bottom-right": 3,
                            bottom: 3
                        }[c.direction];
                    c.absolute && (f += Math.floor((e + 45) / 90), f %= 4);
                    var h = this.getBBox(),
                        i = h[["bottomLeft", "corner", "topRight", "origin"][f]](),
                        j = g.point(i).rotate(h.center(), -e),
                        k = Math.sqrt(a * a + b * b) / 2,
                        l = f * Math.PI / 2;
                    l += Math.atan(f % 2 == 0 ? b / a : a / b), l -= g.toRad(e);
                    var m = g.point.fromPolar(k, l, j),
                        n = g.point(m).offset(a / -2, b / -2);
                    this.set("size", {
                        width: a,
                        height: b
                    }, c), this.position(n.x, n.y, c)
                } else this.set("size", {
                    width: a,
                    height: b
                }, c);
                return this.stopBatch("resize", c), this
            },
            scale: function(a, b, c, d) {
                var e = this.getBBox().scale(a, b, c);
                return this.startBatch("scale", d), this.position(e.x, e.y, d), this.resize(e.width, e.height, d), this.stopBatch("scale"), this
            },
            fitEmbeds: function(a) {
                if (a = a || {}, !this.graph) throw new Error("Element must be part of a graph.");
                var b = this.getEmbeddedCells();
                if (b.length > 0) {
                    this.startBatch("fit-embeds", a), a.deep && _.invoke(b, "fitEmbeds", a);
                    var c = this.graph.getCellsBBox(b),
                        d = joint.util.normalizeSides(a.padding);
                    c.moveAndExpand({
                        x: -d.left,
                        y: -d.top,
                        width: d.right + d.left,
                        height: d.bottom + d.top
                    }), this.set({
                        position: {
                            x: c.x,
                            y: c.y
                        },
                        size: {
                            width: c.width,
                            height: c.height
                        }
                    }, a), this.stopBatch("fit-embeds")
                }
                return this
            },
            rotate: function(a, b, c, d) {
                if (c) {
                    var e = this.getBBox().center(),
                        f = this.get("size"),
                        g = this.get("position");
                    e.rotate(c, this.get("angle") - a);
                    var h = e.x - f.width / 2 - g.x,
                        i = e.y - f.height / 2 - g.y;
                    this.startBatch("rotate", {
                        angle: a,
                        absolute: b,
                        origin: c
                    }), this.translate(h, i, _.clone(d)), this.rotate(a, b, null, d), this.stopBatch("rotate")
                } else this.set("angle", b ? a : (this.get("angle") + a) % 360, d);
                return this
            },
            getBBox: function(a) {
                if (a = a || {}, a.deep && this.graph) {
                    var b = this.getEmbeddedCells({
                        deep: !0,
                        breadthFirst: !0
                    });
                    return b.push(this), this.graph.getCellsBBox(b)
                }
                var c = this.get("position"),
                    d = this.get("size");
                return g.rect(c.x, c.y, d.width, d.height)
            }
        }), joint.dia.ElementView = joint.dia.CellView.extend({
            SPECIAL_ATTRIBUTES: ["style", "text", "html", "ref-x", "ref-y", "ref-dx", "ref-dy", "ref-width", "ref-height", "ref", "x-alignment", "y-alignment", "port"],
            _removePorts: function() {},
            _renderPorts: function() {},
            className: function() {
                var a = joint.dia.CellView.prototype.className.apply(this).split(" ");
                return a.push("element"), a.join(" ")
            },
            initialize: function() {
                joint.dia.CellView.prototype.initialize.apply(this, arguments);
                var a = this.model;
                this.listenTo(a, "change:position", this.translate), this.listenTo(a, "change:size", this.resize), this.listenTo(a, "change:angle", this.rotate), this.listenTo(a, "change:markup", this.render), this._initializePorts()
            },
            _initializePorts: function() {},
            updateAttr: function(a, b) {
                var c = this.SPECIAL_ATTRIBUTES.slice();
                _.isObject(b.filter) && (c.push("filter"), this.applyFilter(a, b.filter)), _.isObject(b.fill) && (c.push("fill"), this.applyGradient(a, "fill", b.fill)), _.isObject(b.stroke) && (c.push("stroke"), this.applyGradient(a, "stroke", b.stroke)), _.isUndefined(b.text) || (a.each(function() {
                    _.isUndefined(b.x) || (V(this).attr("x", b.x), c.push("x")), _.isUndefined(b.y) || (V(this).attr("y", b.y), c.push("y")), V(this).text(b.text + "", {
                        lineHeight: b.lineHeight,
                        textPath: b.textPath,
                        annotations: b.annotations
                    })
                }), c.push("lineHeight", "textPath", "annotations"));
                var d = _.omit(b, c);
                a.each(function() {
                    V(this).attr(d)
                }), b.port && a.attr("port", _.isUndefined(b.port.id) ? b.port : b.port.id), b.style && a.css(b.style), _.isUndefined(b.html) || a.each(function() {
                    $(this).html(b.html + "")
                })
            },
            update: function(a, b) {
                this._removePorts();
                var c = this.model.get("attrs"),
                    d = this.rotatableNode;
                if (d) {
                    var e = d.attr("transform");
                    d.attr("transform", "")
                }
                var f = [],
                    g = {};
                _.each(b || c, function(a, b) {
                    var c = "." === b ? this.$el : this.findBySelector(b),
                        d = c.length;
                    if (0 !== d && (g[b] = c, this.updateAttr(c, a), !(_.isUndefined(a["ref-x"]) && _.isUndefined(a["ref-y"]) && _.isUndefined(a["ref-dx"]) && _.isUndefined(a["ref-dy"]) && _.isUndefined(a["x-alignment"]) && _.isUndefined(a["y-alignment"]) && _.isUndefined(a["ref-width"]) && _.isUndefined(a["ref-height"]))))
                        for (var e = 0; e < d; e++) {
                            var h = c.eq(e);
                            h.selector = b, f.push(h)
                        }
                }, this);
                var h = this.model.get("size"),
                    i = {
                        x: 0,
                        y: 0,
                        width: h.width,
                        height: h.height
                    };
                b = b || {}, _.each(f, function(a) {
                    var d = b[a.selector],
                        e = d ? _.merge({}, c[a.selector], d) : c[a.selector];
                    this.positionRelative(V(a[0]), i, e, g)
                }, this), d && d.attr("transform", e || ""), this._renderPorts()
            },
            positionRelative: function(a, b, c, d) {
                var e = c.ref,
                    f = parseFloat(c["ref-dx"]),
                    g = parseFloat(c["ref-dy"]),
                    h = c["y-alignment"],
                    i = c["x-alignment"],
                    j = c["ref-y"],
                    k = _.isString(j) && "%" === j.slice(-1);
                j = parseFloat(j), k && (j /= 100);
                var l = c["ref-x"],
                    m = _.isString(l) && "%" === l.slice(-1);
                l = parseFloat(l), m && (l /= 100);
                var n = c["ref-width"],
                    o = _.isString(n) && "%" === n.slice(-1);
                n = parseFloat(n), o && (n /= 100);
                var p = c["ref-height"],
                    q = _.isString(p) && "%" === p.slice(-1);
                p = parseFloat(p), q && (p /= 100);
                var r = a.findParentByClass("scalable", this.el);
                if (e) {
                    var s;
                    if (s = d && d[e] ? V(d[e][0]) : "." === e ? this.vel : this.vel.findOne(e), !s) throw new Error("dia.ElementView: reference does not exists.");
                    b = s.bbox(!1, this.el)
                }
                a.attr("transform") && a.attr("transform", a.attr("transform").replace(/translate\([^)]*\)/g, "").trim() || ""), isFinite(n) && (o || n >= 0 && n <= 1 ? a.attr("width", n * b.width) : a.attr("width", Math.max(n + b.width, 0))), isFinite(p) && (q || p >= 0 && p <= 1 ? a.attr("height", p * b.height) : a.attr("height", Math.max(p + b.height, 0)));
                var t, u = 0,
                    v = 0;
                if (isFinite(f) && (r ? (t = t || r.scale(), u = b.x + b.width + f / t.sx) : u = b.x + b.width + f), isFinite(g) && (r ? (t = t || r.scale(), v = b.y + b.height + g / t.sy) : v = b.y + b.height + g), isFinite(l) && (m || l > 0 && l < 1 ? u = b.x + b.width * l : r ? (t = t || r.scale(), u = b.x + l / t.sx) : u = b.x + l), isFinite(j) && (k || j > 0 && j < 1 ? v = b.y + b.height * j : r ? (t = t || r.scale(), v = b.y + j / t.sy) : v = b.y + j), !_.isUndefined(h) || !_.isUndefined(i)) {
                    var w = a.node,
                        x = a.bbox(!1, w.parentNode),
                        y = w.nodeName.toUpperCase();
                    "TEXT" !== y && "TSPAN" !== y || (x.height += x.y, x.width += x.x), r && (t = t || r.scale(), x.width *= t.sx, x.height *= t.sy), "middle" === h ? v -= x.height / 2 : "bottom" === h ? v -= x.height : isFinite(h) && (v += h > -1 && h < 1 ? x.height * h : h), "middle" === i ? u -= x.width / 2 : "right" === i ? u -= x.width : isFinite(i) && (u += i > -1 && i < 1 ? x.width * i : i)
                }
                a.translate(u, v)
            },
            renderMarkup: function() {
                var a = this.model.get("markup") || this.model.markup;
                if (!a) throw new Error("properties.markup is missing while the default render() implementation is used.");
                var b = joint.util.template(a)(),
                    c = V(b);
                this.vel.append(c)
            },
            render: function() {
                return this.$el.empty(), this.renderMarkup(), this.rotatableNode = this.vel.findOne(".rotatable"), this.scalableNode = this.vel.findOne(".scalable"), this.update(), this.resize(), this.rotate(), this.translate(), this
            },
            scale: function(a, b) {
                this.vel.scale(a, b)
            },
            resize: function(a, b, c) {
                var d = this.model,
                    e = d.get("size") || {
                        width: 1,
                        height: 1
                    },
                    f = d.get("angle") || 0,
                    g = this.scalableNode;
                if (!g) return 0 !== f && this.rotate(), void this.update();
                var h = g.bbox(!0);
                g.attr("transform", "scale(" + e.width / (h.width || 1) + "," + e.height / (h.height || 1) + ")");
                var i = this.rotatableNode,
                    j = i && i.attr("transform");
                if (j && "null" !== j) {
                    i.attr("transform", j + " rotate(" + -f + "," + e.width / 2 + "," + e.height / 2 + ")");
                    var k = g.bbox(!1, this.paper.viewport);
                    d.set("position", {
                        x: k.x,
                        y: k.y
                    }, c), this.rotate()
                }
                this.update()
            },
            translate: function(a, b, c) {
                var d = this.model.get("position") || {
                    x: 0,
                    y: 0
                };
                this.vel.attr("transform", "translate(" + d.x + "," + d.y + ")")
            },
            rotate: function() {
                var a = this.rotatableNode;
                if (a) {
                    var b = this.model.get("angle") || 0,
                        c = this.model.get("size") || {
                            width: 1,
                            height: 1
                        },
                        d = c.width / 2,
                        e = c.height / 2;
                    0 !== b ? a.attr("transform", "rotate(" + b + "," + d + "," + e + ")") : a.removeAttr("transform")
                }
            },
            getBBox: function(a) {
                if (a && a.useModelGeometry) {
                    var b = this.model.getBBox().bbox(this.model.get("angle")),
                        c = this.paper.viewport.getCTM();
                    return g.rect(V.transformRect(b, c))
                }
                return joint.dia.CellView.prototype.getBBox.apply(this, arguments)
            },
            prepareEmbedding: function(a) {
                a = a || {};
                var b = a.model || this.model,
                    c = a.paper || this.paper,
                    d = c.model;
                b.startBatch("to-front", a), b.toFront({
                    deep: !0,
                    ui: !0
                });
                var e = d.get("cells").max("z").get("z"),
                    f = d.getConnectedLinks(b, {
                        deep: !0
                    });
                _.invoke(f, "set", "z", e + 1, {
                    ui: !0
                }), b.stopBatch("to-front");
                var g = b.get("parent");
                g && d.getCell(g).unembed(b, {
                    ui: !0
                })
            },
            processEmbedding: function(a) {
                a = a || {};
                var b = a.model || this.model,
                    c = a.paper || this.paper,
                    d = c.options,
                    e = c.model.findModelsUnderElement(b, {
                        searchBy: d.findParentBy
                    });
                d.frontParentOnly && (e = e.slice(-1));
                for (var f = null, g = this._candidateEmbedView, h = e.length - 1; h >= 0; h--) {
                    var i = e[h];
                    if (g && g.model.id == i.id) {
                        f = g;
                        break
                    }
                    var j = i.findView(c);
                    if (d.validateEmbedding.call(c, this, j)) {
                        f = j;
                        break
                    }
                }
                f && f != g && (this.clearEmbedding(), this._candidateEmbedView = f.highlight(null, {
                    embedding: !0
                })), !f && g && this.clearEmbedding()
            },
            clearEmbedding: function() {
                var a = this._candidateEmbedView;
                a && (a.unhighlight(null, {
                    embedding: !0
                }), this._candidateEmbedView = null)
            },
            finalizeEmbedding: function(a) {
                a = a || {};
                var b = this._candidateEmbedView,
                    c = a.model || this.model,
                    d = a.paper || this.paper;
                b && (b.model.embed(c, {
                    ui: !0
                }), b.unhighlight(null, {
                    embedding: !0
                }), delete this._candidateEmbedView), _.invoke(d.model.getConnectedLinks(c, {
                    deep: !0
                }), "reparent", {
                    ui: !0
                })
            },
            pointerdown: function(a, b, c) {
                var d = this.paper;
                if (a.target.getAttribute("magnet") && this.can("addLinkFromMagnet") && d.options.validateMagnet.call(d, this, a.target)) {
                    this.model.startBatch("add-link");
                    var e = d.getDefaultLink(this, a.target);
                    e.set({
                        source: {
                            id: this.model.id,
                            selector: this.getSelector(a.target),
                            port: a.target.getAttribute("port")
                        },
                        target: {
                            x: b,
                            y: c
                        }
                    }), d.model.addCell(e);
                    var f = this._linkView = d.findViewByModel(e);
                    f.pointerdown(a, b, c), f.startArrowheadMove("target", {
                        whenNotAllowed: "remove"
                    })
                } else this._dx = b, this._dy = c, this.restrictedArea = d.getRestrictedArea(this), joint.dia.CellView.prototype.pointerdown.apply(this, arguments), this.notify("element:pointerdown", a, b, c)
            },
            pointermove: function(a, b, c) {
                if (this._linkView) this._linkView.pointermove(a, b, c);
                else {
                    var d = this.paper.options.gridSize;
                    if (this.can("elementMove")) {
                        var e = this.model.get("position"),
                            f = g.snapToGrid(e.x, d) - e.x + g.snapToGrid(b - this._dx, d),
                            h = g.snapToGrid(e.y, d) - e.y + g.snapToGrid(c - this._dy, d);
                        this.model.translate(f, h, {
                            restrictedArea: this.restrictedArea,
                            ui: !0
                        }), this.paper.options.embeddingMode && (this._inProcessOfEmbedding || (this.prepareEmbedding(), this._inProcessOfEmbedding = !0), this.processEmbedding())
                    }
                    this._dx = g.snapToGrid(b, d), this._dy = g.snapToGrid(c, d), joint.dia.CellView.prototype.pointermove.apply(this, arguments), this.notify("element:pointermove", a, b, c)
                }
            },
            pointerup: function(a, b, c) {
                this._linkView ? (this._linkView.pointerup(a, b, c), this._linkView = null, this.model.stopBatch("add-link")) : (this._inProcessOfEmbedding && (this.finalizeEmbedding(), this._inProcessOfEmbedding = !1), this.notify("element:pointerup", a, b, c), joint.dia.CellView.prototype.pointerup.apply(this, arguments))
            }
        }), joint.dia.Link = joint.dia.Cell.extend({
            markup: ['<path class="connection" stroke="black" d="M 0 0 0 0"/>', '<path class="marker-source" fill="black" stroke="black" d="M 0 0 0 0"/>', '<path class="marker-target" fill="black" stroke="black" d="M 0 0 0 0"/>', '<path class="connection-wrap" d="M 0 0 0 0"/>', '<g class="labels"/>', '<g class="marker-vertices"/>', '<g class="marker-arrowheads"/>', '<g class="link-tools"/>'].join(""),
            labelMarkup: ['<g class="label">', "<rect />", "<text />", "</g>"].join(""),
            toolMarkup: ['<g class="link-tool">', '<g class="tool-remove" event="remove">', '<circle r="11" />', '<path transform="scale(.8) translate(-16, -16)" d="M24.778,21.419 19.276,15.917 24.777,10.415 21.949,7.585 16.447,13.087 10.945,7.585 8.117,10.415 13.618,15.917 8.116,21.419 10.946,24.248 16.447,18.746 21.948,24.248z" />', "<title>Remove link.</title>", "</g>", '<g class="tool-options" event="link:options">', '<circle r="11" transform="translate(25)"/>', '<path fill="white" transform="scale(.55) translate(29, -16)" d="M31.229,17.736c0.064-0.571,0.104-1.148,0.104-1.736s-0.04-1.166-0.104-1.737l-4.377-1.557c-0.218-0.716-0.504-1.401-0.851-2.05l1.993-4.192c-0.725-0.91-1.549-1.734-2.458-2.459l-4.193,1.994c-0.647-0.347-1.334-0.632-2.049-0.849l-1.558-4.378C17.165,0.708,16.588,0.667,16,0.667s-1.166,0.041-1.737,0.105L12.707,5.15c-0.716,0.217-1.401,0.502-2.05,0.849L6.464,4.005C5.554,4.73,4.73,5.554,4.005,6.464l1.994,4.192c-0.347,0.648-0.632,1.334-0.849,2.05l-4.378,1.557C0.708,14.834,0.667,15.412,0.667,16s0.041,1.165,0.105,1.736l4.378,1.558c0.217,0.715,0.502,1.401,0.849,2.049l-1.994,4.193c0.725,0.909,1.549,1.733,2.459,2.458l4.192-1.993c0.648,0.347,1.334,0.633,2.05,0.851l1.557,4.377c0.571,0.064,1.148,0.104,1.737,0.104c0.588,0,1.165-0.04,1.736-0.104l1.558-4.377c0.715-0.218,1.399-0.504,2.049-0.851l4.193,1.993c0.909-0.725,1.733-1.549,2.458-2.458l-1.993-4.193c0.347-0.647,0.633-1.334,0.851-2.049L31.229,17.736zM16,20.871c-2.69,0-4.872-2.182-4.872-4.871c0-2.69,2.182-4.872,4.872-4.872c2.689,0,4.871,2.182,4.871,4.872C20.871,18.689,18.689,20.871,16,20.871z"/>', "<title>Link options.</title>", "</g>", "</g>"].join(""),
            vertexMarkup: ['<g class="marker-vertex-group" transform="translate(<%= x %>, <%= y %>)">', '<circle class="marker-vertex" idx="<%= idx %>" r="10" />', '<path class="marker-vertex-remove-area" idx="<%= idx %>" d="M16,5.333c-7.732,0-14,4.701-14,10.5c0,1.982,0.741,3.833,2.016,5.414L2,25.667l5.613-1.441c2.339,1.317,5.237,2.107,8.387,2.107c7.732,0,14-4.701,14-10.5C30,10.034,23.732,5.333,16,5.333z" transform="translate(5, -33)"/>', '<path class="marker-vertex-remove" idx="<%= idx %>" transform="scale(.8) translate(9.5, -37)" d="M24.778,21.419 19.276,15.917 24.777,10.415 21.949,7.585 16.447,13.087 10.945,7.585 8.117,10.415 13.618,15.917 8.116,21.419 10.946,24.248 16.447,18.746 21.948,24.248z">', "<title>Remove vertex.</title>", "</path>", "</g>"].join(""),
            arrowheadMarkup: ['<g class="marker-arrowhead-group marker-arrowhead-group-<%= end %>">', '<path class="marker-arrowhead" end="<%= end %>" d="M 26 0 L 0 13 L 26 26 z" />', "</g>"].join(""),
            defaults: {
                type: "link",
                source: {},
                target: {}
            },
            isLink: function() {
                return !0
            },
            disconnect: function() {
                return this.set({
                    source: g.point(0, 0),
                    target: g.point(0, 0)
                })
            },
            label: function(a, b) {
                a = a || 0;
                var c = this.get("labels") || [];
                if (0 === arguments.length || 1 === arguments.length) return c[a];
                var d = _.merge({}, c[a], b),
                    e = c.slice();
                return e[a] = d, this.set({
                    labels: e
                })
            },
            translate: function(a, b, c) {
                return c = c || {}, c.translateBy = c.translateBy || this.id, c.tx = a, c.ty = b, this.applyToPoints(function(c) {
                    return {
                        x: (c.x || 0) + a,
                        y: (c.y || 0) + b
                    }
                }, c)
            },
            scale: function(a, b, c, d) {
                return this.applyToPoints(function(d) {
                    return g.point(d).scale(a, b, c).toJSON()
                }, d)
            },
            applyToPoints: function(a, b) {
                if (!_.isFunction(a)) throw new TypeError("dia.Link: applyToPoints expects its first parameter to be a function.");
                var c = {},
                    d = this.get("source");
                d.id || (c.source = a(d));
                var e = this.get("target");
                e.id || (c.target = a(e));
                var f = this.get("vertices");
                return f && f.length > 0 && (c.vertices = _.map(f, a)), this.set(c, b)
            },
            reparent: function(a) {
                var b;
                if (this.graph) {
                    var c = this.graph.getCell(this.get("source").id),
                        d = this.graph.getCell(this.get("target").id),
                        e = this.graph.getCell(this.get("parent"));
                    c && d && (b = this.graph.getCommonAncestor(c, d)), !e || b && b.id === e.id || e.unembed(this, a), b && b.embed(this, a)
                }
                return b
            },
            hasLoop: function(a) {
                a = a || {};
                var b = this.get("source").id,
                    c = this.get("target").id;
                if (!b || !c) return !1;
                var d = b === c;
                if (!d && a.deep && this.graph) {
                    var e = this.graph.getCell(b),
                        f = this.graph.getCell(c);
                    d = e.isEmbeddedIn(f) || f.isEmbeddedIn(e)
                }
                return d
            },
            getSourceElement: function() {
                var a = this.get("source");
                return a && a.id && this.graph && this.graph.getCell(a.id) || null
            },
            getTargetElement: function() {
                var a = this.get("target");
                return a && a.id && this.graph && this.graph.getCell(a.id) || null
            },
            getRelationshipAncestor: function() {
                var a;
                if (this.graph) {
                    var b = _.compact([this, this.getSourceElement(), this.getTargetElement()]);
                    a = this.graph.getCommonAncestor.apply(this.graph, b)
                }
                return a || null
            },
            isRelationshipEmbeddedIn: function(a) {
                var b = _.isString(a) ? a : a.id,
                    c = this.getRelationshipAncestor();
                return !!c && (c.id === b || c.isEmbeddedIn(b))
            }
        }, {
            endsEqual: function(a, b) {
                var c = a.port === b.port || !a.port && !b.port;
                return a.id === b.id && c
            }
        }), joint.dia.LinkView = joint.dia.CellView.extend({
            className: function() {
                var a = joint.dia.CellView.prototype.className.apply(this).split(" ");
                return a.push("link"), a.join(" ")
            },
            options: {
                shortLinkLength: 100,
                doubleLinkTools: !1,
                longLinkLength: 160,
                linkToolsOffset: 40,
                doubleLinkToolsOffset: 60,
                sampleInterval: 50
            },
            _z: null,
            initialize: function(a) {
                joint.dia.CellView.prototype.initialize.apply(this, arguments), "function" != typeof this.constructor.prototype.watchSource && (this.constructor.prototype.watchSource = this.createWatcher("source"), this.constructor.prototype.watchTarget = this.createWatcher("target")), this._labelCache = {}, this._markerCache = {}, this.startListening()
            },
            startListening: function() {
                var a = this.model;
                this.listenTo(a, "change:markup", this.render), this.listenTo(a, "change:smooth change:manhattan change:router change:connector", this.update), this.listenTo(a, "change:toolMarkup", this.onToolsChange), this.listenTo(a, "change:labels change:labelMarkup", this.onLabelsChange), this.listenTo(a, "change:vertices change:vertexMarkup", this.onVerticesChange), this.listenTo(a, "change:source", this.onSourceChange), this.listenTo(a, "change:target", this.onTargetChange)
            },
            onSourceChange: function(a, b, c) {
                this.watchSource(a, b), c.translateBy && this.model.get("target").id || (c.updateConnectionOnly = !0, this.update(this.model, null, c))
            },
            onTargetChange: function(a, b, c) {
                this.watchTarget(a, b), c.translateBy || (c.updateConnectionOnly = !0, this.update(this.model, null, c))
            },
            onVerticesChange: function(a, b, c) {
                this.renderVertexMarkers(), c.translateBy && c.translateBy !== this.model.id || (c.updateConnectionOnly = !0, this.update(a, null, c))
            },
            onToolsChange: function() {
                this.renderTools().updateToolsPosition()
            },
            onLabelsChange: function() {
                this.renderLabels().updateLabelPositions()
            },
            render: function() {
                this.$el.empty();
                var a = this.model,
                    b = a.get("markup") || a.markup,
                    c = V(b);
                if (_.isArray(c) || (c = [c]), this._V = {}, _.each(c, function(a) {
                        var b = a.attr("class");
                        b && (b = joint.util.removeClassNamePrefix(b), this._V[$.camelCase(b)] = a)
                    }, this), !this._V.connection) throw new Error("link: no connection path in the markup");
                return this.renderTools(), this.renderVertexMarkers(), this.renderArrowheadMarkers(), this.vel.append(c), this.renderLabels(), this.watchSource(a, a.get("source")).watchTarget(a, a.get("target")).update(), this
            },
            renderLabels: function() {
                if (!this._V.labels) return this;
                this._labelCache = {};
                var a = $(this._V.labels.node).empty(),
                    b = this.model.get("labels") || [];
                if (!b.length) return this;
                var c = joint.util.template(this.model.get("labelMarkup") || this.model.labelMarkup),
                    d = V(c()),
                    e = this.can("labelMove");
                return _.each(b, function(b, c) {
                    var f = d.clone().node;
                    V(f).attr("label-idx", c), e && V(f).attr("cursor", "move"), this._labelCache[c] = V(f);
                    var g = $(f).find("text"),
                        h = $(f).find("rect"),
                        i = _.extend({
                            "text-anchor": "middle",
                            "font-size": 14
                        }, joint.util.getByPath(b, "attrs/text", "/"));
                    g.attr(_.omit(i, "text")), _.isUndefined(i.text) || V(g[0]).text(i.text + "", {
                        annotations: i.annotations
                    }), a.append(f);
                    var j = V(g[0]).bbox(!0, a[0]);
                    V(g[0]).translate(0, -j.height / 2);
                    var k = _.extend({
                        fill: "white",
                        rx: 3,
                        ry: 3
                    }, joint.util.getByPath(b, "attrs/rect", "/"));
                    h.attr(_.extend(k, {
                        x: j.x,
                        y: j.y - j.height / 2,
                        width: j.width,
                        height: j.height
                    }))
                }, this), this
            },
            renderTools: function() {
                if (!this._V.linkTools) return this;
                var a = $(this._V.linkTools.node).empty(),
                    b = joint.util.template(this.model.get("toolMarkup") || this.model.toolMarkup),
                    c = V(b());
                if (a.append(c.node), this._toolCache = c, this.options.doubleLinkTools) {
                    var d;
                    this.model.get("doubleToolMarkup") || this.model.doubleToolMarkup ? (b = joint.util.template(this.model.get("doubleToolMarkup") || this.model.doubleToolMarkup), d = V(b())) : d = c.clone(), a.append(d.node), this._tool2Cache = d
                }
                return this
            },
            renderVertexMarkers: function() {
                if (!this._V.markerVertices) return this;
                var a = $(this._V.markerVertices.node).empty(),
                    b = joint.util.template(this.model.get("vertexMarkup") || this.model.vertexMarkup);
                return _.each(this.model.get("vertices"), function(c, d) {
                    a.append(V(b(_.extend({
                        idx: d
                    }, c))).node)
                }), this
            },
            renderArrowheadMarkers: function() {
                if (!this._V.markerArrowheads) return this;
                var a = $(this._V.markerArrowheads.node);
                a.empty();
                var b = joint.util.template(this.model.get("arrowheadMarkup") || this.model.arrowheadMarkup);
                return this._V.sourceArrowhead = V(b({
                    end: "source"
                })), this._V.targetArrowhead = V(b({
                    end: "target"
                })), a.append(this._V.sourceArrowhead.node, this._V.targetArrowhead.node), this
            },
            update: function(a, b, c) {
                return c = c || {}, c.updateConnectionOnly || this.updateAttributes(), this.updateConnection(c), this.updateLabelPositions(), this.updateToolsPosition(), this.updateArrowheadMarkers(), this.options.perpendicular = null, this.updatePostponed = !1, this
            },
            updateConnection: function(a) {
                a = a || {};
                var b, c = this.model;
                if (a.translateBy && c.isRelationshipEmbeddedIn(a.translateBy)) {
                    var d = a.tx || 0,
                        e = a.ty || 0;
                    b = this.route = _.map(this.route, function(a) {
                        return g.point(a).offset(d, e)
                    }), this._translateConnectionPoints(d, e)
                } else b = this.route = this.findRoute(c.get("vertices") || [], a), this._findConnectionPoints(b);
                var f = this.getPathData(b);
                this._V.connection.attr("d", f), this._V.connectionWrap && this._V.connectionWrap.attr("d", f), this._translateAndAutoOrientArrows(this._V.markerSource, this._V.markerTarget)
            },
            updateAttributes: function() {
                _.each(this.model.get("attrs"), function(a, b) {
                    var c = [];
                    _.isObject(a.fill) && (this.applyGradient(b, "fill", a.fill), c.push("fill")), _.isObject(a.stroke) && (this.applyGradient(b, "stroke", a.stroke), c.push("stroke")), _.isObject(a.filter) && (this.applyFilter(b, a.filter), c.push("filter")), c.length > 0 && (c.unshift(a), a = _.omit.apply(_, c)), this.findBySelector(b).attr(a)
                }, this)
            },
            _findConnectionPoints: function(a) {
                var b, c, d, e, f = _.first(a);
                b = this.getConnectionPoint("source", this.model.get("source"), f || this.model.get("target")).round();
                var h = _.last(a);
                c = this.getConnectionPoint("target", this.model.get("target"), h || b).round();
                var i = this._markerCache;
                this._V.markerSource && (i.sourceBBox = i.sourceBBox || this._V.markerSource.bbox(!0), d = g.point(b).move(f || c, i.sourceBBox.width * this._V.markerSource.scale().sx * -1).round()), this._V.markerTarget && (i.targetBBox = i.targetBBox || this._V.markerTarget.bbox(!0), e = g.point(c).move(h || b, i.targetBBox.width * this._V.markerTarget.scale().sx * -1).round()), i.sourcePoint = d || b, i.targetPoint = e || c, this.sourcePoint = b, this.targetPoint = c
            },
            _translateConnectionPoints: function(a, b) {
                var c = this._markerCache;
                c.sourcePoint.offset(a, b), c.targetPoint.offset(a, b), this.sourcePoint.offset(a, b), this.targetPoint.offset(a, b)
            },
            updateLabelPositions: function() {
                if (!this._V.labels) return this;
                var a = this.model.get("labels") || [];
                if (!a.length) return this;
                var b = this._V.connection.node,
                    c = b.getTotalLength();
                if (!_.isNaN(c)) {
                    var d;
                    _.each(a, function(a, e) {
                        var f = a.position,
                            h = _.isObject(f) ? f.distance : f,
                            i = _.isObject(f) ? f.offset : {
                                x: 0,
                                y: 0
                            };
                        _.isNaN(h) ? h = c / 2 : (h = h > c ? c : h, h = h < 0 ? c + h : h, h = h > 1 ? h : c * h);
                        var j = b.getPointAtLength(h);
                        if (_.isObject(i)) j = g.point(j).offset(i.x, i.y);
                        else if (_.isNumber(i)) {
                            d || (d = this._samples || this._V.connection.sample(this.options.sampleInterval));
                            for (var k, l, m, n = 1 / 0, o = 0; o < d.length; o++) l = d[o], m = g.line(l, j).squaredLength(), m < n && (n = m, k = o);
                            var p = d[k - 1],
                                q = d[k + 1],
                                r = 0;
                            q ? r = g.point(j).theta(q) : p && (r = g.point(p).theta(j)), j = g.point(j).offset(i).rotate(j, r - 90)
                        }
                        this._labelCache[e].attr("transform", "translate(" + j.x + ", " + j.y + ")")
                    }, this);
                }
                return this
            },
            updateToolsPosition: function() {
                if (!this._V.linkTools) return this;
                var a = "",
                    b = this.options.linkToolsOffset,
                    c = this.getConnectionLength();
                if (!_.isNaN(c)) {
                    c < this.options.shortLinkLength && (a = "scale(.5)", b /= 2);
                    var d = this.getPointAtLength(b);
                    if (this._toolCache.attr("transform", "translate(" + d.x + ", " + d.y + ") " + a), this.options.doubleLinkTools && c >= this.options.longLinkLength) {
                        var e = this.options.doubleLinkToolsOffset || b;
                        d = this.getPointAtLength(c - e), this._tool2Cache.attr("transform", "translate(" + d.x + ", " + d.y + ") " + a), this._tool2Cache.attr("visibility", "visible")
                    } else this.options.doubleLinkTools && this._tool2Cache.attr("visibility", "hidden")
                }
                return this
            },
            updateArrowheadMarkers: function() {
                if (!this._V.markerArrowheads) return this;
                if ("none" === $.css(this._V.markerArrowheads.node, "display")) return this;
                var a = this.getConnectionLength() < this.options.shortLinkLength ? .5 : 1;
                return this._V.sourceArrowhead.scale(a), this._V.targetArrowhead.scale(a), this._translateAndAutoOrientArrows(this._V.sourceArrowhead, this._V.targetArrowhead), this
            },
            createWatcher: function(a) {
                function b(b, d) {
                    d = d || {};
                    var e = null,
                        f = b.previous(a) || {};
                    return f.id && this.stopListening(this.paper.getModelById(f.id), "change", c), d.id && (e = this.paper.getModelById(d.id), this.listenTo(e, "change", c)), c.call(this, e, {
                        cacheOnly: !0
                    }), this
                }
                var c = _.partial(this.onEndModelChange, a);
                return b
            },
            onEndModelChange: function(a, b, c) {
                var d = !c.cacheOnly,
                    e = this.model,
                    f = e.get(a) || {};
                if (b) {
                    var h = this.constructor.makeSelector(f),
                        i = "source" == a ? "target" : "source",
                        j = e.get(i) || {},
                        k = j.id && this.constructor.makeSelector(j);
                    if (c.handleBy === this.cid && h == k) this[a + "BBox"] = this[i + "BBox"], this[a + "View"] = this[i + "View"], this[a + "Magnet"] = this[i + "Magnet"];
                    else if (c.translateBy) {
                        var l = this[a + "BBox"];
                        l.x += c.tx, l.y += c.ty
                    } else {
                        var m = this.paper.findViewByModel(f.id),
                            n = m.el.querySelector(h);
                        this[a + "BBox"] = m.getStrokeBBox(n), this[a + "View"] = m, this[a + "Magnet"] = n
                    }
                    if (c.handleBy === this.cid && c.translateBy && e.isEmbeddedIn(b) && !_.isEmpty(e.get("vertices")) && (d = !1), !this.updatePostponed && j.id) {
                        var o = this.paper.getModelById(j.id);
                        f.id === j.id && (c.handleBy = this.cid), (c.handleBy === this.cid || c.translateBy && o.isEmbeddedIn(c.translateBy)) && (this.updatePostponed = !0, d = !1)
                    }
                } else this[a + "BBox"] = g.rect(f.x || 0, f.y || 0, 1, 1), this[a + "View"] = this[a + "Magnet"] = null;
                d && (c.updateConnectionOnly = !0, this.update(e, null, c))
            },
            _translateAndAutoOrientArrows: function(a, b) {
                a && a.translateAndAutoOrient(this.sourcePoint, _.first(this.route) || this.targetPoint, this.paper.viewport), b && b.translateAndAutoOrient(this.targetPoint, _.last(this.route) || this.sourcePoint, this.paper.viewport)
            },
            removeVertex: function(a) {
                var b = _.clone(this.model.get("vertices"));
                return b && b.length && (b.splice(a, 1), this.model.set("vertices", b, {
                    ui: !0
                })), this
            },
            addVertex: function(a) {
                for (var b, c = (this.model.get("vertices") || []).slice(), d = c.slice(), e = this._V.connection.node.cloneNode(!1), f = e.getTotalLength(), g = 20, h = c.length + 1; h-- && (c.splice(h, 0, a), V(e).attr("d", this.getPathData(this.findRoute(c))), b = e.getTotalLength(), b - f > g);) c = d.slice();
                return h === -1 && (h = 0, c.splice(h, 0, a)), this.model.set("vertices", c, {
                    ui: !0
                }), h
            },
            sendToken: function(a, b, c) {
                b = b || 1e3, V(this.paper.viewport).append(a), V(a).animateAlongPath({
                    dur: b + "ms",
                    repeatCount: 1
                }, this._V.connection.node), _.delay(function() {
                    V(a).remove(), c && c()
                }, b)
            },
            findRoute: function(a) {
                var b = joint.routers,
                    c = this.model.get("router"),
                    d = this.paper.options.defaultRouter;
                if (!c)
                    if (this.model.get("manhattan")) c = {
                        name: "orthogonal"
                    };
                    else {
                        if (!d) return a;
                        c = d
                    }
                var e = c.args || {},
                    f = _.isFunction(c) ? c : b[c.name];
                if (!_.isFunction(f)) throw new Error('unknown router: "' + c.name + '"');
                var g = f.call(this, a || [], e, this);
                return g
            },
            getPathData: function(a) {
                var b = joint.connectors,
                    c = this.model.get("connector"),
                    d = this.paper.options.defaultConnector;
                c || (c = this.model.get("smooth") ? {
                    name: "smooth"
                } : d || {});
                var e = _.isFunction(c) ? c : b[c.name],
                    f = c.args || {};
                if (!_.isFunction(e)) throw new Error('unknown connector: "' + c.name + '"');
                var g = e.call(this, this._markerCache.sourcePoint, this._markerCache.targetPoint, a || this.model.get("vertices") || {}, f, this);
                return g
            },
            getConnectionPoint: function(a, b, c) {
                var d;
                if (_.isEmpty(b) && (b = {
                        x: 0,
                        y: 0
                    }), _.isEmpty(c) && (c = {
                        x: 0,
                        y: 0
                    }), b.id) {
                    var e, f = g.Rect("source" === a ? this.sourceBBox : this.targetBBox);
                    if (c.id) {
                        var h = g.Rect("source" === a ? this.targetBBox : this.sourceBBox);
                        e = h.intersectionWithLineFromCenterToPoint(f.center()), e = e || h.center()
                    } else e = g.Point(c);
                    var i = this.paper.options;
                    if (i.perpendicularLinks || this.options.perpendicular) {
                        var j, k = f.origin(),
                            l = f.corner();
                        if (k.y <= e.y && e.y <= l.y) switch (j = f.sideNearestToPoint(e)) {
                            case "left":
                                d = g.Point(k.x, e.y);
                                break;
                            case "right":
                                d = g.Point(l.x, e.y);
                                break;
                            default:
                                d = f.center()
                        } else if (k.x <= e.x && e.x <= l.x) switch (j = f.sideNearestToPoint(e)) {
                            case "top":
                                d = g.Point(e.x, k.y);
                                break;
                            case "bottom":
                                d = g.Point(e.x, l.y);
                                break;
                            default:
                                d = f.center()
                        } else d = f.intersectionWithLineFromCenterToPoint(e), d = d || f.center()
                    } else if (i.linkConnectionPoint) {
                        var m = "target" === a ? this.targetView : this.sourceView,
                            n = "target" === a ? this.targetMagnet : this.sourceMagnet;
                        d = i.linkConnectionPoint(this, m, n, e)
                    } else d = f.intersectionWithLineFromCenterToPoint(e), d = d || f.center()
                } else d = g.Point(b);
                return d
            },
            getConnectionLength: function() {
                return this._V.connection.node.getTotalLength()
            },
            getPointAtLength: function(a) {
                return this._V.connection.node.getPointAtLength(a)
            },
            _beforeArrowheadMove: function() {
                this._z = this.model.get("z"), this.model.toFront(), this.el.style.pointerEvents = "none", this.paper.options.markAvailable && this._markAvailableMagnets()
            },
            _afterArrowheadMove: function() {
                _.isNull(this._z) || (this.model.set("z", this._z, {
                    ui: !0
                }), this._z = null), this.el.style.pointerEvents = "visiblePainted", this.paper.options.markAvailable && this._unmarkAvailableMagnets()
            },
            _createValidateConnectionArgs: function(a) {
                function b(a, b) {
                    return c[f] = a, c[f + 1] = a.el === b ? void 0 : b, c
                }
                var c = [];
                c[4] = a, c[5] = this;
                var d, e = 0,
                    f = 0;
                "source" === a ? (e = 2, d = "target") : (f = 2, d = "source");
                var g = this.model.get(d);
                return g.id && (c[e] = this.paper.findViewByModel(g.id), c[e + 1] = g.selector && c[e].el.querySelector(g.selector)), b
            },
            _markAvailableMagnets: function() {
                function a(a, b) {
                    var c = a.paper,
                        d = c.options.validateConnection;
                    return d.apply(c, this._validateConnectionArgs(a, b))
                }
                var b = this.paper,
                    c = b.model.getElements();
                this._marked = {}, _.chain(c).map(b.findViewByModel, b).each(function(b) {
                    var c = Array.prototype.slice.call(b.el.querySelectorAll("[magnet]"));
                    "false" !== b.el.getAttribute("magnet") && c.push(b.el);
                    var d = _.filter(c, _.partial(a, b), this);
                    d.length > 0 && (_.each(d, _.partial(b.highlight, _, {
                        magnetAvailability: !0
                    }), b), b.highlight(null, {
                        elementAvailability: !0
                    }), this._marked[b.model.id] = d)
                }, this).value()
            },
            _unmarkAvailableMagnets: function() {
                _.each(this._marked, function(a, b) {
                    var c = this.paper.findViewByModel(b);
                    c && (_.each(a, _.partial(c.unhighlight, _, {
                        magnetAvailability: !0
                    }), c), c.unhighlight(null, {
                        elementAvailability: !0
                    }))
                }, this), this._marked = null
            },
            startArrowheadMove: function(a, b) {
                b = _.defaults(b || {}, {
                    whenNotAllowed: "revert"
                }), this._action = "arrowhead-move", this._whenNotAllowed = b.whenNotAllowed, this._arrowhead = a, this._initialMagnet = this[a + "Magnet"] || (this[a + "View"] ? this[a + "View"].el : null), this._initialEnd = _.clone(this.model.get(a)) || {
                    x: 0,
                    y: 0
                }, this._validateConnectionArgs = this._createValidateConnectionArgs(this._arrowhead), this._beforeArrowheadMove()
            },
            pointerdown: function(a, b, c) {
                if (joint.dia.CellView.prototype.pointerdown.apply(this, arguments), this.notify("link:pointerdown", a, b, c), this._dx = b, this._dy = c, null == a.target.getAttribute("magnet")) {
                    var d, e = joint.util.removeClassNamePrefix(a.target.getAttribute("class")),
                        f = joint.util.removeClassNamePrefix(a.target.parentNode.getAttribute("class"));
                    switch ("label" === f ? (e = f, d = a.target.parentNode) : d = a.target, e) {
                        case "marker-vertex":
                            this.can("vertexMove") && (this._action = "vertex-move", this._vertexIdx = a.target.getAttribute("idx"));
                            break;
                        case "marker-vertex-remove":
                        case "marker-vertex-remove-area":
                            this.can("vertexRemove") && this.removeVertex(a.target.getAttribute("idx"));
                            break;
                        case "marker-arrowhead":
                            this.can("arrowheadMove") && this.startArrowheadMove(a.target.getAttribute("end"));
                            break;
                        case "label":
                            this.can("labelMove") && (this._action = "label-move", this._labelIdx = parseInt(V(d).attr("label-idx"), 10), this._samples = this._V.connection.sample(1), this._linkLength = this._V.connection.node.getTotalLength());
                            break;
                        default:
                            var g = a.target.parentNode.getAttribute("event");
                            g ? this.can("useLinkTools") && ("remove" === g ? this.model.remove() : this.notify(g, a, b, c)) : this.can("vertexAdd") && (this._vertexIdx = this.addVertex({
                                x: b,
                                y: c
                            }), this._action = "vertex-move")
                    }
                }
            },
            pointermove: function(a, b, c) {
                switch (this._action) {
                    case "vertex-move":
                        var d = _.clone(this.model.get("vertices"));
                        d[this._vertexIdx] = {
                            x: b,
                            y: c
                        }, this.model.set("vertices", d, {
                            ui: !0
                        });
                        break;
                    case "label-move":
                        for (var e, f, h, i, j = {
                                x: b,
                                y: c
                            }, k = this._samples, l = 1 / 0, m = 0, n = k.length; m < n; m++) h = k[m], i = g.line(h, j).squaredLength(), i < l && (l = i, e = h, f = m);
                        var o = k[f - 1],
                            p = k[f + 1],
                            q = 0;
                        o && p ? q = g.line(o, p).pointOffset(j) : o ? q = g.line(o, e).pointOffset(j) : p && (q = g.line(e, p).pointOffset(j)), this.model.label(this._labelIdx, {
                            position: {
                                distance: e.distance / this._linkLength,
                                offset: q
                            }
                        });
                        break;
                    case "arrowhead-move":
                        if (this.paper.options.snapLinks) {
                            var r = this.paper.options.snapLinks.radius || 50,
                                s = this.paper.findViewsInArea({
                                    x: b - r,
                                    y: c - r,
                                    width: 2 * r,
                                    height: 2 * r
                                });
                            this._closestView && this._closestView.unhighlight(this._closestEnd.selector, {
                                connecting: !0,
                                snapping: !0
                            }), this._closestView = this._closestEnd = null;
                            var t, u = Number.MAX_VALUE,
                                v = g.point(b, c);
                            _.each(s, function(a) {
                                "false" !== a.el.getAttribute("magnet") && (t = a.model.getBBox().center().distance(v), t < r && t < u && this.paper.options.validateConnection.apply(this.paper, this._validateConnectionArgs(a, null)) && (u = t, this._closestView = a, this._closestEnd = {
                                    id: a.model.id
                                })), a.$("[magnet]").each(_.bind(function(b, c) {
                                    var d = V(c).bbox(!1, this.paper.viewport);
                                    t = v.distance({
                                        x: d.x + d.width / 2,
                                        y: d.y + d.height / 2
                                    }), t < r && t < u && this.paper.options.validateConnection.apply(this.paper, this._validateConnectionArgs(a, c)) && (u = t, this._closestView = a, this._closestEnd = {
                                        id: a.model.id,
                                        selector: a.getSelector(c),
                                        port: c.getAttribute("port")
                                    })
                                }, this))
                            }, this), this._closestView && this._closestView.highlight(this._closestEnd.selector, {
                                connecting: !0,
                                snapping: !0
                            }), this.model.set(this._arrowhead, this._closestEnd || {
                                x: b,
                                y: c
                            }, {
                                ui: !0
                            })
                        } else {
                            var w = "mousemove" === a.type ? a.target : document.elementFromPoint(a.clientX, a.clientY);
                            this._targetEvent !== w && (this._magnetUnderPointer && this._viewUnderPointer.unhighlight(this._magnetUnderPointer, {
                                connecting: !0
                            }), this._viewUnderPointer = this.paper.findView(w), this._viewUnderPointer ? (this._magnetUnderPointer = this._viewUnderPointer.findMagnet(w), this._magnetUnderPointer && this.paper.options.validateConnection.apply(this.paper, this._validateConnectionArgs(this._viewUnderPointer, this._magnetUnderPointer)) ? this._magnetUnderPointer && this._viewUnderPointer.highlight(this._magnetUnderPointer, {
                                connecting: !0
                            }) : this._magnetUnderPointer = null) : this._magnetUnderPointer = null), this._targetEvent = w, this.model.set(this._arrowhead, {
                                x: b,
                                y: c
                            }, {
                                ui: !0
                            })
                        }
                }
                this._dx = b, this._dy = c, joint.dia.CellView.prototype.pointermove.apply(this, arguments), this.notify("link:pointermove", a, b, c)
            },
            pointerup: function(a, b, c) {
                if ("label-move" === this._action) this._samples = null;
                else if ("arrowhead-move" === this._action) {
                    var d, e = this.paper,
                        f = e.options,
                        g = this._arrowhead,
                        h = this._initialEnd;
                    if (f.snapLinks) this._closestView && (this._closestView.unhighlight(this._closestEnd.selector, {
                        connecting: !0,
                        snapping: !0
                    }), d = this._closestView.findMagnet(this._closestEnd.selector)), this._closestView = this._closestEnd = null;
                    else {
                        var i = this._viewUnderPointer;
                        if (d = this._magnetUnderPointer, this._viewUnderPointer = null, this._magnetUnderPointer = null, d) {
                            i.unhighlight(d, {
                                connecting: !0
                            });
                            var j = i.getSelector(d),
                                k = d.getAttribute("port"),
                                l = {
                                    id: i.model.id
                                };
                            null != j && (l.port = k), null != k && (l.selector = j), this.model.set(g, l, {
                                ui: !0
                            })
                        }
                    }
                    if (!e.linkAllowed(this)) switch (this._whenNotAllowed) {
                        case "remove":
                            this.model.remove();
                            break;
                        case "revert":
                        default:
                            this.model.set(g, h, {
                                ui: !0
                            })
                    }
                    f.embeddingMode && this.model.reparent() && (this._z = null);
                    var m = this.model.prop(g) || {},
                        n = !joint.dia.Link.endsEqual(h, m);
                    n && (h.id && this.notify("link:disconnect", a, e.findViewByModel(h.id), this._initialMagnet, g), m.id && this.notify("link:connect", a, e.findViewByModel(m.id), d, g)), this._afterArrowheadMove()
                }
                this._action = null, this._whenNotAllowed = null, this._initialMagnet = null, this._initialEnd = null, this._validateConnectionArgs = null, this.notify("link:pointerup", a, b, c), joint.dia.CellView.prototype.pointerup.apply(this, arguments)
            }
        }, {
            makeSelector: function(a) {
                var b = '[model-id="' + a.id + '"]';
                return a.port ? b += ' [port="' + a.port + '"]' : a.selector && (b += " " + a.selector), b
            }
        }), joint.dia.Paper = joint.mvc.View.extend({
            className: "paper",
            options: {
                width: 800,
                height: 600,
                origin: {
                    x: 0,
                    y: 0
                },
                gridSize: 1,
                drawGrid: !1,
                perpendicularLinks: !1,
                elementView: joint.dia.ElementView,
                linkView: joint.dia.LinkView,
                snapLinks: !1,
                multiLinks: !0,
                guard: function(a, b) {
                    return !1
                },
                highlighting: {
                    default: {
                        name: "stroke",
                        options: {
                            padding: 3
                        }
                    },
                    magnetAvailability: {
                        name: "addClass",
                        options: {
                            className: "available-magnet"
                        }
                    },
                    elementAvailability: {
                        name: "addClass",
                        options: {
                            className: "available-cell"
                        }
                    }
                },
                preventContextMenu: !0,
                restrictTranslate: !1,
                markAvailable: !1,
                defaultLink: new joint.dia.Link,
                defaultConnector: {
                    name: "normal"
                },
                defaultRouter: {
                    name: "normal"
                },
                validateMagnet: function(a, b) {
                    return "passive" !== b.getAttribute("magnet")
                },
                validateConnection: function(a, b, c, d, e, f) {
                    return ("target" === e ? c : a) instanceof joint.dia.ElementView
                },
                embeddingMode: !1,
                validateEmbedding: function(a, b) {
                    return !0
                },
                findParentBy: "bbox",
                frontParentOnly: !0,
                interactive: {
                    labelMove: !1
                },
                linkPinning: !0,
                clickThreshold: 0,
                cellViewNamespace: joint.shapes,
                highlighterNamespace: joint.highlighters
            },
            events: {
                mousedown: "pointerdown",
                dblclick: "mousedblclick",
                click: "mouseclick",
                touchstart: "pointerdown",
                touchend: "mouseclick",
                touchmove: "pointermove",
                mousemove: "pointermove",
                "mouseover .joint-cell": "cellMouseover",
                "mouseout .joint-cell": "cellMouseout",
                contextmenu: "contextmenu",
                mousewheel: "mousewheel",
                DOMMouseScroll: "mousewheel"
            },
            _highlights: [],
            init: function() {
                _.bindAll(this, "pointerup"), this.model = this.options.model || new joint.dia.Graph, this.options.origin = _.clone(this.options.origin), this.options.defaultConnector = _.clone(this.options.defaultConnector), _.defaults(this.options.highlighting, this.constructor.prototype.options.highlighting), this.options.highlighting = _.cloneDeep(this.options.highlighting), this.svg = V("svg").node, this.viewport = V("g").addClass(joint.util.addClassNamePrefix("viewport")).node, this.defs = V("defs").node, V(this.svg).append([this.viewport, this.defs]), this.$el.append(this.svg), this.listenTo(this.model, "add", this.onCellAdded), this.listenTo(this.model, "remove", this.removeView), this.listenTo(this.model, "reset", this.resetViews), this.listenTo(this.model, "sort", this._onSort), this.listenTo(this.model, "batch:stop", this._onBatchStop), this.setOrigin(), this.setDimensions(), $(document).on("mouseup touchend", this.pointerup), this._mousemoved = 0, this._views = {}, this.on("cell:highlight", this.onCellHighlight, this), this.on("cell:unhighlight", this.onCellUnhighlight, this)
            },
            _onSort: function() {
                this.model.hasActiveBatch("add") || this.sortViews()
            },
            _onBatchStop: function(a) {
                var b = a && a.batchName;
                "add" !== b || this.model.hasActiveBatch("add") || this.sortViews()
            },
            onRemove: function() {
                this.removeViews(), $(document).off("mouseup touchend", this.pointerup)
            },
            setDimensions: function(a, b) {
                a = this.options.width = a || this.options.width, b = this.options.height = b || this.options.height, V(this.svg).attr({
                    width: a,
                    height: b
                }), this.trigger("resize", a, b)
            },
            setOrigin: function(a, b) {
                this.options.origin.x = a || 0, this.options.origin.y = b || 0, V(this.viewport).translate(a, b, {
                    absolute: !0
                }), this.trigger("translate", a, b), this.options.drawGrid && this.drawGrid()
            },
            fitToContent: function(a, b, c, d) {
                _.isObject(a) ? (d = a, a = d.gridWidth || 1, b = d.gridHeight || 1, c = d.padding || 0) : (d = d || {}, a = a || 1, b = b || 1, c = c || 0), c = joint.util.normalizeSides(c);
                var e = V(this.viewport).bbox(!0, this.svg),
                    f = V(this.viewport).scale();
                e.x *= f.sx, e.y *= f.sy, e.width *= f.sx, e.height *= f.sy;
                var g = Math.max(Math.ceil((e.width + e.x) / a), 1) * a,
                    h = Math.max(Math.ceil((e.height + e.y) / b), 1) * b,
                    i = 0,
                    j = 0;
                ("negative" == d.allowNewOrigin && e.x < 0 || "positive" == d.allowNewOrigin && e.x >= 0 || "any" == d.allowNewOrigin) && (i = Math.ceil(-e.x / a) * a, i += c.left, g += i), ("negative" == d.allowNewOrigin && e.y < 0 || "positive" == d.allowNewOrigin && e.y >= 0 || "any" == d.allowNewOrigin) && (j = Math.ceil(-e.y / b) * b, j += c.top, h += j), g += c.right, h += c.bottom, g = Math.max(g, d.minWidth || 0), h = Math.max(h, d.minHeight || 0), g = Math.min(g, d.maxWidth || Number.MAX_VALUE), h = Math.min(h, d.maxHeight || Number.MAX_VALUE);
                var k = g != this.options.width || h != this.options.height,
                    l = i != this.options.origin.x || j != this.options.origin.y;
                l && this.setOrigin(i, j), k && this.setDimensions(g, h)
            },
            scaleContentToFit: function(a) {
                var b = this.getContentBBox();
                if (b.width && b.height) {
                    a = a || {}, _.defaults(a, {
                        padding: 0,
                        preserveAspectRatio: !0,
                        scaleGrid: null,
                        minScale: 0,
                        maxScale: Number.MAX_VALUE
                    });
                    var c = a.padding,
                        d = a.minScaleX || a.minScale,
                        e = a.maxScaleX || a.maxScale,
                        f = a.minScaleY || a.minScale,
                        h = a.maxScaleY || a.maxScale,
                        i = a.fittingBBox || {
                            x: this.options.origin.x,
                            y: this.options.origin.y,
                            width: this.options.width,
                            height: this.options.height
                        };
                    i = g.rect(i).moveAndExpand({
                        x: c,
                        y: c,
                        width: -2 * c,
                        height: -2 * c
                    });
                    var j = V(this.viewport).scale(),
                        k = i.width / b.width * j.sx,
                        l = i.height / b.height * j.sy;
                    if (a.preserveAspectRatio && (k = l = Math.min(k, l)), a.scaleGrid) {
                        var m = a.scaleGrid;
                        k = m * Math.floor(k / m), l = m * Math.floor(l / m)
                    }
                    k = Math.min(e, Math.max(d, k)), l = Math.min(h, Math.max(f, l)), this.scale(k, l);
                    var n = this.getContentBBox(),
                        o = i.x - n.x,
                        p = i.y - n.y;
                    this.setOrigin(o, p)
                }
            },
            getContentBBox: function() {
                var a = this.viewport.getBoundingClientRect(),
                    b = this.viewport.getScreenCTM(),
                    c = this.viewport.getCTM();
                return g.rect({
                    x: a.left - b.e + c.e,
                    y: a.top - b.f + c.f,
                    width: a.width,
                    height: a.height
                })
            },
            getArea: function() {
                var a = this.viewport.getCTM().inverse(),
                    b = {
                        x: 0,
                        y: 0,
                        width: this.options.width,
                        height: this.options.height
                    };
                return g.rect(V.transformRect(b, a))
            },
            getRestrictedArea: function() {
                var a;
                return a = _.isFunction(this.options.restrictTranslate) ? this.options.restrictTranslate.apply(this, arguments) : this.options.restrictTranslate === !0 ? this.getArea() : this.options.restrictTranslate || null
            },
            createViewForModel: function(a) {
                var b, c, d = this.options.cellViewNamespace,
                    e = a.get("type") + "View",
                    f = joint.util.getByPath(d, e, ".");
                a.isLink() ? (b = this.options.linkView, c = joint.dia.LinkView) : (b = this.options.elementView, c = joint.dia.ElementView);
                var g = b.prototype instanceof Backbone.View ? f || b : b.call(this, a) || f || c;
                return new g({
                    model: a,
                    interactive: this.options.interactive
                })
            },
            onCellAdded: function(a, b, c) {
                if (this.options.async && c.async !== !1 && _.isNumber(c.position)) {
                    if (this._asyncCells = this._asyncCells || [], this._asyncCells.push(a), 0 == c.position) {
                        if (this._frameId) throw new Error("another asynchronous rendering in progress");
                        this.asyncRenderViews(this._asyncCells, c), delete this._asyncCells
                    }
                } else this.renderView(a)
            },
            removeView: function(a) {
                var b = this._views[a.id];
                return b && (b.remove(), delete this._views[a.id]), b
            },
            renderView: function(a) {
                var b = this._views[a.id] = this.createViewForModel(a);
                return V(this.viewport).append(b.el), b.paper = this, b.render(), $(b.el).find("image").on("dragstart", function() {
                    return !1
                }), b
            },
            beforeRenderViews: function(a) {
                return a.sort(function(a) {
                    return a instanceof joint.dia.Link ? 1 : -1
                }), a
            },
            afterRenderViews: function() {
                this.sortViews()
            },
            resetViews: function(a, b) {
                this.removeViews();
                var c = a.models.slice();
                c = this.beforeRenderViews(c, b) || c, this._frameId && (joint.util.cancelFrame(this._frameId), delete this._frameId), this.options.async ? this.asyncRenderViews(c, b) : (_.each(c, this.renderView, this), this.sortViews())
            },
            removeViews: function() {
                _.invoke(this._views, "remove"), this._views = {}
            },
            asyncBatchAdded: _.noop,
            asyncRenderViews: function(a, b) {
                if (this._frameId) {
                    var c = this.options.async && this.options.async.batchSize || 50,
                        d = a.splice(0, c),
                        e = this.model.get("cells");
                    _.each(d, function(a) {
                        a.collection === e && this.renderView(a)
                    }, this), this.asyncBatchAdded()
                }
                a.length ? this._frameId = joint.util.nextFrame(function() {
                    this.asyncRenderViews(a, b)
                }, this) : (delete this._frameId, this.afterRenderViews(b), this.trigger("render:done", b))
            },
            sortViews: function() {
                var a = $(this.viewport).children("[model-id]"),
                    b = this.model.get("cells");
                joint.util.sortElements(a, function(a, c) {
                    var d = b.get($(a).attr("model-id")),
                        e = b.get($(c).attr("model-id"));
                    return (d.get("z") || 0) > (e.get("z") || 0) ? 1 : -1
                })
            },
            scale: function(a, b, c, d) {
                b = b || a, _.isUndefined(c) && (c = 0, d = 0), V(this.viewport).attr("transform", "");
                var e = this.options.origin.x,
                    f = this.options.origin.y;
                if (c || d || e || f) {
                    var g = e - c * (a - 1),
                        h = f - d * (b - 1);
                    this.setOrigin(g, h)
                }
                return V(this.viewport).scale(a, b), this.trigger("scale", a, b, c, d), this.options.drawGrid && this.drawGrid(), this
            },
            rotate: function(a, b, c) {
                if (_.isUndefined(b)) {
                    var d = this.viewport.getBBox();
                    b = d.width / 2, c = d.height / 2
                }
                V(this.viewport).rotate(a, b, c)
            },
            findView: function(a) {
                for (var b = _.isString(a) ? this.viewport.querySelector(a) : a instanceof $ ? a[0] : a; b && b !== this.el && b !== document;) {
                    var c = b.getAttribute("model-id");
                    if (c) return this._views[c];
                    b = b.parentNode
                }
            },
            findViewByModel: function(a) {
                var b = _.isString(a) ? a : a.id;
                return this._views[b]
            },
            findViewsFromPoint: function(a) {
                a = g.point(a);
                var b = _.map(this.model.getElements(), this.findViewByModel, this);
                return _.filter(b, function(b) {
                    return b && g.rect(b.vel.bbox(!1, this.viewport)).containsPoint(a)
                }, this)
            },
            findViewsInArea: function(a, b) {
                b = _.defaults(b || {}, {
                    strict: !1
                }), a = g.rect(a);
                var c = _.map(this.model.getElements(), this.findViewByModel, this),
                    d = b.strict ? "containsRect" : "intersect";
                return _.filter(c, function(b) {
                    return b && a[d](g.rect(b.vel.bbox(!1, this.viewport)))
                }, this)
            },
            getModelById: function(a) {
                return this.model.getCell(a)
            },
            snapToGrid: function(a) {
                var b = V(this.viewport).toLocalPoint(a.x, a.y);
                return {
                    x: g.snapToGrid(b.x, this.options.gridSize),
                    y: g.snapToGrid(b.y, this.options.gridSize)
                }
            },
            clientToLocalPoint: function(a) {
                a = g.point(a);
                var b = V("rect", {
                    width: this.options.width,
                    height: this.options.height,
                    x: 0,
                    y: 0,
                    opacity: 0
                });
                V(this.svg).prepend(b);
                var c = $(this.svg).offset();
                b.remove();
                var d = document.body.scrollTop || document.documentElement.scrollTop,
                    e = document.body.scrollLeft || document.documentElement.scrollLeft;
                return a.offset(e - c.left, d - c.top), V.transformPoint(a, this.viewport.getCTM().inverse())
            },
            linkAllowed: function(a) {
                var b;
                if (a instanceof joint.dia.Link) b = a;
                else {
                    if (!(a instanceof joint.dia.LinkView)) throw new Error("Must provide link model or view.");
                    b = a.model
                }
                if (!this.options.multiLinks) {
                    var c = b.get("source"),
                        d = b.get("target");
                    if (c.id && d.id) {
                        var e = b.getSourceElement();
                        if (e) {
                            var f = this.model.getConnectedLinks(e, {
                                    outbound: !0,
                                    inbound: !1
                                }),
                                g = _.filter(f, function(a) {
                                    var b = a.get("source"),
                                        e = a.get("target");
                                    return b && b.id === c.id && (!b.port || b.port === c.port) && e && e.id === d.id && (!e.port || e.port === d.port)
                                }).length;
                            if (g > 1) return !1
                        }
                    }
                }
                return !!(this.options.linkPinning || _.has(b.get("source"), "id") && _.has(b.get("target"), "id"))
            },
            getDefaultLink: function(a, b) {
                return _.isFunction(this.options.defaultLink) ? this.options.defaultLink.call(this, a, b) : this.options.defaultLink.clone()
            },
            resolveHighlighter: function(a) {
                a = a || {};
                var b = a.highlighter,
                    c = this.options;
                if (_.isUndefined(b)) {
                    var d = _.chain(a).pick("embedding", "connecting", "magnetAvailability", "elementAvailability").keys().first().value();
                    b = d && c.highlighting[d] || c.highlighting.default
                }
                if (!b) return !1;
                _.isString(b) && (b = {
                    name: b
                });
                var e = b.name,
                    f = c.highlighterNamespace[e];
                if (!f) throw new Error('Unknown highlighter ("' + e + '")');
                if ("function" != typeof f.highlight) throw new Error('Highlighter ("' + e + '") is missing required highlight() method');
                if ("function" != typeof f.unhighlight) throw new Error('Highlighter ("' + e + '") is missing required unhighlight() method');
                return {
                    highlighter: f,
                    options: b.options || {},
                    name: e
                }
            },
            onCellHighlight: function(a, b, c) {
                if (c = this.resolveHighlighter(c)) {
                    var d = c.name + b.id + JSON.stringify(c.options);
                    if (!this._highlights[d]) {
                        var e = c.highlighter;
                        e.highlight(a, b, _.clone(c.options)), this._highlights[d] = {
                            cellView: a,
                            magnetEl: b,
                            opt: c.options,
                            highlighter: e
                        }
                    }
                }
            },
            onCellUnhighlight: function(a, b, c) {
                if (c = this.resolveHighlighter(c)) {
                    var d = c.name + b.id + JSON.stringify(c.options),
                        e = this._highlights[d];
                    e && (e.highlighter.unhighlight(e.cellView, e.magnetEl, e.opt), this._highlights[d] = null)
                }
            },
            mousedblclick: function(a) {
                a.preventDefault(), a = joint.util.normalizeEvent(a);
                var b = this.findView(a.target);
                if (!this.guard(a, b)) {
                    var c = this.snapToGrid({
                        x: a.clientX,
                        y: a.clientY
                    });
                    b ? b.pointerdblclick(a, c.x, c.y) : this.trigger("blank:pointerdblclick", a, c.x, c.y)
                }
            },
            mouseclick: function(a) {
                if (this._mousemoved <= this.options.clickThreshold) {
                    a = joint.util.normalizeEvent(a);
                    var b = this.findView(a.target);
                    if (this.guard(a, b)) return;
                    var c = this.snapToGrid({
                        x: a.clientX,
                        y: a.clientY
                    });
                    b ? b.pointerclick(a, c.x, c.y) : this.trigger("blank:pointerclick", a, c.x, c.y)
                }
            },
            guard: function(a, b) {
                return !(!this.options.guard || !this.options.guard(a, b)) || (a.data && !_.isUndefined(a.data.guarded) ? a.data.guarded : !(b && b.model && b.model instanceof joint.dia.Cell) && (this.svg !== a.target && this.el !== a.target && !$.contains(this.svg, a.target)))
            },
            contextmenu: function(a) {
                a = joint.util.normalizeEvent(a), this.options.preventContextMenu && a.preventDefault();
                var b = this.findView(a.target);
                if (!this.guard(a, b)) {
                    var c = this.snapToGrid({
                        x: a.clientX,
                        y: a.clientY
                    });
                    b ? b.contextmenu(a, c.x, c.y) : this.trigger("blank:contextmenu", a, c.x, c.y)
                }
            },
            pointerdown: function(a) {
                a = joint.util.normalizeEvent(a);
                var b = this.findView(a.target);
                if (!this.guard(a, b)) {
                    a.preventDefault(), this._mousemoved = 0;
                    var c = this.snapToGrid({
                        x: a.clientX,
                        y: a.clientY
                    });
                    b ? (this.sourceView = b, b.pointerdown(a, c.x, c.y)) : this.trigger("blank:pointerdown", a, c.x, c.y)
                }
            },
            pointermove: function(a) {
                if (this.sourceView) {
                    a.preventDefault(), a = joint.util.normalizeEvent(a), this._mousemoved++;
                    var b = this.snapToGrid({
                        x: a.clientX,
                        y: a.clientY
                    });
                    this.sourceView.pointermove(a, b.x, b.y)
                }
            },
            pointerup: function(a) {
                a = joint.util.normalizeEvent(a);
                var b = this.snapToGrid({
                    x: a.clientX,
                    y: a.clientY
                });
                this.sourceView ? (this.sourceView.pointerup(a, b.x, b.y), this.sourceView = null) : this.trigger("blank:pointerup", a, b.x, b.y)
            },
            mousewheel: function(a) {
                a = joint.util.normalizeEvent(a);
                var b = this.findView(a.target);
                if (!this.guard(a, b)) {
                    var c = a.originalEvent,
                        d = this.snapToGrid({
                            x: c.clientX,
                            y: c.clientY
                        }),
                        e = Math.max(-1, Math.min(1, c.wheelDelta || -c.detail));
                    b ? b.mousewheel(a, d.x, d.y, e) : this.trigger("blank:mousewheel", a, d.x, d.y, e)
                }
            },
            cellMouseover: function(a) {
                a = joint.util.normalizeEvent(a);
                var b = this.findView(a.target);
                if (b) {
                    if (this.guard(a, b)) return;
                    b.mouseover(a)
                }
            },
            cellMouseout: function(a) {
                a = joint.util.normalizeEvent(a);
                var b = this.findView(a.target);
                if (b) {
                    if (this.guard(a, b)) return;
                    b.mouseout(a)
                }
            },
            setGridSize: function(a) {
                return this.options.gridSize = a, this.options.drawGrid && this.drawGrid(), this
            },
            clearGrid: function() {
                return this.el.style.backgroundImage = "none", this
            },
            drawGrid: function(a) {
                a = _.defaults(a || {}, this.options.drawGrid, {
                    color: "#aaa",
                    thickness: 1
                });
                var b = this.options.gridSize;
                if (b <= 1) return this.clearGrid();
                var c = V(this.viewport).scale(),
                    d = c.sx,
                    e = c.sy,
                    f = this.options.origin.x,
                    g = this.options.origin.y,
                    h = b * d,
                    i = b * e,
                    j = document.createElement("canvas");
                j.width = h, j.height = i, h = f >= 0 ? f % h : h + f % h, i = g >= 0 ? g % i : i + g % i;
                var k = j.getContext("2d");
                k.beginPath(), k.rect(h, i, a.thickness * d, a.thickness * e), k.fillStyle = a.color, k.fill();
                var l = j.toDataURL("image/png");
                return this.el.style.backgroundImage = 'url("' + l + '")', this
            },
            setInteractivity: function(a) {
                this.options.interactive = a, _.invoke(this._views, "setInteractivity", a)
            }
        }),
        function(a, b) {
            var c = function(a) {
                var c = b.cloneDeep(a);
                this.ports = [], this.groups = this._getNormalizedGroups(c), this._init(c)
            };
            c.prototype = {
                getPorts: function() {
                    return this.ports
                },
                getPort: function(a) {
                    return b.find(this.ports, function(b) {
                        return b.id === a
                    })
                },
                getGroup: function(a) {
                    return this.groups[a] || this._createGroupNode()
                },
                addPort: function(a) {
                    a = this._evaluatePort(a), this.ports.push(a)
                },
                _init: function(a) {
                    a = a || {};
                    var c = a.items || [];
                    b.each(c, function(a) {
                        this.addPort(a)
                    }, this)
                },
                _evaluatePort: function(a) {
                    var c = b.clone(a),
                        d = b.extend(this._createGroupNode(), a.group ? this.groups[a.group] : null);
                    return c.markup = c.markup || d.markup, c.attrs = b.merge({}, d.attrs, c.attrs), c.position = b.merge(this._createPositionNode(), d.position, {
                        args: c.args
                    }), c.label = b.merge({}, d.label, this._getLabel(c)), c.z = this._getZIndex(c.z, d.z), c
                },
                _getZIndex: function(a, c) {
                    return b.isNumber(a) ? a : b.isNumber(c) || "auto" === c ? c : "auto"
                },
                _createPositionNode: function() {
                    return {
                        name: "left",
                        args: {}
                    }
                },
                _createGroupNode: function() {
                    return {
                        position: {},
                        label: {
                            position: {
                                name: "left",
                                args: {}
                            }
                        }
                    }
                },
                _getNormalizedGroups: function(a) {
                    return a = a || {}, a.groups = a.groups || {}, b.each(a.groups, function(a) {
                        a.position = this._getPosition(a.position, !0), a.label = this._getLabel(a, !0)
                    }, this), a.groups
                },
                _getPosition: function(a, c) {
                    var d, e = {};
                    b.isFunction(a) ? (d = "fn", e.fn = a) : b.isString(a) ? d = a : b.isUndefined(a) ? d = c ? "left" : null : b.isArray(a) ? (d = "absolute", e.x = a[0], e.y = a[1]) : b.isObject(a) && (d = a.name, b.extend(e, a.args));
                    var f = {
                        args: e
                    };
                    return d && (f.name = d), f
                },
                _getLabel: function(a, b) {
                    var c = a.label || {},
                        d = c;
                    return d.position = this._getPosition(c.position, b), d
                }
            }, b.extend(a.dia.Element.prototype, {
                _initializePorts: function() {
                    this._createPortData(), this.on("change:ports", function() {
                        this._processRemovedPort(), this._createPortData()
                    }, this)
                },
                _processRemovedPort: function() {
                    var a = this.get("ports") || {},
                        c = {};
                    b.each(a.items, function(a) {
                        c[a.id] = !0
                    });
                    var d = this.previous("ports") || {},
                        e = {};
                    b.each(d.items, function(a) {
                        c[a.id] || (e[a.id] = !0)
                    });
                    var f = this.graph;
                    if (f && !b.isEmpty(e)) {
                        var g = f.getConnectedLinks(this, {
                            inbound: !0
                        });
                        b.each(g, function(a) {
                            e[a.get("target").port] && a.remove()
                        });
                        var h = f.getConnectedLinks(this, {
                            outbound: !0
                        });
                        b.each(h, function(a) {
                            e[a.get("source").port] && a.remove()
                        })
                    }
                },
                hasPorts: function() {
                    return this.prop("ports/items").length > 0
                },
                hasPort: function(a) {
                    return this.getPortIndex(a) !== -1
                },
                getPorts: function() {
                    return b.cloneDeep(this.prop("ports/items")) || []
                },
                getPort: function(a) {
                    return b.cloneDeep(b.find(this.prop("ports/items"), function(b) {
                        return b.id && b.id === a
                    }))
                },
                getPortIndex: function(a) {
                    var c = b.isObject(a) ? a.id : a;
                    return this._isValidPortId(c) ? b.findIndex(this.prop("ports/items"), {
                        id: c
                    }) : -1
                },
                addPort: function(a, c) {
                    if (!b.isObject(a) || b.isArray(a)) throw new Error("Element: addPort requires an object.");
                    var d = b.clone(this.prop("ports/items")) || [];
                    return d.push(a), this.prop("ports/items", d, c), this
                },
                portProp: function(a, c, d, e) {
                    var f = this.getPortIndex(a);
                    if (f === -1) throw new Error("Element: unable to find port with id " + a);
                    var g;
                    return b.isString(c) ? (g = Array.prototype.slice.call(arguments, 1), g[0] = ["ports/items/", f, "/", c].join("")) : g = ["ports/items/" + f, c, d], this.prop.apply(this, g)
                },
                _validatePorts: function() {
                    var c = this.get("ports") || {},
                        d = [];
                    c = c || {};
                    var e = c.items || [];
                    return b.each(e, function(b) {
                        this._isValidPortId(b.id) || (b.id = a.util.uuid())
                    }, this), b.uniq(e, "id").length !== e.length && d.push("Element: found id duplicities in ports."), d
                },
                _isValidPortId: function(a) {
                    return !b.isNull(a) && !b.isUndefined(a) && !b.isObject(a)
                },
                addPorts: function(a, c) {
                    return a.length && this.prop("ports/items", (b.clone(this.prop("ports/items")) || []).concat(a), c), this
                },
                removePort: function(a, c) {
                    var d = c || {},
                        e = b.clone(this.prop("ports/items")),
                        f = this.getPortIndex(a);
                    return f !== -1 && (e.splice(f, 1), d.rewrite = !0, this.prop("ports/items", e, d)), this
                },
                _createPortData: function() {
                    var a = this._validatePorts();
                    if (a.length > 0) throw this.set("ports", this.previous("ports")), new Error(a.join(" "));
                    this.portData = new c(this.get("ports"))
                }
            }), b.extend(a.dia.ElementView.prototype, {
                portContainerMarkup: '<g class="joint-port"/>',
                portMarkup: '<circle class="joint-port-body" r="10" fill="#FFFFFF" stroke="#000000"/>',
                portLabelMarkup: '<text class="joint-port-label" fill="#000000"/>',
                _portElementsCache: null,
                _initializePorts: function() {
                    this._portElementsCache = {}, this.listenTo(this.model, "change:ports", function() {
                        this._refreshPorts()
                    })
                },
                _refreshPorts: function() {
                    this._removePorts(), this._portElementsCache = {}, this._renderPorts()
                },
                _renderPorts: function() {
                    var a = [],
                        c = this._getContainerElement();
                    b.each(c.node.childNodes, function(b) {
                        a.push(b)
                    });
                    var d = b.groupBy(this.model.portData.getPorts(), "z"),
                        e = "auto";
                    b.each(d[e], function(b) {
                        var d = this._getPortElement(b);
                        c.append(d), a.push(d)
                    }, this), b.each(d, function(b, c) {
                        if (c !== e) {
                            var f = parseInt(c, 10);
                            this._appendPorts(d[c], f, a)
                        }
                    }, this), this._updatePorts()
                },
                _getContainerElement: function() {
                    return this.rotatableNode || this.vel
                },
                _appendPorts: function(a, c, d) {
                    var e = this._getContainerElement(),
                        f = b.map(a, this._getPortElement, this);
                    d[c] || c < 0 ? V(d[Math.max(c, 0)]).before(f) : e.append(f)
                },
                _getPortElement: function(a) {
                    return this._portElementsCache[a.id] ? this._portElementsCache[a.id].portElement : this._createPortElement(a)
                },
                _updatePorts: function() {
                    var a = g.rect(this.model.get("size")),
                        c = this.model.portData.getPorts();
                    b.each(b.groupBy(c, "group"), function(c, d) {
                        var e = this.model.portData.getGroup(d);
                        b.each(c, this._updatePortAttrs, this), this._layoutPorts(c, e, a.clone())
                    }, this)
                },
                _removePorts: function() {
                    b.invoke(this._portElementsCache, "portElement.remove")
                },
                _createPortElement: function(a) {
                    var b = V(this._getPortMarkup(a)),
                        c = V(this._getPortLabelMarkup(a.label));
                    if (b && b.length > 1) throw new Error("ElementView: Invalid port markup - multiple roots.");
                    b.attr({
                        port: a.id,
                        "port-group": a.group
                    });
                    var d = V(this.portContainerMarkup).append(b).append(c);
                    return this._portElementsCache[a.id] = {
                        portElement: d,
                        portLabelElement: c
                    }, d
                },
                _updatePortAttrs: function(a) {
                    var b = a.attrs || {},
                        c = this._portElementsCache[a.id];
                    c && this._updateAllAttrs(c.portElement.node, b)
                },
                _updateAllAttrs: function(a, c) {
                    b.each(c, function(b, c) {
                        var d = "." === c ? $(a) : $(a).find(c);
                        this.updateAttr(d, b)
                    }, this)
                },
                _layoutPorts: function(c, d, e) {
                    var f = d.position.name,
                        h = a.layout.Port;
                    h[f] || (f = "left");
                    var i = h[f](b.pluck(c, "position.args"), e, d.position.args || {});
                    b.each(i, function(b, d) {
                        var f = this.model.portData.getPort(c[d].id),
                            h = this._portElementsCache[f.id] || {};
                        this.applyPortTransform(h.portElement, b);
                        var i = a.layout.PortLabel,
                            j = f.label.position.name;
                        if (i[j]) {
                            var k = i[j](g.point(b), e, f.label.position.args);
                            this.applyPortTransform(h.portLabelElement, k, -(b.angle || 0))
                        }
                    }, this)
                },
                applyPortTransform: function(a, b, c) {
                    var d = V.createSVGMatrix().rotate(c || 0).translate(b.x || 0, b.y || 0).rotate(b.angle || 0);
                    a.transform(d, {
                        absolute: !0
                    }), this._updateAllAttrs(a.node, b.attrs || {})
                },
                _getPortMarkup: function(a) {
                    return a.markup || this.model.get("portMarkup") || this.model.portMarkup || this.portMarkup
                },
                _getPortLabelMarkup: function(a) {
                    return a.markup || this.model.get("portLabelMarkup") || this.model.portLabelMarkup || this.portLabelMarkup
                }
            })
        }(joint, _), joint.shapes.basic = {}, joint.shapes.basic.Generic = joint.dia.Element.extend({
            defaults: _.defaultsDeep({
                type: "basic.Generic",
                attrs: {
                    ".": {
                        fill: "#ffffff",
                        stroke: "none"
                    }
                }
            }, joint.dia.Element.prototype.defaults)
        }), joint.shapes.basic.Rect = joint.shapes.basic.Generic.extend({
            markup: '<g class="rotatable"><g class="scalable"><rect/></g><text/></g>',
            defaults: _.defaultsDeep({
                type: "basic.Rect",
                attrs: {
                    rect: {
                        fill: "#ffffff",
                        stroke: "#000000",
                        width: 100,
                        height: 60
                    },
                    text: {
                        fill: "#000000",
                        text: "",
                        "font-size": 14,
                        "ref-x": .5,
                        "ref-y": .5,
                        "text-anchor": "middle",
                        "y-alignment": "middle",
                        "font-family": "Arial, helvetica, sans-serif"
                    }
                }
            }, joint.shapes.basic.Generic.prototype.defaults)
        }), joint.shapes.basic.TextView = joint.dia.ElementView.extend({
            initialize: function() {
                joint.dia.ElementView.prototype.initialize.apply(this, arguments), this.listenTo(this.model, "change:attrs", this.resize)
            }
        }), joint.shapes.basic.Text = joint.shapes.basic.Generic.extend({
            markup: '<g class="rotatable"><g class="scalable"><text/></g></g>',
            defaults: _.defaultsDeep({
                type: "basic.Text",
                attrs: {
                    text: {
                        "font-size": 18,
                        fill: "#000000"
                    }
                }
            }, joint.shapes.basic.Generic.prototype.defaults)
        }), joint.shapes.basic.Circle = joint.shapes.basic.Generic.extend({
            markup: '<g class="rotatable"><g class="scalable"><circle/></g><text/></g>',
            defaults: _.defaultsDeep({
                type: "basic.Circle",
                size: {
                    width: 60,
                    height: 60
                },
                attrs: {
                    circle: {
                        fill: "#ffffff",
                        stroke: "#000000",
                        r: 30,
                        cx: 30,
                        cy: 30
                    },
                    text: {
                        "font-size": 14,
                        text: "",
                        "text-anchor": "middle",
                        "ref-x": .5,
                        "ref-y": .5,
                        "y-alignment": "middle",
                        fill: "#000000",
                        "font-family": "Arial, helvetica, sans-serif"
                    }
                }
            }, joint.shapes.basic.Generic.prototype.defaults)
        }), joint.shapes.basic.Ellipse = joint.shapes.basic.Generic.extend({
            markup: '<g class="rotatable"><g class="scalable"><ellipse/></g><text/></g>',
            defaults: _.defaultsDeep({
                type: "basic.Ellipse",
                size: {
                    width: 60,
                    height: 40
                },
                attrs: {
                    ellipse: {
                        fill: "#ffffff",
                        stroke: "#000000",
                        rx: 30,
                        ry: 20,
                        cx: 30,
                        cy: 20
                    },
                    text: {
                        "font-size": 14,
                        text: "",
                        "text-anchor": "middle",
                        "ref-x": .5,
                        "ref-y": .5,
                        "y-alignment": "middle",
                        fill: "#000000",
                        "font-family": "Arial, helvetica, sans-serif"
                    }
                }
            }, joint.shapes.basic.Generic.prototype.defaults)
        }), joint.shapes.basic.Polygon = joint.shapes.basic.Generic.extend({
            markup: '<g class="rotatable"><g class="scalable"><polygon/></g><text/></g>',
            defaults: _.defaultsDeep({
                type: "basic.Polygon",
                size: {
                    width: 60,
                    height: 40
                },
                attrs: {
                    polygon: {
                        fill: "#ffffff",
                        stroke: "#000000"
                    },
                    text: {
                        "font-size": 14,
                        text: "",
                        "text-anchor": "middle",
                        "ref-x": .5,
                        "ref-dy": 20,
                        "y-alignment": "middle",
                        fill: "#000000",
                        "font-family": "Arial, helvetica, sans-serif"
                    }
                }
            }, joint.shapes.basic.Generic.prototype.defaults)
        }), joint.shapes.basic.Polyline = joint.shapes.basic.Generic.extend({
            markup: '<g class="rotatable"><g class="scalable"><polyline/></g><text/></g>',
            defaults: _.defaultsDeep({
                type: "basic.Polyline",
                size: {
                    width: 60,
                    height: 40
                },
                attrs: {
                    polyline: {
                        fill: "#ffffff",
                        stroke: "#000000"
                    },
                    text: {
                        "font-size": 14,
                        text: "",
                        "text-anchor": "middle",
                        "ref-x": .5,
                        "ref-dy": 20,
                        "y-alignment": "middle",
                        fill: "#000000",
                        "font-family": "Arial, helvetica, sans-serif"
                    }
                }
            }, joint.shapes.basic.Generic.prototype.defaults)
        }), joint.shapes.basic.Image = joint.shapes.basic.Generic.extend({
            markup: '<g class="rotatable"><g class="scalable"><image/></g><text/></g>',
            defaults: _.defaultsDeep({
                type: "basic.Image",
                attrs: {
                    text: {
                        "font-size": 14,
                        text: "",
                        "text-anchor": "middle",
                        "ref-x": .5,
                        "ref-dy": 20,
                        "y-alignment": "middle",
                        fill: "#000000",
                        "font-family": "Arial, helvetica, sans-serif"
                    }
                }
            }, joint.shapes.basic.Generic.prototype.defaults)
        }), joint.shapes.basic.Path = joint.shapes.basic.Generic.extend({
            markup: '<g class="rotatable"><g class="scalable"><path/></g><text/></g>',
            defaults: _.defaultsDeep({
                type: "basic.Path",
                size: {
                    width: 60,
                    height: 60
                },
                attrs: {
                    path: {
                        fill: "#ffffff",
                        stroke: "#000000"
                    },
                    text: {
                        "font-size": 14,
                        text: "",
                        "text-anchor": "middle",
                        ref: "path",
                        "ref-x": .5,
                        "ref-dy": 10,
                        fill: "#000000",
                        "font-family": "Arial, helvetica, sans-serif"
                    }
                }
            }, joint.shapes.basic.Generic.prototype.defaults)
        }), joint.shapes.basic.Rhombus = joint.shapes.basic.Path.extend({
            defaults: _.defaultsDeep({
                type: "basic.Rhombus",
                attrs: {
                    path: {
                        d: "M 30 0 L 60 30 30 60 0 30 z"
                    },
                    text: {
                        "ref-y": .5,
                        "y-alignment": "middle"
                    }
                }
            }, joint.shapes.basic.Path.prototype.defaults)
        }), joint.shapes.basic.PortsModelInterface = {
            initialize: function() {
                this.updatePortsAttrs(), this.on("change:inPorts change:outPorts", this.updatePortsAttrs, this), this.constructor.__super__.constructor.__super__.initialize.apply(this, arguments)
            },
            updatePortsAttrs: function(a) {
                if (this._portSelectors) {
                    var b = _.omit(this.get("attrs"), this._portSelectors);
                    this.set("attrs", b, {
                        silent: !0
                    })
                }
                this._portSelectors = [];
                var c = {};
                _.each(this.get("inPorts"), function(a, b, d) {
                    var e = this.getPortAttrs(a, b, d.length, ".inPorts", "in");
                    this._portSelectors = this._portSelectors.concat(_.keys(e)), _.extend(c, e)
                }, this), _.each(this.get("outPorts"), function(a, b, d) {
                    var e = this.getPortAttrs(a, b, d.length, ".outPorts", "out");
                    this._portSelectors = this._portSelectors.concat(_.keys(e)), _.extend(c, e)
                }, this), this.attr(c, {
                    silent: !0
                }), this.processPorts(), this.trigger("process:ports")
            },
            getPortSelector: function(a) {
                var b = ".inPorts",
                    c = this.get("inPorts").indexOf(a);
                if (c < 0 && (b = ".outPorts", c = this.get("outPorts").indexOf(a), c < 0)) throw new Error("getPortSelector(): Port doesn't exist.");
                return b + ">g:nth-child(" + (c + 1) + ")>.port-body"
            }
        }, joint.shapes.basic.PortsViewInterface = {
            initialize: function() {
                this.listenTo(this.model, "process:ports", this.update), joint.dia.ElementView.prototype.initialize.apply(this, arguments)
            },
            update: function() {
                this.renderPorts(), joint.dia.ElementView.prototype.update.apply(this, arguments)
            },
            renderPorts: function() {
                var a = this.$(".inPorts").empty(),
                    b = this.$(".outPorts").empty(),
                    c = joint.util.template(this.model.portMarkup);
                _.each(_.filter(this.model.ports, function(a) {
                    return "in" === a.type
                }), function(b, d) {
                    a.append(V(c({
                        id: d,
                        port: b
                    })).node)
                }), _.each(_.filter(this.model.ports, function(a) {
                    return "out" === a.type
                }), function(a, d) {
                    b.append(V(c({
                        id: d,
                        port: a
                    })).node)
                })
            }
        }, joint.shapes.basic.TextBlock = joint.shapes.basic.Generic.extend({
            markup: ['<g class="rotatable">', '<g class="scalable"><rect/></g>', joint.env.test("svgforeignobject") ? '<foreignObject class="fobj"><body xmlns="http://www.w3.org/1999/xhtml"><div class="content"/></body></foreignObject>' : '<text class="content"/>', "</g>"].join(""),
            defaults: _.defaultsDeep({
                type: "basic.TextBlock",
                attrs: {
                    rect: {
                        fill: "#ffffff",
                        stroke: "#000000",
                        width: 80,
                        height: 100
                    },
                    text: {
                        fill: "#000000",
                        "font-size": 14,
                        "font-family": "Arial, helvetica, sans-serif"
                    },
                    ".content": {
                        text: "",
                        ref: "rect",
                        "ref-x": .5,
                        "ref-y": .5,
                        "y-alignment": "middle",
                        "x-alignment": "middle"
                    }
                },
                content: ""
            }, joint.shapes.basic.Generic.prototype.defaults),
            initialize: function() {
                this.listenTo(this, "change:size", this.updateSize), this.listenTo(this, "change:content", this.updateContent), this.updateSize(this, this.get("size")), this.updateContent(this, this.get("content")), joint.shapes.basic.Generic.prototype.initialize.apply(this, arguments)
            },
            updateSize: function(a, b) {
                this.attr({
                    ".fobj": _.clone(b),
                    div: {
                        style: _.clone(b)
                    }
                })
            },
            updateContent: function(a, b) {
                joint.env.test("svgforeignobject") ? this.attr({
                    ".content": {
                        html: b
                    }
                }) : this.attr({
                    ".content": {
                        text: b
                    }
                })
            },
            setForeignObjectSize: function() {
                this.updateSize.apply(this, arguments)
            },
            setDivContent: function() {
                this.updateContent.apply(this, arguments)
            }
        }), joint.shapes.basic.TextBlockView = joint.dia.ElementView.extend({
            initialize: function() {
                joint.dia.ElementView.prototype.initialize.apply(this, arguments), this.noSVGForeignObjectElement = !joint.env.test("svgforeignobject"), joint.env.test("svgforeignobject") || this.listenTo(this.model, "change:content change:size", function(a) {
                    this.updateContent(a)
                })
            },
            update: function(a, b) {
                if (joint.env.test("svgforeignobject")) joint.dia.ElementView.prototype.update.call(this, c, b);
                else {
                    var c = this.model,
                        d = _.omit(b || c.get("attrs"), ".content");
                    joint.dia.ElementView.prototype.update.call(this, c, d), b && !_.has(b, ".content") || this.updateContent(c, b)
                }
            },
            updateContent: function(a, b) {
                var c = _.merge({}, (b || a.get("attrs"))[".content"]);
                c = _.omit(c, "text");
                var d = joint.util.breakText(a.get("content"), a.get("size"), c, {
                        svgDocument: this.paper.svg
                    }),
                    e = joint.util.setByPath({}, ".content", c, "/");
                e[".content"].text = d, joint.dia.ElementView.prototype.update.call(this, a, e)
            }
        }), joint.routers.manhattan = function(a, b, c) {
            "use strict";

            function d(a) {
                this.map = {}, this.options = a, this.mapGridSize = 100
            }

            function e() {
                this.items = [], this.hash = {}, this.values = {}, this.OPEN = 1, this.CLOSE = 2
            }

            function f(b) {
                return a.point(0 === b.x ? 0 : Math.abs(b.x) / b.x, 0 === b.y ? 0 : Math.abs(b.y) / b.y)
            }

            function g(b, c, d, e) {
                for (var g, h = [], i = f(e.difference(c)), j = c; g = b[j];) {
                    var k = f(j.difference(g));
                    k.equals(i) || (h.unshift(j), i = k), j = g
                }
                var l = f(a.point(j).difference(d));
                return l.equals(i) || h.unshift(j), h
            }

            function h(a, c, d) {
                var e = d.step,
                    f = a.center(),
                    g = b.chain(d.directionMap).pick(c).map(function(b) {
                        var c = b.x * a.width / 2,
                            d = b.y * a.height / 2,
                            g = f.clone().offset(c, d);
                        return a.containsPoint(g) && g.offset(b.x * e, b.y * e), g.snapToGrid(e)
                    }).value();
                return g
            }

            function i(b, c, d) {
                var e = 360 / d;
                return Math.floor(a.normalizeAngle(b.theta(c) + e / 2) / e) * e
            }

            function j(a, b) {
                var c = Math.abs(a - b);
                return c > 180 ? 360 - c : c
            }

            function k(a, b) {
                for (var c = 1 / 0, d = 0, e = b.length; d < e; d++) {
                    var f = a.manhattanDistance(b[d]);
                    f < c && (c = f)
                }
                return c
            }

            function l(c, d, f, l) {
                var m, n, o, p, q = l.step;
                if (c instanceof a.rect ? (m = h(c, l.startDirections, l), o = c.center().snapToGrid(q)) : (o = c.clone().snapToGrid(q), m = [o]), d instanceof a.rect ? (n = h(d, l.endDirections, l), p = d.center().snapToGrid(q)) : (p = d.clone().snapToGrid(q), n = [p]), m = b.filter(m, f.isPointAccessible, f), n = b.filter(n, f.isPointAccessible, f), m.length > 0 && n.length > 0) {
                    var r = new e,
                        s = {},
                        t = {};
                    b.each(m, function(a) {
                        var b = a.toString();
                        r.add(b, k(a, n)), t[b] = 0
                    });
                    for (var u, v, w = l.directions, x = w.length, y = l.maximumLoops, z = b.invoke(n, "toString"); !r.isEmpty() && y > 0;) {
                        var A = r.pop(),
                            B = a.point(A),
                            C = t[A],
                            D = E,
                            E = s[A] ? i(s[A], B, x) : null != l.previousDirAngle ? l.previousDirAngle : i(o, B, x);
                        if (z.indexOf(A) >= 0 && (v = j(E, i(B, p, x)), B.equals(p) || v < 180)) return l.previousDirAngle = E, g(s, B, o, p);
                        for (var F = 0; F < x; F++)
                            if (u = w[F], v = j(E, u.angle), !(D && v > l.maxAllowedDirectionChange)) {
                                var G = B.clone().offset(u.offsetX, u.offsetY),
                                    H = G.toString();
                                if (!r.isClose(H) && f.isPointAccessible(G)) {
                                    var I = C + u.cost + l.penalties[v];
                                    (!r.isOpen(H) || I < t[H]) && (s[H] = B, t[H] = I, r.add(H, I + k(G, n)))
                                }
                            }
                        y--
                    }
                }
                return l.fallbackRoute(o, p, l)
            }

            function m(c) {
                c.directions = b.result(c, "directions"), c.penalties = b.result(c, "penalties"), c.paddingBox = b.result(c, "paddingBox"), b.each(c.directions, function(b) {
                    var c = a.point(0, 0),
                        d = a.point(b.offsetX, b.offsetY);
                    b.angle = a.normalizeAngle(c.theta(d))
                })
            }

            function n(e, f) {
                m(f), this.options.perpendicular = !!f.perpendicular;
                for (var g = a.rect(this.sourceBBox).moveAndExpand(f.paddingBox), h = a.rect(this.targetBBox).moveAndExpand(f.paddingBox), i = new d(f).build(this.paper.model, this.model), j = b.map(e, a.point), k = [], n = g.center().snapToGrid(f.step), o = 0, p = j.length; o <= p; o++) {
                    var q = null,
                        r = s || g,
                        s = j[o];
                    if (!s) {
                        s = h;
                        var t = !this.model.get("source").id || !this.model.get("target").id;
                        if (t && b.isFunction(f.draggingRoute)) {
                            var u = r instanceof a.rect ? r.center() : r;
                            q = f.draggingRoute(u, s.origin(), f)
                        }
                    }
                    if (q = q || l(r, s, i, f), null === q) {
                        if (!b.isFunction(c.routers.orthogonal)) throw new Error("Manhattan requires the orthogonal router.");
                        return c.routers.orthogonal(e, f, this)
                    }
                    var v = b.first(q);
                    v && v.equals(n) && q.shift(), n = b.last(q) || n, Array.prototype.push.apply(k, q)
                }
                return k
            }
            var o = {
                step: 10,
                perpendicular: !0,
                excludeEnds: [],
                excludeTypes: ["basic.Text"],
                maximumLoops: 2e3,
                startDirections: ["left", "right", "top", "bottom"],
                endDirections: ["left", "right", "top", "bottom"],
                directionMap: {
                    right: {
                        x: 1,
                        y: 0
                    },
                    bottom: {
                        x: 0,
                        y: 1
                    },
                    left: {
                        x: -1,
                        y: 0
                    },
                    top: {
                        x: 0,
                        y: -1
                    }
                },
                maxAllowedDirectionChange: 90,
                paddingBox: function() {
                    var a = this.step;
                    return {
                        x: -a,
                        y: -a,
                        width: 2 * a,
                        height: 2 * a
                    }
                },
                directions: function() {
                    var a = this.step;
                    return [{
                        offsetX: a,
                        offsetY: 0,
                        cost: a
                    }, {
                        offsetX: 0,
                        offsetY: a,
                        cost: a
                    }, {
                        offsetX: -a,
                        offsetY: 0,
                        cost: a
                    }, {
                        offsetX: 0,
                        offsetY: -a,
                        cost: a
                    }]
                },
                penalties: function() {
                    return {
                        0: 0,
                        45: this.step / 2,
                        90: this.step / 2
                    }
                },
                fallbackRoute: b.constant(null),
                draggingRoute: null
            };
            return d.prototype.build = function(a, c) {
                    var d = this.options,
                        e = b.chain(d.excludeEnds).map(c.get, c).pluck("id").map(a.getCell, a).value(),
                        f = [],
                        g = a.getCell(c.get("source").id);
                    g && (f = b.union(f, b.map(g.getAncestors(), "id")));
                    var h = a.getCell(c.get("target").id);
                    h && (f = b.union(f, b.map(h.getAncestors(), "id")));
                    var i = this.mapGridSize;
                    return b.chain(a.getElements()).difference(e).reject(function(a) {
                        return b.contains(d.excludeTypes, a.get("type")) || b.contains(f, a.id)
                    }).invoke("getBBox").invoke("moveAndExpand", d.paddingBox).foldl(function(a, b) {
                        for (var c = b.origin().snapToGrid(i), d = b.corner().snapToGrid(i), e = c.x; e <= d.x; e += i)
                            for (var f = c.y; f <= d.y; f += i) {
                                var g = e + "@" + f;
                                a[g] = a[g] || [], a[g].push(b)
                            }
                        return a
                    }, this.map).value(), this
                }, d.prototype.isPointAccessible = function(a) {
                    var c = a.clone().snapToGrid(this.mapGridSize).toString();
                    return b.every(this.map[c], function(b) {
                        return !b.containsPoint(a)
                    })
                }, e.prototype.add = function(a, c) {
                    this.hash[a] ? this.items.splice(this.items.indexOf(a), 1) : this.hash[a] = this.OPEN, this.values[a] = c;
                    var d = b.sortedIndex(this.items, a, function(a) {
                        return this.values[a]
                    }, this);
                    this.items.splice(d, 0, a)
                }, e.prototype.remove = function(a) {
                    this.hash[a] = this.CLOSE
                }, e.prototype.isOpen = function(a) {
                    return this.hash[a] === this.OPEN
                }, e.prototype.isClose = function(a) {
                    return this.hash[a] === this.CLOSE
                }, e.prototype.isEmpty = function() {
                    return 0 === this.items.length
                }, e.prototype.pop = function() {
                    var a = this.items.shift();
                    return this.remove(a), a
                },
                function(a, c, d) {
                    return n.call(d, a, b.extend({}, o, c))
                }
        }(g, _, joint), joint.routers.metro = function() {
            if (!_.isFunction(joint.routers.manhattan)) throw new Error("Metro requires the manhattan router.");
            var a = {
                diagonalCost: null,
                directions: function() {
                    var a = this.step,
                        b = this.diagonalCost || Math.ceil(Math.sqrt(a * a << 1));
                    return [{
                        offsetX: a,
                        offsetY: 0,
                        cost: a
                    }, {
                        offsetX: a,
                        offsetY: a,
                        cost: b
                    }, {
                        offsetX: 0,
                        offsetY: a,
                        cost: a
                    }, {
                        offsetX: -a,
                        offsetY: a,
                        cost: b
                    }, {
                        offsetX: -a,
                        offsetY: 0,
                        cost: a
                    }, {
                        offsetX: -a,
                        offsetY: -a,
                        cost: b
                    }, {
                        offsetX: 0,
                        offsetY: -a,
                        cost: a
                    }, {
                        offsetX: a,
                        offsetY: -a,
                        cost: b
                    }]
                },
                maxAllowedDirectionChange: 45,
                fallbackRoute: function(a, b, c) {
                    var d = a.theta(b),
                        e = {
                            x: b.x,
                            y: a.y
                        },
                        f = {
                            x: a.x,
                            y: b.y
                        };
                    if (d % 180 > 90) {
                        var h = e;
                        e = f, f = h
                    }
                    var i = d % 90 < 45 ? e : f,
                        j = g.line(a, i),
                        k = 90 * Math.ceil(d / 90),
                        l = g.point.fromPolar(j.squaredLength(), g.toRad(k + 135), i),
                        m = g.line(b, l),
                        n = j.intersection(m);
                    return n ? [n.round(), b] : [b]
                }
            };
            return function(b, c, d) {
                return joint.routers.manhattan(b, _.extend({}, a, c), d)
            }
        }(), joint.routers.normal = function(a, b, c) {
            return a
        }, joint.routers.oneSide = function(a, b, c) {
            var d, e, f, g = b.side || "bottom",
                h = b.padding || 40,
                i = c.sourceBBox,
                j = c.targetBBox,
                k = i.center(),
                l = j.center();
            switch (g) {
                case "bottom":
                    f = 1, d = "y", e = "height";
                    break;
                case "top":
                    f = -1, d = "y", e = "height";
                    break;
                case "left":
                    f = -1, d = "x", e = "width";
                    break;
                case "right":
                    f = 1, d = "x", e = "width";
                    break;
                default:
                    throw new Error("Router: invalid side")
            }
            return k[d] += f * (i[e] / 2 + h), l[d] += f * (j[e] / 2 + h), f * (k[d] - l[d]) > 0 ? l[d] = k[d] : k[d] = l[d], [k].concat(a, l)
        }, joint.routers.orthogonal = function() {
            function a(a, b) {
                return a.x == b.x ? a.y > b.y ? "N" : "S" : a.y == b.y ? a.x > b.x ? "W" : "E" : null
            }

            function b(a, b) {
                return a["W" == b || "E" == b ? "width" : "height"]
            }

            function c(a, b) {
                return g.rect(a).moveAndExpand({
                    x: -b,
                    y: -b,
                    width: 2 * b,
                    height: 2 * b
                })
            }

            function d(a) {
                return g.rect(a.x, a.y, 0, 0)
            }

            function e(a, b) {
                var c = Math.min(a.x, b.x),
                    d = Math.min(a.y, b.y),
                    e = Math.max(a.x + a.width, b.x + b.width),
                    f = Math.max(a.y + a.height, b.y + b.height);
                return g.rect(c, d, e - c, f - d)
            }

            function f(a, b, c) {
                var d = g.point(a.x, b.y);
                return c.containsPoint(d) && (d = g.point(b.x, a.y)), d
            }

            function h(b, c, d) {
                var e = g.point(b.x, c.y),
                    f = g.point(c.x, b.y),
                    h = a(b, e),
                    i = a(b, f),
                    j = n[d],
                    k = h == d || h != j && (i == j || i != d) ? e : f;
                return {
                    points: [k],
                    direction: a(k, c)
                }
            }

            function i(b, c, d) {
                var e = f(b, c, d);
                return {
                    points: [e],
                    direction: a(e, c)
                }
            }

            function j(c, d, e, h) {
                var i, j = {},
                    k = [g.point(c.x, d.y), g.point(d.x, c.y)],
                    l = _.filter(k, function(a) {
                        return !e.containsPoint(a)
                    }),
                    m = _.filter(l, function(b) {
                        return a(b, c) != h
                    });
                if (m.length > 0) i = _.filter(m, function(b) {
                    return a(c, b) == h
                }).pop(), i = i || m[0], j.points = [i], j.direction = a(i, d);
                else {
                    i = _.difference(k, l)[0];
                    var n = g.point(d).move(i, -b(e, h) / 2),
                        o = f(n, c, e);
                    j.points = [o, n], j.direction = a(n, d)
                }
                return j
            }

            function k(c, d, e, f) {
                var j = i(d, c, f),
                    k = j.points[0];
                if (e.containsPoint(k)) {
                    j = i(c, d, e);
                    var l = j.points[0];
                    if (f.containsPoint(l)) {
                        var m = g.point(c).move(l, -b(e, a(c, l)) / 2),
                            n = g.point(d).move(k, -b(f, a(d, k)) / 2),
                            o = g.line(m, n).midpoint(),
                            p = i(c, o, e),
                            q = h(o, d, p.direction);
                        j.points = [p.points[0], q.points[0]], j.direction = q.direction
                    }
                }
                return j
            }

            function l(b, d, h, i, j) {
                var k, l, m, n = {},
                    p = c(e(h, i), 1),
                    q = p.center().distance(d) > p.center().distance(b),
                    r = q ? d : b,
                    s = q ? b : d;
                return j ? (k = g.point.fromPolar(p.width + p.height, o[j], r), k = p.pointNearestToPoint(k).move(k, -1)) : k = p.pointNearestToPoint(r).move(r, 1), l = f(k, s, p), k.round().equals(l.round()) ? (l = g.point.fromPolar(p.width + p.height, g.toRad(k.theta(r)) + Math.PI / 2, s), l = p.pointNearestToPoint(l).move(s, 1).round(), m = f(k, l, p), n.points = q ? [l, m, k] : [k, m, l]) : n.points = q ? [l, k] : [k, l], n.direction = q ? a(k, d) : a(l, d), n
            }

            function m(b, e, f) {
                var m = e.elementPadding || 20,
                    n = [],
                    o = c(f.sourceBBox, m),
                    p = c(f.targetBBox, m);
                b = _.map(b, g.point), b.unshift(o.center()), b.push(p.center());
                for (var q, r = 0, s = b.length - 1; r < s; r++) {
                    var t = null,
                        u = b[r],
                        v = b[r + 1],
                        w = !!a(u, v);
                    if (0 == r) r + 1 == s ? o.intersect(c(p, 1)) ? t = l(u, v, o, p) : w || (t = k(u, v, o, p)) : o.containsPoint(v) ? t = l(u, v, o, c(d(v), m)) : w || (t = i(u, v, o));
                    else if (r + 1 == s) {
                        var x = w && a(v, u) == q;
                        p.containsPoint(u) || x ? t = l(u, v, c(d(u), m), p, q) : w || (t = j(u, v, p, q))
                    } else w || (t = h(u, v, q));
                    t ? (Array.prototype.push.apply(n, t.points), q = t.direction) : q = a(u, v), r + 1 < s && n.push(v)
                }
                return n
            }
            var n = {
                    N: "S",
                    S: "N",
                    E: "W",
                    W: "E"
                },
                o = {
                    N: -Math.PI / 2 * 3,
                    S: -Math.PI / 2,
                    E: 0,
                    W: Math.PI
                };
            return m
        }(), joint.connectors.normal = function(a, b, c) {
            var d = ["M", a.x, a.y];
            return _.each(c, function(a) {
                d.push(a.x, a.y)
            }), d.push(b.x, b.y), d.join(" ")
        }, joint.connectors.rounded = function(a, b, c, d) {
            d = d || {};
            var e, f, h, i, j, k, l = d.radius || 10,
                m = ["M", a.x, a.y];
            return _.each(c, function(d, n) {
                j = c[n - 1] || a, k = c[n + 1] || b, h = i || g.point(d).distance(j) / 2, i = g.point(d).distance(k) / 2, e = g.point(d).move(j, -Math.min(l, h)).round(), f = g.point(d).move(k, -Math.min(l, i)).round(), m.push(e.x, e.y, "S", d.x, d.y, f.x, f.y, "L")
            }), m.push(b.x, b.y), m.join(" ")
        }, joint.connectors.smooth = function(a, b, c) {
            var d;
            if (c.length) d = g.bezier.curveThroughPoints([a].concat(c).concat([b]));
            else {
                var e = (a.x + b.x) / 2;
                d = ["M", a.x, a.y, "C", e, a.y, e, b.y, b.x, b.y]
            }
            return d.join(" ")
        }, joint.connectors.jumpover = function(a, b) {
            function c(a, c, d) {
                var e = [].concat(a, d, c);
                return e.reduce(function(a, c, d) {
                    var f = e[d + 1];
                    return null != f && (a[d] = b.line(c, f)), a
                }, [])
            }

            function d(a) {
                var b = a.paper._jumpOverUpdateList;
                null == b && (b = a.paper._jumpOverUpdateList = [], a.paper.on("cell:pointerup", e), a.paper.model.on("reset", function() {
                    b = []
                })), b.indexOf(a) < 0 && (b.push(a), a.listenToOnce(a.model, "change:connector remove", function() {
                    b.splice(b.indexOf(a), 1)
                }))
            }

            function e() {
                for (var a = this._jumpOverUpdateList, b = 0; b < a.length; b++) a[b].update()
            }

            function f(b, c) {
                return a(c).map(function(a) {
                    return b.intersection(a)
                }).compact().value()
            }

            function g(a, c) {
                return b.line(a, c).squaredLength()
            }

            function h(a, c, d) {
                return c.reduce(function(e, f, g) {
                    if (f.skip === !0) return e;
                    var h = e.pop() || a,
                        i = b.point(f).move(h.start, -d),
                        j = b.point(f).move(h.start, +d),
                        k = c[g + 1];
                    if (null != k) {
                        var m = j.distance(k);
                        m <= d && (j = k.move(h.start, m), k.skip = !0)
                    } else {
                        var n = i.distance(h.end);
                        if (n < 2 * d + l) return e.push(h), e
                    }
                    var o = j.distance(h.start);
                    if (o < 2 * d + l) return e.push(h), e;
                    var p = b.line(i, j);
                    return p.isJump = !0, e.push(b.line(h.start, i), p, b.line(j, h.end)), e
                }, [])
            }

            function i(c, d, e) {
                var f = ["M", c[0].start.x, c[0].start.y],
                    g = a(c).map(function(a) {
                        if (a.isJump) {
                            var c;
                            if ("arc" === e) {
                                c = a.start.difference(a.end);
                                var f = Number(c.x < 0 && c.y < 0);
                                return ["A", d, d, 0, 0, f, a.end.x, a.end.y]
                            }
                            if ("gap" === e) return ["M", a.end.x, a.end.y];
                            if ("cubic" === e) {
                                c = a.start.difference(a.end);
                                var g = a.start.theta(a.end),
                                    h = .6 * d,
                                    i = 1.35 * d;
                                c.x < 0 && c.y < 0 && (i *= -1);
                                var j = b.point(a.start.x + h, a.start.y + i).rotate(a.start, g),
                                    k = b.point(a.end.x - h, a.end.y + i).rotate(a.end, g);
                                return ["C", j.x, j.y, k.x, k.y, a.end.x, a.end.y]
                            }
                        }
                        return ["L", a.end.x, a.end.y]
                    }).flatten().value();
                return [].concat(f, g).join(" ")
            }
            var j = 5,
                k = ["arc", "gap", "cubic"],
                l = 1,
                m = ["smooth"];
            return function(b, e, l, n) {
                d(this);
                var o = n.size || j,
                    p = n.jump && ("" + n.jump).toLowerCase(),
                    q = n.ignoreConnectors || m;
                k.indexOf(p) === -1 && (p = k[0]);
                var r = this.paper,
                    s = r.model,
                    t = s.getLinks();
                if (1 === t.length) return i(c(b, e, l), o, p);
                var u = this.model,
                    v = t.indexOf(u),
                    w = r.options.defaultConnector || {},
                    x = t.filter(function(b, c) {
                        var d = b.get("connector") || w;
                        return !a.contains(q, d.name) && (!(c > v) || "jumpover" !== d.name)
                    }),
                    y = x.map(function(a) {
                        return r.findViewByModel(a)
                    }),
                    z = c(b, e, l),
                    A = y.map(function(a) {
                        return null == a ? [] : a === this ? z : c(a.sourcePoint, a.targetPoint, a.route)
                    }, this),
                    B = z.reduce(function(b, c) {
                        var d = a(x).map(function(a, b) {
                            return a === u ? null : f(c, A[b])
                        }).flatten().compact().sortBy(a.partial(g, c.start)).value();
                        return d.length > 0 ? b.push.apply(b, h(c, d, o)) : b.push(c), b
                    }, []);
                return i(B, o, p)
            }
        }(_, g),
        function(a, b, c) {
            function d(b, c, d) {
                var e = b.toJSON();
                return e.angle = c || 0, a.defaults({}, d, e)
            }

            function e(c, e, f) {
                return a.map(c, function(a, b, c) {
                    var e = this.pointAt((b + .5) / c.length);
                    return (a.dx || a.dy) && e.offset(a.dx || 0, a.dy || 0), d(e.round(), 0, a)
                }, b.line(e, f))
            }

            function f(c, e, f, g) {
                var h = e.center(),
                    i = e.width / e.height,
                    j = e.topMiddle(),
                    k = b.Ellipse.fromRect(e);
                return a.map(c, function(a, b, c) {
                    var e = f + g(b, c.length),
                        l = j.clone().rotate(h, -e).scale(i, 1, h),
                        m = a.compensateRotation ? -k.tangentTheta(l) : 0;
                    return (a.dx || a.dy) && l.offset(a.dx || 0, a.dy || 0), a.dr && l.move(h, a.dr), d(l.round(), m, a)
                })
            }

            function g(c, d) {
                var e = d.x;
                a.isString(e) && (e = parseFloat(e) / 100 * c.width);
                var f = d.y;
                return a.isString(f) && (f = parseFloat(f) / 100 * c.height), b.point(e || 0, f || 0)
            }
            c.layout.Port = {
                absolute: function(b, c, d) {
                    return a.map(b, a.partial(g, c))
                },
                fn: function(a, b, c) {
                    return c.fn(a, b, c)
                },
                line: function(a, b, c) {
                    var d = g(b, c.start || b.origin()),
                        f = g(b, c.end || b.corner());
                    return e(a, d, f)
                },
                left: function(a, b, c) {
                    return e(a, b.origin(), b.bottomLeft())
                },
                right: function(a, b, c) {
                    return e(a, b.topRight(), b.corner())
                },
                top: function(a, b, c) {
                    return e(a, b.origin(), b.topRight())
                },
                bottom: function(a, b, c) {
                    return e(a, b.bottomLeft(), b.corner())
                },
                ellipseSpread: function(a, b, c) {
                    var d = c.startAngle || 0,
                        e = c.step || 360 / a.length;
                    return f(a, b, d, function(a) {
                        return a * e
                    })
                },
                ellipse: function(a, b, c) {
                    var d = c.startAngle || 0,
                        e = c.step || 20;
                    return f(a, b, d, function(a, b) {
                        return (a + .5 - b / 2) * e
                    })
                }
            }
        }(_, g, joint),
        function(a, b, c) {
            function d(b, c) {
                return a.defaultsDeep({}, b, c, {
                    x: 0,
                    y: 0,
                    angle: 0,
                    attrs: {
                        ".": {
                            y: "0",
                            "text-anchor": "start"
                        }
                    }
                })
            }

            function e(b, c, e, g) {
                g = a.defaults({}, g, {
                    offset: 15
                });
                var h, i, j, k, l = c.center().theta(b),
                    m = f(c),
                    n = g.offset,
                    o = 0;
                l < m[1] || l > m[2] ? (j = ".3em", h = n, i = 0, k = "start") : l < m[0] ? (j = "0", h = 0, i = -n, e ? (o = -90, k = "start") : k = "middle") : l < m[3] ? (j = ".3em", h = -n, i = 0, k = "end") : (j = ".6em", h = 0, i = n, e ? (o = 90, k = "start") : k = "middle");
                var p = Math.round;
                return d({
                    x: p(h),
                    y: p(i),
                    angle: o,
                    attrs: {
                        ".": {
                            y: j,
                            "text-anchor": k
                        }
                    }
                })
            }

            function f(a) {
                var b = a.center(),
                    c = b.theta(a.origin()),
                    d = b.theta(a.bottomLeft()),
                    e = b.theta(a.corner()),
                    f = b.theta(a.topRight());
                return [c, f, e, d]
            }

            function g(b, c, e, g) {
                var h = c.center().theta(b);
                g = a.defaults({}, g, {
                    offset: 15
                });
                var i, j, k, l, m = g.offset,
                    n = 0,
                    o = f(c);
                h < o[1] || h > o[2] ? (k = ".3em", i = -m, j = 0, l = "end") : h < o[0] ? (k = ".6em", i = 0, j = m, e ? (n = 90, l = "start") : l = "middle") : h < o[3] ? (k = ".3em", i = m, j = 0, l = "start") : (k = "0em", i = 0, j = -m, e ? (n = -90, l = "start") : l = "middle");
                var p = Math.round;
                return d({
                    x: p(i),
                    y: p(j),
                    angle: n,
                    attrs: {
                        ".": {
                            y: k,
                            "text-anchor": l
                        }
                    }
                })
            }

            function h(c, e, f) {
                f = a.defaults({}, f, {
                    offset: 20
                });
                var g, h = b.point(0, 0),
                    i = -c.theta(h),
                    j = i,
                    k = c.clone().move(h, f.offset).difference(c).round(),
                    l = ".3em";
                (i + 90) % 180 === 0 ? (g = e ? "end" : "middle", e || i !== -270 || (l = "0em")) : i > -270 && i < -90 ? (g = "start", j = i - 180) : g = "end";
                var m = Math.round;
                return d({
                    x: m(k.x),
                    y: m(k.y),
                    angle: e ? j : 0,
                    attrs: {
                        ".": {
                            y: l,
                            "text-anchor": g
                        }
                    }
                })
            }
            c.layout.PortLabel = {
                manual: a.rearg(d, 2),
                left: function(a, b, c) {
                    return d(c, {
                        x: -15,
                        attrs: {
                            ".": {
                                y: ".3em",
                                "text-anchor": "end"
                            }
                        }
                    })
                },
                right: function(a, b, c) {
                    return d(c, {
                        x: 15,
                        attrs: {
                            ".": {
                                y: ".3em",
                                "text-anchor": "start"
                            }
                        }
                    })
                },
                top: function(a, b, c) {
                    return d(c, {
                        y: -15,
                        attrs: {
                            ".": {
                                "text-anchor": "middle"
                            }
                        }
                    })
                },
                bottom: function(a, b, c) {
                    return d(c, {
                        y: 15,
                        attrs: {
                            ".": {
                                y: ".6em",
                                "text-anchor": "middle"
                            }
                        }
                    })
                },
                outsideOriented: function(a, b, c) {
                    return e(a, b, !0, c)
                },
                outside: function(a, b, c) {
                    return e(a, b, !1, c)
                },
                insideOriented: function(a, b, c) {
                    return g(a, b, !0, c)
                },
                inside: function(a, b, c) {
                    return g(a, b, !1, c)
                },
                radial: function(a, b, c) {
                    return h(a.difference(b.center()), !1, c)
                },
                radialOriented: function(a, b, c) {
                    return h(a.difference(b.center()), !0, c)
                }
            }
        }(_, g, joint), joint.highlighters.addClass = {
            className: joint.util.addClassNamePrefix("highlighted"),
            highlight: function(a, b, c) {
                var d = c || {},
                    e = d.className || this.className;
                V(b).addClass(e)
            },
            unhighlight: function(a, b, c) {
                var d = c || {},
                    e = d.className || this.className;
                V(b).removeClass(e)
            }
        }, joint.highlighters.opacity = {
            highlight: function(a, b) {
                V(b).addClass(joint.util.addClassNamePrefix("highlight-opacity"))
            },
            unhighlight: function(a, b) {
                V(b).removeClass(joint.util.addClassNamePrefix("highlight-opacity"))
            }
        }, joint.highlighters.stroke = {
            defaultOptions: {
                padding: 3,
                rx: 0,
                ry: 0,
                attrs: {
                    "stroke-width": 3,
                    stroke: "#FEB663"
                }
            },
            _views: {},
            highlight: function(a, b, c) {
                if (!this._views[b.id]) {
                    var d = _.defaults(c || {}, this.defaultOptions),
                        e = V(b),
                        f = e.bbox(!0);
                    try {
                        var g = e.convertToPathData()
                    } catch (a) {
                        g = V.rectToPath(_.extend({}, d, f))
                    }
                    var h = V("path").attr({
                        d: g,
                        "pointer-events": "none",
                        "vector-effect": "non-scaling-stroke",
                        fill: "none"
                    }).attr(d.attrs);
                    h.transform(a.el.getCTM().inverse()), h.transform(b.getCTM());
                    var i = d.padding;
                    if (i) {
                        var j = f.x + f.width / 2,
                            k = f.y + f.height / 2,
                            l = (f.width + i) / f.width,
                            m = (f.height + i) / f.height;
                        h.transform({
                            a: l,
                            b: 0,
                            c: 0,
                            d: m,
                            e: j - l * j,
                            f: k - m * k
                        })
                    }
                    var n = this._views[b.id] = new joint.mvc.View({
                        className: "highlight-stroke",
                        el: h.node,
                        $el: h
                    });
                    n.listenTo(a.model, "remove", n.remove), a.vel.append(h)
                }
            },
            unhighlight: function(a, b, c) {
                this._views[b.id] && (this._views[b.id].remove(), this._views[b.id] = null)
            }
        };
    joint.shapes.erd = {}, joint.shapes.erd.Entity = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><polygon class="outer"/><polygon class="inner"/></g><text/></g>',
        defaults: _.defaultsDeep({
            type: "erd.Entity",
            size: {
                width: 150,
                height: 60
            },
            attrs: {
                ".outer": {
                    fill: "#2ECC71",
                    stroke: "#27AE60",
                    "stroke-width": 2,
                    points: "100,0 100,60 0,60 0,0"
                },
                ".inner": {
                    fill: "#2ECC71",
                    stroke: "#27AE60",
                    "stroke-width": 2,
                    points: "95,5 95,55 5,55 5,5",
                    display: "none"
                },
                text: {
                    text: "Entity",
                    "font-family": "Arial",
                    "font-size": 14,
                    "ref-x": .5,
                    "ref-y": .5,
                    "y-alignment": "middle",
                    "text-anchor": "middle"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.erd.WeakEntity = joint.shapes.erd.Entity.extend({
        defaults: _.defaultsDeep({
            type: "erd.WeakEntity",
            attrs: {
                ".inner": {
                    display: "auto"
                },
                text: {
                    text: "Weak Entity"
                }
            }
        }, joint.shapes.erd.Entity.prototype.defaults)
    }), joint.shapes.erd.Relationship = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><polygon class="outer"/><polygon class="inner"/></g><text/></g>',
        defaults: _.defaultsDeep({
            type: "erd.Relationship",
            size: {
                width: 80,
                height: 80
            },
            attrs: {
                ".outer": {
                    fill: "#3498DB",
                    stroke: "#2980B9",
                    "stroke-width": 2,
                    points: "40,0 80,40 40,80 0,40"
                },
                ".inner": {
                    fill: "#3498DB",
                    stroke: "#2980B9",
                    "stroke-width": 2,
                    points: "40,5 75,40 40,75 5,40",
                    display: "none"
                },
                text: {
                    text: "Relationship",
                    "font-family": "Arial",
                    "font-size": 12,
                    "ref-x": .5,
                    "ref-y": .5,
                    "y-alignment": "middle",
                    "text-anchor": "middle"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.erd.IdentifyingRelationship = joint.shapes.erd.Relationship.extend({
        defaults: _.defaultsDeep({
            type: "erd.IdentifyingRelationship",
            attrs: {
                ".inner": {
                    display: "auto"
                },
                text: {
                    text: "Identifying"
                }
            }
        }, joint.shapes.erd.Relationship.prototype.defaults)
    }), joint.shapes.erd.Attribute = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><ellipse class="outer"/><ellipse class="inner"/></g><text/></g>',
        defaults: _.defaultsDeep({
            type: "erd.Attribute",
            size: {
                width: 100,
                height: 50
            },
            attrs: {
                ellipse: {
                    transform: "translate(50, 25)"
                },
                ".outer": {
                    stroke: "#D35400",
                    "stroke-width": 2,
                    cx: 0,
                    cy: 0,
                    rx: 50,
                    ry: 25,
                    fill: "#E67E22"
                },
                ".inner": {
                    stroke: "#D35400",
                    "stroke-width": 2,
                    cx: 0,
                    cy: 0,
                    rx: 45,
                    ry: 20,
                    fill: "#E67E22",
                    display: "none"
                },
                text: {
                    "font-family": "Arial",
                    "font-size": 14,
                    "ref-x": .5,
                    "ref-y": .5,
                    "y-alignment": "middle",
                    "text-anchor": "middle"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.erd.Multivalued = joint.shapes.erd.Attribute.extend({
        defaults: _.defaultsDeep({
            type: "erd.Multivalued",
            attrs: {
                ".inner": {
                    display: "block"
                },
                text: {
                    text: "multivalued"
                }
            }
        }, joint.shapes.erd.Attribute.prototype.defaults)
    }), joint.shapes.erd.Derived = joint.shapes.erd.Attribute.extend({
        defaults: _.defaultsDeep({
            type: "erd.Derived",
            attrs: {
                ".outer": {
                    "stroke-dasharray": "3,5"
                },
                text: {
                    text: "derived"
                }
            }
        }, joint.shapes.erd.Attribute.prototype.defaults)
    }), joint.shapes.erd.Key = joint.shapes.erd.Attribute.extend({
        defaults: _.defaultsDeep({
            type: "erd.Key",
            attrs: {
                ellipse: {
                    "stroke-width": 4
                },
                text: {
                    text: "key",
                    "font-weight": "800",
                    "text-decoration": "underline"
                }
            }
        }, joint.shapes.erd.Attribute.prototype.defaults)
    }), joint.shapes.erd.Normal = joint.shapes.erd.Attribute.extend({
        defaults: _.defaultsDeep({
            type: "erd.Normal",
            attrs: {
                text: {
                    text: "Normal"
                }
            }
        }, joint.shapes.erd.Attribute.prototype.defaults)
    }), joint.shapes.erd.ISA = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><polygon/></g><text/></g>',
        defaults: _.defaultsDeep({
            type: "erd.ISA",
            size: {
                width: 100,
                height: 50
            },
            attrs: {
                polygon: {
                    points: "0,0 50,50 100,0",
                    fill: "#F1C40F",
                    stroke: "#F39C12",
                    "stroke-width": 2
                },
                text: {
                    text: "ISA",
                    "font-size": 18,
                    "ref-x": .5,
                    "ref-y": .3,
                    "y-alignment": "middle",
                    "text-anchor": "middle"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.erd.Line = joint.dia.Link.extend({
        defaults: {
            type: "erd.Line"
        },
        cardinality: function(a) {
            this.set("labels", [{
                position: -20,
                attrs: {
                    text: {
                        dy: -8,
                        text: a
                    }
                }
            }])
        }
    });
    joint.shapes.fsa = {}, joint.shapes.fsa.State = joint.shapes.basic.Circle.extend({
        defaults: _.defaultsDeep({
            type: "fsa.State",
            attrs: {
                circle: {
                    "stroke-width": 3
                },
                text: {
                    "font-weight": "800"
                }
            }
        }, joint.shapes.basic.Circle.prototype.defaults)
    }), joint.shapes.fsa.StartState = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><circle/></g></g>',
        defaults: _.defaultsDeep({
            type: "fsa.StartState",
            size: {
                width: 20,
                height: 20
            },
            attrs: {
                circle: {
                    transform: "translate(10, 10)",
                    r: 10,
                    fill: "#000000"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.fsa.EndState = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><circle class="outer"/><circle class="inner"/></g></g>',
        defaults: _.defaultsDeep({
            type: "fsa.EndState",
            size: {
                width: 20,
                height: 20
            },
            attrs: {
                ".outer": {
                    transform: "translate(10, 10)",
                    r: 10,
                    fill: "#ffffff",
                    stroke: "#000000"
                },
                ".inner": {
                    transform: "translate(10, 10)",
                    r: 6,
                    fill: "#000000"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.fsa.Arrow = joint.dia.Link.extend({
        defaults: _.defaultsDeep({
            type: "fsa.Arrow",
            attrs: {
                ".marker-target": {
                    d: "M 10 0 L 0 5 L 10 10 z"
                }
            },
            smooth: !0
        }, joint.dia.Link.prototype.defaults)
    });
    joint.shapes.org = {}, joint.shapes.org.Member = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><rect class="card"/><image/></g><text class="rank"/><text class="name"/></g>',
        defaults: _.defaultsDeep({
            type: "org.Member",
            size: {
                width: 180,
                height: 70
            },
            attrs: {
                rect: {
                    width: 170,
                    height: 60
                },
                ".card": {
                    fill: "#FFFFFF",
                    stroke: "#000000",
                    "stroke-width": 2,
                    "pointer-events": "visiblePainted",
                    rx: 10,
                    ry: 10
                },
                image: {
                    width: 48,
                    height: 48,
                    ref: ".card",
                    "ref-x": 10,
                    "ref-y": 5
                },
                ".rank": {
                    "text-decoration": "underline",
                    ref: ".card",
                    "ref-x": .9,
                    "ref-y": .2,
                    "font-family": "Courier New",
                    "font-size": 14,
                    "text-anchor": "end"
                },
                ".name": {
                    "font-weight": "800",
                    ref: ".card",
                    "ref-x": .9,
                    "ref-y": .6,
                    "font-family": "Courier New",
                    "font-size": 14,
                    "text-anchor": "end"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.org.Arrow = joint.dia.Link.extend({
        defaults: {
            type: "org.Arrow",
            source: {
                selector: ".card"
            },
            target: {
                selector: ".card"
            },
            attrs: {
                ".connection": {
                    stroke: "#585858",
                    "stroke-width": 3
                }
            },
            z: -1
        }
    });
    joint.shapes.chess = {}, joint.shapes.chess.KingWhite = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="fill:none; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;"><path      d="M 22.5,11.63 L 22.5,6"      style="fill:none; stroke:#000000; stroke-linejoin:miter;" />    <path      d="M 20,8 L 25,8"      style="fill:none; stroke:#000000; stroke-linejoin:miter;" />    <path      d="M 22.5,25 C 22.5,25 27,17.5 25.5,14.5 C 25.5,14.5 24.5,12 22.5,12 C 20.5,12 19.5,14.5 19.5,14.5 C 18,17.5 22.5,25 22.5,25"      style="fill:#ffffff; stroke:#000000; stroke-linecap:butt; stroke-linejoin:miter;" />    <path      d="M 11.5,37 C 17,40.5 27,40.5 32.5,37 L 32.5,30 C 32.5,30 41.5,25.5 38.5,19.5 C 34.5,13 25,16 22.5,23.5 L 22.5,27 L 22.5,23.5 C 19,16 9.5,13 6.5,19.5 C 3.5,25.5 11.5,29.5 11.5,29.5 L 11.5,37 z "      style="fill:#ffffff; stroke:#000000;" />    <path      d="M 11.5,30 C 17,27 27,27 32.5,30"      style="fill:none; stroke:#000000;" />    <path      d="M 11.5,33.5 C 17,30.5 27,30.5 32.5,33.5"      style="fill:none; stroke:#000000;" />    <path      d="M 11.5,37 C 17,34 27,34 32.5,37"      style="fill:none; stroke:#000000;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.KingWhite",
            size: {
                width: 42,
                height: 38
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.KingBlack = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="fill:none; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <path       d="M 22.5,11.63 L 22.5,6"       style="fill:none; stroke:#000000; stroke-linejoin:miter;"       id="path6570" />    <path       d="M 22.5,25 C 22.5,25 27,17.5 25.5,14.5 C 25.5,14.5 24.5,12 22.5,12 C 20.5,12 19.5,14.5 19.5,14.5 C 18,17.5 22.5,25 22.5,25"       style="fill:#000000;fill-opacity:1; stroke-linecap:butt; stroke-linejoin:miter;" />    <path       d="M 11.5,37 C 17,40.5 27,40.5 32.5,37 L 32.5,30 C 32.5,30 41.5,25.5 38.5,19.5 C 34.5,13 25,16 22.5,23.5 L 22.5,27 L 22.5,23.5 C 19,16 9.5,13 6.5,19.5 C 3.5,25.5 11.5,29.5 11.5,29.5 L 11.5,37 z "       style="fill:#000000; stroke:#000000;" />    <path       d="M 20,8 L 25,8"       style="fill:none; stroke:#000000; stroke-linejoin:miter;" />    <path       d="M 32,29.5 C 32,29.5 40.5,25.5 38.03,19.85 C 34.15,14 25,18 22.5,24.5 L 22.51,26.6 L 22.5,24.5 C 20,18 9.906,14 6.997,19.85 C 4.5,25.5 11.85,28.85 11.85,28.85"       style="fill:none; stroke:#ffffff;" />    <path       d="M 11.5,30 C 17,27 27,27 32.5,30 M 11.5,33.5 C 17,30.5 27,30.5 32.5,33.5 M 11.5,37 C 17,34 27,34 32.5,37"       style="fill:none; stroke:#ffffff;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.KingBlack",
            size: {
                width: 42,
                height: 38
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.QueenWhite = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="opacity:1; fill:#ffffff; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <path      d="M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z"      transform="translate(-1,-1)" />    <path      d="M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z"      transform="translate(15.5,-5.5)" />    <path      d="M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z"      transform="translate(32,-1)" />    <path      d="M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z"      transform="translate(7,-4.5)" />    <path      d="M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z"      transform="translate(24,-4)" />    <path      d="M 9,26 C 17.5,24.5 30,24.5 36,26 L 38,14 L 31,25 L 31,11 L 25.5,24.5 L 22.5,9.5 L 19.5,24.5 L 14,10.5 L 14,25 L 7,14 L 9,26 z "      style="stroke-linecap:butt;" />    <path      d="M 9,26 C 9,28 10.5,28 11.5,30 C 12.5,31.5 12.5,31 12,33.5 C 10.5,34.5 10.5,36 10.5,36 C 9,37.5 11,38.5 11,38.5 C 17.5,39.5 27.5,39.5 34,38.5 C 34,38.5 35.5,37.5 34,36 C 34,36 34.5,34.5 33,33.5 C 32.5,31 32.5,31.5 33.5,30 C 34.5,28 36,28 36,26 C 27.5,24.5 17.5,24.5 9,26 z "      style="stroke-linecap:butt;" />    <path      d="M 11.5,30 C 15,29 30,29 33.5,30"      style="fill:none;" />    <path      d="M 12,33.5 C 18,32.5 27,32.5 33,33.5"      style="fill:none;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.QueenWhite",
            size: {
                width: 42,
                height: 38
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.QueenBlack = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="opacity:1; fill:#000000; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <g style="fill:#000000; stroke:none;">      <circle cx="6"    cy="12" r="2.75" />      <circle cx="14"   cy="9"  r="2.75" />      <circle cx="22.5" cy="8"  r="2.75" />      <circle cx="31"   cy="9"  r="2.75" />      <circle cx="39"   cy="12" r="2.75" />    </g>    <path       d="M 9,26 C 17.5,24.5 30,24.5 36,26 L 38.5,13.5 L 31,25 L 30.7,10.9 L 25.5,24.5 L 22.5,10 L 19.5,24.5 L 14.3,10.9 L 14,25 L 6.5,13.5 L 9,26 z"       style="stroke-linecap:butt; stroke:#000000;" />    <path       d="M 9,26 C 9,28 10.5,28 11.5,30 C 12.5,31.5 12.5,31 12,33.5 C 10.5,34.5 10.5,36 10.5,36 C 9,37.5 11,38.5 11,38.5 C 17.5,39.5 27.5,39.5 34,38.5 C 34,38.5 35.5,37.5 34,36 C 34,36 34.5,34.5 33,33.5 C 32.5,31 32.5,31.5 33.5,30 C 34.5,28 36,28 36,26 C 27.5,24.5 17.5,24.5 9,26 z"       style="stroke-linecap:butt;" />    <path       d="M 11,38.5 A 35,35 1 0 0 34,38.5"       style="fill:none; stroke:#000000; stroke-linecap:butt;" />    <path       d="M 11,29 A 35,35 1 0 1 34,29"       style="fill:none; stroke:#ffffff;" />    <path       d="M 12.5,31.5 L 32.5,31.5"       style="fill:none; stroke:#ffffff;" />    <path       d="M 11.5,34.5 A 35,35 1 0 0 33.5,34.5"       style="fill:none; stroke:#ffffff;" />    <path       d="M 10.5,37.5 A 35,35 1 0 0 34.5,37.5"       style="fill:none; stroke:#ffffff;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.QueenBlack",
            size: {
                width: 42,
                height: 38
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.RookWhite = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="opacity:1; fill:#ffffff; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <path      d="M 9,39 L 36,39 L 36,36 L 9,36 L 9,39 z "      style="stroke-linecap:butt;" />    <path      d="M 12,36 L 12,32 L 33,32 L 33,36 L 12,36 z "      style="stroke-linecap:butt;" />    <path      d="M 11,14 L 11,9 L 15,9 L 15,11 L 20,11 L 20,9 L 25,9 L 25,11 L 30,11 L 30,9 L 34,9 L 34,14"      style="stroke-linecap:butt;" />    <path      d="M 34,14 L 31,17 L 14,17 L 11,14" />    <path      d="M 31,17 L 31,29.5 L 14,29.5 L 14,17"      style="stroke-linecap:butt; stroke-linejoin:miter;" />    <path      d="M 31,29.5 L 32.5,32 L 12.5,32 L 14,29.5" />    <path      d="M 11,14 L 34,14"      style="fill:none; stroke:#000000; stroke-linejoin:miter;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.RookWhite",
            size: {
                width: 32,
                height: 34
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.RookBlack = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="opacity:1; fill:#000000; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <path      d="M 9,39 L 36,39 L 36,36 L 9,36 L 9,39 z "      style="stroke-linecap:butt;" />    <path      d="M 12.5,32 L 14,29.5 L 31,29.5 L 32.5,32 L 12.5,32 z "      style="stroke-linecap:butt;" />    <path      d="M 12,36 L 12,32 L 33,32 L 33,36 L 12,36 z "      style="stroke-linecap:butt;" />    <path      d="M 14,29.5 L 14,16.5 L 31,16.5 L 31,29.5 L 14,29.5 z "      style="stroke-linecap:butt;stroke-linejoin:miter;" />    <path      d="M 14,16.5 L 11,14 L 34,14 L 31,16.5 L 14,16.5 z "      style="stroke-linecap:butt;" />    <path      d="M 11,14 L 11,9 L 15,9 L 15,11 L 20,11 L 20,9 L 25,9 L 25,11 L 30,11 L 30,9 L 34,9 L 34,14 L 11,14 z "      style="stroke-linecap:butt;" />    <path      d="M 12,35.5 L 33,35.5 L 33,35.5"      style="fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;" />    <path      d="M 13,31.5 L 32,31.5"      style="fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;" />    <path      d="M 14,29.5 L 31,29.5"      style="fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;" />    <path      d="M 14,16.5 L 31,16.5"      style="fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;" />    <path      d="M 11,14 L 34,14"      style="fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.RookBlack",
            size: {
                width: 32,
                height: 34
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.BishopWhite = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="opacity:1; fill:none; fill-rule:evenodd; fill-opacity:1; stroke:#000000; stroke-width:1.5; stroke-linecap:round; stroke-linejoin:round; stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <g style="fill:#ffffff; stroke:#000000; stroke-linecap:butt;">       <path        d="M 9,36 C 12.39,35.03 19.11,36.43 22.5,34 C 25.89,36.43 32.61,35.03 36,36 C 36,36 37.65,36.54 39,38 C 38.32,38.97 37.35,38.99 36,38.5 C 32.61,37.53 25.89,38.96 22.5,37.5 C 19.11,38.96 12.39,37.53 9,38.5 C 7.646,38.99 6.677,38.97 6,38 C 7.354,36.06 9,36 9,36 z" />      <path        d="M 15,32 C 17.5,34.5 27.5,34.5 30,32 C 30.5,30.5 30,30 30,30 C 30,27.5 27.5,26 27.5,26 C 33,24.5 33.5,14.5 22.5,10.5 C 11.5,14.5 12,24.5 17.5,26 C 17.5,26 15,27.5 15,30 C 15,30 14.5,30.5 15,32 z" />      <path        d="M 25 8 A 2.5 2.5 0 1 1  20,8 A 2.5 2.5 0 1 1  25 8 z" />    </g>    <path      d="M 17.5,26 L 27.5,26 M 15,30 L 30,30 M 22.5,15.5 L 22.5,20.5 M 20,18 L 25,18"      style="fill:none; stroke:#000000; stroke-linejoin:miter;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.BishopWhite",
            size: {
                width: 38,
                height: 38
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.BishopBlack = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="opacity:1; fill:none; fill-rule:evenodd; fill-opacity:1; stroke:#000000; stroke-width:1.5; stroke-linecap:round; stroke-linejoin:round; stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <g style="fill:#000000; stroke:#000000; stroke-linecap:butt;">       <path        d="M 9,36 C 12.39,35.03 19.11,36.43 22.5,34 C 25.89,36.43 32.61,35.03 36,36 C 36,36 37.65,36.54 39,38 C 38.32,38.97 37.35,38.99 36,38.5 C 32.61,37.53 25.89,38.96 22.5,37.5 C 19.11,38.96 12.39,37.53 9,38.5 C 7.646,38.99 6.677,38.97 6,38 C 7.354,36.06 9,36 9,36 z" />      <path        d="M 15,32 C 17.5,34.5 27.5,34.5 30,32 C 30.5,30.5 30,30 30,30 C 30,27.5 27.5,26 27.5,26 C 33,24.5 33.5,14.5 22.5,10.5 C 11.5,14.5 12,24.5 17.5,26 C 17.5,26 15,27.5 15,30 C 15,30 14.5,30.5 15,32 z" />      <path        d="M 25 8 A 2.5 2.5 0 1 1  20,8 A 2.5 2.5 0 1 1  25 8 z" />    </g>    <path       d="M 17.5,26 L 27.5,26 M 15,30 L 30,30 M 22.5,15.5 L 22.5,20.5 M 20,18 L 25,18"       style="fill:none; stroke:#ffffff; stroke-linejoin:miter;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.BishopBlack",
            size: {
                width: 38,
                height: 38
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.KnightWhite = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="opacity:1; fill:none; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <path      d="M 22,10 C 32.5,11 38.5,18 38,39 L 15,39 C 15,30 25,32.5 23,18"      style="fill:#ffffff; stroke:#000000;" />    <path      d="M 24,18 C 24.38,20.91 18.45,25.37 16,27 C 13,29 13.18,31.34 11,31 C 9.958,30.06 12.41,27.96 11,28 C 10,28 11.19,29.23 10,30 C 9,30 5.997,31 6,26 C 6,24 12,14 12,14 C 12,14 13.89,12.1 14,10.5 C 13.27,9.506 13.5,8.5 13.5,7.5 C 14.5,6.5 16.5,10 16.5,10 L 18.5,10 C 18.5,10 19.28,8.008 21,7 C 22,7 22,10 22,10"      style="fill:#ffffff; stroke:#000000;" />    <path      d="M 9.5 25.5 A 0.5 0.5 0 1 1 8.5,25.5 A 0.5 0.5 0 1 1 9.5 25.5 z"      style="fill:#000000; stroke:#000000;" />    <path      d="M 15 15.5 A 0.5 1.5 0 1 1  14,15.5 A 0.5 1.5 0 1 1  15 15.5 z"      transform="matrix(0.866,0.5,-0.5,0.866,9.693,-5.173)"      style="fill:#000000; stroke:#000000;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.KnightWhite",
            size: {
                width: 38,
                height: 37
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.KnightBlack = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><g style="opacity:1; fill:none; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;">    <path      d="M 22,10 C 32.5,11 38.5,18 38,39 L 15,39 C 15,30 25,32.5 23,18"      style="fill:#000000; stroke:#000000;" />    <path      d="M 24,18 C 24.38,20.91 18.45,25.37 16,27 C 13,29 13.18,31.34 11,31 C 9.958,30.06 12.41,27.96 11,28 C 10,28 11.19,29.23 10,30 C 9,30 5.997,31 6,26 C 6,24 12,14 12,14 C 12,14 13.89,12.1 14,10.5 C 13.27,9.506 13.5,8.5 13.5,7.5 C 14.5,6.5 16.5,10 16.5,10 L 18.5,10 C 18.5,10 19.28,8.008 21,7 C 22,7 22,10 22,10"      style="fill:#000000; stroke:#000000;" />    <path      d="M 9.5 25.5 A 0.5 0.5 0 1 1 8.5,25.5 A 0.5 0.5 0 1 1 9.5 25.5 z"      style="fill:#ffffff; stroke:#ffffff;" />    <path      d="M 15 15.5 A 0.5 1.5 0 1 1  14,15.5 A 0.5 1.5 0 1 1  15 15.5 z"      transform="matrix(0.866,0.5,-0.5,0.866,9.693,-5.173)"      style="fill:#ffffff; stroke:#ffffff;" />    <path      d="M 24.55,10.4 L 24.1,11.85 L 24.6,12 C 27.75,13 30.25,14.49 32.5,18.75 C 34.75,23.01 35.75,29.06 35.25,39 L 35.2,39.5 L 37.45,39.5 L 37.5,39 C 38,28.94 36.62,22.15 34.25,17.66 C 31.88,13.17 28.46,11.02 25.06,10.5 L 24.55,10.4 z "      style="fill:#ffffff; stroke:none;" />  </g></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.KnightBlack",
            size: {
                width: 38,
                height: 37
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.PawnWhite = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><path d="M 22,9 C 19.79,9 18,10.79 18,13 C 18,13.89 18.29,14.71 18.78,15.38 C 16.83,16.5 15.5,18.59 15.5,21 C 15.5,23.03 16.44,24.84 17.91,26.03 C 14.91,27.09 10.5,31.58 10.5,39.5 L 33.5,39.5 C 33.5,31.58 29.09,27.09 26.09,26.03 C 27.56,24.84 28.5,23.03 28.5,21 C 28.5,18.59 27.17,16.5 25.22,15.38 C 25.71,14.71 26,13.89 26,13 C 26,10.79 24.21,9 22,9 z "  style="opacity:1; fill:#ffffff; fill-opacity:1; fill-rule:nonzero; stroke:#000000; stroke-width:1.5; stroke-linecap:round; stroke-linejoin:miter; stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;" /></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.PawnWhite",
            size: {
                width: 28,
                height: 33
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chess.PawnBlack = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><path d="M 22,9 C 19.79,9 18,10.79 18,13 C 18,13.89 18.29,14.71 18.78,15.38 C 16.83,16.5 15.5,18.59 15.5,21 C 15.5,23.03 16.44,24.84 17.91,26.03 C 14.91,27.09 10.5,31.58 10.5,39.5 L 33.5,39.5 C 33.5,31.58 29.09,27.09 26.09,26.03 C 27.56,24.84 28.5,23.03 28.5,21 C 28.5,18.59 27.17,16.5 25.22,15.38 C 25.71,14.71 26,13.89 26,13 C 26,10.79 24.21,9 22,9 z "  style="opacity:1; fill:#000000; fill-opacity:1; fill-rule:nonzero; stroke:#000000; stroke-width:1.5; stroke-linecap:round; stroke-linejoin:miter; stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;" /></g></g>',
        defaults: _.defaultsDeep({
            type: "chess.PawnBlack",
            size: {
                width: 28,
                height: 33
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    });
    joint.shapes.pn = {}, joint.shapes.pn.Place = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><circle class="root"/><g class="tokens" /></g><text class="label"/></g>',
        defaults: _.defaultsDeep({
            type: "pn.Place",
            size: {
                width: 50,
                height: 50
            },
            attrs: {
                ".root": {
                    r: 25,
                    fill: "#ffffff",
                    stroke: "#000000",
                    transform: "translate(25, 25)"
                },
                ".label": {
                    "text-anchor": "middle",
                    "ref-x": .5,
                    "ref-y": -20,
                    ref: ".root",
                    fill: "#000000",
                    "font-size": 12
                },
                ".tokens > circle": {
                    fill: "#000000",
                    r: 5
                },
                ".tokens.one > circle": {
                    transform: "translate(25, 25)"
                },
                ".tokens.two > circle:nth-child(1)": {
                    transform: "translate(19, 25)"
                },
                ".tokens.two > circle:nth-child(2)": {
                    transform: "translate(31, 25)"
                },
                ".tokens.three > circle:nth-child(1)": {
                    transform: "translate(18, 29)"
                },
                ".tokens.three > circle:nth-child(2)": {
                    transform: "translate(25, 19)"
                },
                ".tokens.three > circle:nth-child(3)": {
                    transform: "translate(32, 29)"
                },
                ".tokens.alot > text": {
                    transform: "translate(25, 18)",
                    "text-anchor": "middle",
                    fill: "#000000"
                }
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.pn.PlaceView = joint.dia.ElementView.extend({
        initialize: function() {
            joint.dia.ElementView.prototype.initialize.apply(this, arguments), this.model.on("change:tokens", function() {
                this.renderTokens(), this.update()
            }, this)
        },
        render: function() {
            joint.dia.ElementView.prototype.render.apply(this, arguments), this.renderTokens(), this.update()
        },
        renderTokens: function() {
            var a = this.$(".tokens").empty();
            a[0].className.baseVal = "tokens";
            var b = this.model.get("tokens");
            if (b) switch (b) {
                case 1:
                    a[0].className.baseVal += " one", a.append(V("<circle/>").node);
                    break;
                case 2:
                    a[0].className.baseVal += " two", a.append(V("<circle/>").node, V("<circle/>").node);
                    break;
                case 3:
                    a[0].className.baseVal += " three", a.append(V("<circle/>").node, V("<circle/>").node, V("<circle/>").node);
                    break;
                default:
                    a[0].className.baseVal += " alot", a.append(V("<text/>").text(b + "").node)
            }
        }
    }), joint.shapes.pn.Transition = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><rect class="root"/></g></g><text class="label"/>',
        defaults: _.defaultsDeep({
            type: "pn.Transition",
            size: {
                width: 12,
                height: 50
            },
            attrs: {
                rect: {
                    width: 12,
                    height: 50,
                    fill: "#000000",
                    stroke: "#000000"
                },
                ".label": {
                    "text-anchor": "middle",
                    "ref-x": .5,
                    "ref-y": -20,
                    ref: "rect",
                    fill: "#000000",
                    "font-size": 12
                }
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.pn.Link = joint.dia.Link.extend({
        defaults: _.defaultsDeep({
            type: "pn.Link",
            attrs: {
                ".marker-target": {
                    d: "M 10 0 L 0 5 L 10 10 z"
                }
            }
        }, joint.dia.Link.prototype.defaults)
    });
    joint.shapes.devs = {}, joint.shapes.devs.Model = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><rect class="body"/><text class="label"/></g>',
        portMarkup: '<circle class="port-body"/>',
        portLabelMarkup: '<text class="port-label"/>',
        defaults: _.defaultsDeep({
            type: "devs.Model",
            inPorts: [],
            outPorts: [],
            size: {
                width: 80,
                height: 80
            },
            attrs: {
                ".": {
                    magnet: !1
                },
                ".label": {
                    text: "Model",
                    "ref-x": .5,
                    "ref-y": 10,
                    "font-size": 18,
                    "text-anchor": "middle",
                    fill: "#000"
                },
                ".body": {
                    "ref-width": "100%",
                    "ref-height": "100%",
                    stroke: "#000"
                }
            },
            ports: {
                groups: { in: {
                        position: {
                            name: "left"
                        },
                        attrs: {
                            ".port-label": {
                                fill: "#000"
                            },
                            ".port-body": {
                                fill: "#fff",
                                stroke: "#000",
                                r: 10,
                                magnet: !0
                            }
                        },
                        label: {
                            position: {
                                name: "left",
                                args: {
                                    y: 10
                                }
                            }
                        }
                    },
                    out: {
                        position: {
                            name: "right"
                        },
                        attrs: {
                            ".port-label": {
                                fill: "#000"
                            },
                            ".port-body": {
                                fill: "#fff",
                                stroke: "#000",
                                r: 10,
                                magnet: !0
                            }
                        },
                        label: {
                            position: {
                                name: "right",
                                args: {
                                    y: 10
                                }
                            }
                        }
                    }
                }
            }
        }, joint.shapes.basic.Generic.prototype.defaults),
        initialize: function() {
            joint.shapes.basic.Generic.prototype.initialize.apply(this, arguments), this.on("change:inPorts change:outPorts", this.updatePortItems, this), this.updatePortItems()
        },
        updatePortItems: function(a, b, c) {
            var d = _.uniq(this.get("inPorts")),
                e = _.difference(_.uniq(this.get("outPorts")), d),
                f = this.createPortItems("in", d),
                g = this.createPortItems("out", e);
            this.prop("ports/items", f.concat(g), _.extend({
                rewrite: !0
            }, c))
        },
        createPortItem: function(a, b) {
            return {
                id: b,
                group: a,
                attrs: {
                    ".port-label": {
                        text: b
                    }
                }
            }
        },
        createPortItems: function(a, b) {
            return _.map(b, _.bind(this.createPortItem, this, a))
        },
        _addGroupPort: function(a, b, c) {
            var d = this.get(b);
            return this.set(b, _.isArray(d) ? d.concat(a) : [a], c)
        },
        addOutPort: function(a, b) {
            return this._addGroupPort(a, "outPorts", b)
        },
        addInPort: function(a, b) {
            return this._addGroupPort(a, "inPorts", b)
        },
        _removeGroupPort: function(a, b, c) {
            return this.set(b, _.without(this.get(b), a), c)
        },
        removeOutPort: function(a, b) {
            return this._removeGroupPort(a, "outPorts", b)
        },
        removeInPort: function(a, b) {
            return this._removeGroupPort(a, "inPorts", b)
        },
        _changeGroup: function(a, b, c) {
            return this.prop("ports/groups/" + a, _.isObject(b) ? b : {}, c)
        },
        changeInGroup: function(a, b) {
            return this._changeGroup("in", a, b)
        },
        changeOutGroup: function(a, b) {
            return this._changeGroup("out", a, b)
        }
    }), joint.shapes.devs.Atomic = joint.shapes.devs.Model.extend({
        defaults: _.defaultsDeep({
            type: "devs.Atomic",
            size: {
                width: 80,
                height: 80
            },
            attrs: {
                ".label": {
                    text: "Atomic"
                }
            }
        }, joint.shapes.devs.Model.prototype.defaults)
    }), joint.shapes.devs.Coupled = joint.shapes.devs.Model.extend({
        defaults: _.defaultsDeep({
            type: "devs.Coupled",
            size: {
                width: 200,
                height: 300
            },
            attrs: {
                ".label": {
                    text: "Coupled"
                }
            }
        }, joint.shapes.devs.Model.prototype.defaults)
    }), joint.shapes.devs.Link = joint.dia.Link.extend({
        defaults: {
            type: "devs.Link",
            attrs: {
                ".connection": {
                    "stroke-width": 2
                }
            }
        }
    });
    joint.shapes.uml = {}, joint.shapes.uml.Class = joint.shapes.basic.Generic.extend({
        markup: ['<g class="rotatable">', '<g class="scalable">', '<rect class="uml-class-name-rect"/><rect class="uml-class-attrs-rect"/><rect class="uml-class-methods-rect"/>', "</g>", '<text class="uml-class-name-text"/><text class="uml-class-attrs-text"/><text class="uml-class-methods-text"/>', "</g>"].join(""),
        defaults: _.defaultsDeep({
            type: "uml.Class",
            attrs: {
                rect: {
                    width: 200
                },
                ".uml-class-name-rect": {
                    stroke: "black",
                    "stroke-width": 2,
                    fill: "#3498db"
                },
                ".uml-class-attrs-rect": {
                    stroke: "black",
                    "stroke-width": 2,
                    fill: "#2980b9"
                },
                ".uml-class-methods-rect": {
                    stroke: "black",
                    "stroke-width": 2,
                    fill: "#2980b9"
                },
                ".uml-class-name-text": {
                    ref: ".uml-class-name-rect",
                    "ref-y": .5,
                    "ref-x": .5,
                    "text-anchor": "middle",
                    "y-alignment": "middle",
                    "font-weight": "bold",
                    fill: "black",
                    "font-size": 12,
                    "font-family": "Times New Roman"
                },
                ".uml-class-attrs-text": {
                    ref: ".uml-class-attrs-rect",
                    "ref-y": 5,
                    "ref-x": 5,
                    fill: "black",
                    "font-size": 12,
                    "font-family": "Times New Roman"
                },
                ".uml-class-methods-text": {
                    ref: ".uml-class-methods-rect",
                    "ref-y": 5,
                    "ref-x": 5,
                    fill: "black",
                    "font-size": 12,
                    "font-family": "Times New Roman"
                }
            },
            name: [],
            attributes: [],
            methods: []
        }, joint.shapes.basic.Generic.prototype.defaults),
        initialize: function() {
            this.on("change:name change:attributes change:methods", function() {
                this.updateRectangles(), this.trigger("uml-update")
            }, this), this.updateRectangles(), joint.shapes.basic.Generic.prototype.initialize.apply(this, arguments)
        },
        getClassName: function() {
            return this.get("name")
        },
        updateRectangles: function() {
            var a = this.get("attrs"),
                b = [{
                    type: "name",
                    text: this.getClassName()
                }, {
                    type: "attrs",
                    text: this.get("attributes")
                }, {
                    type: "methods",
                    text: this.get("methods")
                }],
                c = 0;
            _.each(b, function(b) {
                var d = _.isArray(b.text) ? b.text : [b.text],
                    e = 20 * d.length + 20;
                a[".uml-class-" + b.type + "-text"].text = d.join("\n"), a[".uml-class-" + b.type + "-rect"].height = e, a[".uml-class-" + b.type + "-rect"].transform = "translate(0," + c + ")", c += e
            })
        }
    }), joint.shapes.uml.ClassView = joint.dia.ElementView.extend({
        initialize: function() {
            joint.dia.ElementView.prototype.initialize.apply(this, arguments), this.listenTo(this.model, "uml-update", function() {
                this.update(), this.resize()
            })
        }
    }), joint.shapes.uml.Abstract = joint.shapes.uml.Class.extend({
        defaults: _.defaultsDeep({
            type: "uml.Abstract",
            attrs: {
                ".uml-class-name-rect": {
                    fill: "#e74c3c"
                },
                ".uml-class-attrs-rect": {
                    fill: "#c0392b"
                },
                ".uml-class-methods-rect": {
                    fill: "#c0392b"
                }
            }
        }, joint.shapes.uml.Class.prototype.defaults),
        getClassName: function() {
            return ["<<Abstract>>", this.get("name")]
        }
    }), joint.shapes.uml.AbstractView = joint.shapes.uml.ClassView, joint.shapes.uml.Interface = joint.shapes.uml.Class.extend({
        defaults: _.defaultsDeep({
            type: "uml.Interface",
            attrs: {
                ".uml-class-name-rect": {
                    fill: "#f1c40f"
                },
                ".uml-class-attrs-rect": {
                    fill: "#f39c12"
                },
                ".uml-class-methods-rect": {
                    fill: "#f39c12"
                }
            }
        }, joint.shapes.uml.Class.prototype.defaults),
        getClassName: function() {
            return ["<<Interface>>", this.get("name")]
        }
    }), joint.shapes.uml.InterfaceView = joint.shapes.uml.ClassView, joint.shapes.uml.Generalization = joint.dia.Link.extend({
        defaults: {
            type: "uml.Generalization",
            attrs: {
                ".marker-target": {
                    d: "M 20 0 L 0 10 L 20 20 z",
                    fill: "white"
                }
            }
        }
    }), joint.shapes.uml.Implementation = joint.dia.Link.extend({
        defaults: {
            type: "uml.Implementation",
            attrs: {
                ".marker-target": {
                    d: "M 20 0 L 0 10 L 20 20 z",
                    fill: "white"
                },
                ".connection": {
                    "stroke-dasharray": "3,3"
                }
            }
        }
    }), joint.shapes.uml.Aggregation = joint.dia.Link.extend({
        defaults: {
            type: "uml.Aggregation",
            attrs: {
                ".marker-target": {
                    d: "M 40 10 L 20 20 L 0 10 L 20 0 z",
                    fill: "white"
                }
            }
        }
    }), joint.shapes.uml.Composition = joint.dia.Link.extend({
        defaults: {
            type: "uml.Composition",
            attrs: {
                ".marker-target": {
                    d: "M 40 10 L 20 20 L 0 10 L 20 0 z",
                    fill: "black"
                }
            }
        }
    }), joint.shapes.uml.Association = joint.dia.Link.extend({
        defaults: {
            type: "uml.Association"
        }
    }), joint.shapes.uml.State = joint.shapes.basic.Generic.extend({
        markup: ['<g class="rotatable">', '<g class="scalable">', '<rect class="uml-state-body"/>', "</g>", '<path class="uml-state-separator"/>', '<text class="uml-state-name"/>', '<text class="uml-state-events"/>', "</g>"].join(""),
        defaults: _.defaultsDeep({
            type: "uml.State",
            attrs: {
                ".uml-state-body": {
                    width: 200,
                    height: 200,
                    rx: 10,
                    ry: 10,
                    fill: "#ecf0f1",
                    stroke: "#bdc3c7",
                    "stroke-width": 3
                },
                ".uml-state-separator": {
                    stroke: "#bdc3c7",
                    "stroke-width": 2
                },
                ".uml-state-name": {
                    ref: ".uml-state-body",
                    "ref-x": .5,
                    "ref-y": 5,
                    "text-anchor": "middle",
                    fill: "#000000",
                    "font-family": "Courier New",
                    "font-size": 14
                },
                ".uml-state-events": {
                    ref: ".uml-state-separator",
                    "ref-x": 5,
                    "ref-y": 5,
                    fill: "#000000",
                    "font-family": "Courier New",
                    "font-size": 14
                }
            },
            name: "State",
            events: []
        }, joint.shapes.basic.Generic.prototype.defaults),
        initialize: function() {
            this.on({
                "change:name": this.updateName,
                "change:events": this.updateEvents,
                "change:size": this.updatePath
            }, this), this.updateName(), this.updateEvents(), this.updatePath(), joint.shapes.basic.Generic.prototype.initialize.apply(this, arguments)
        },
        updateName: function() {
            this.attr(".uml-state-name/text", this.get("name"))
        },
        updateEvents: function() {
            this.attr(".uml-state-events/text", this.get("events").join("\n"))
        },
        updatePath: function() {
            var a = "M 0 20 L " + this.get("size").width + " 20";
            this.attr(".uml-state-separator/d", a, {
                silent: !0
            })
        }
    }), joint.shapes.uml.StartState = joint.shapes.basic.Circle.extend({
        defaults: _.defaultsDeep({
            type: "uml.StartState",
            attrs: {
                circle: {
                    fill: "#34495e",
                    stroke: "#2c3e50",
                    "stroke-width": 2,
                    rx: 1
                }
            }
        }, joint.shapes.basic.Circle.prototype.defaults)
    }), joint.shapes.uml.EndState = joint.shapes.basic.Generic.extend({
        markup: '<g class="rotatable"><g class="scalable"><circle class="outer"/><circle class="inner"/></g></g>',
        defaults: _.defaultsDeep({
            type: "uml.EndState",
            size: {
                width: 20,
                height: 20
            },
            attrs: {
                "circle.outer": {
                    transform: "translate(10, 10)",
                    r: 10,
                    fill: "#ffffff",
                    stroke: "#2c3e50"
                },
                "circle.inner": {
                    transform: "translate(10, 10)",
                    r: 6,
                    fill: "#34495e"
                }
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.uml.Transition = joint.dia.Link.extend({
        defaults: {
            type: "uml.Transition",
            attrs: {
                ".marker-target": {
                    d: "M 10 0 L 0 5 L 10 10 z",
                    fill: "#34495e",
                    stroke: "#2c3e50"
                },
                ".connection": {
                    stroke: "#2c3e50"
                }
            }
        }
    });
    joint.shapes.logic = {}, joint.shapes.logic.Gate = joint.shapes.basic.Generic.extend({
        defaults: _.defaultsDeep({
            type: "logic.Gate",
            size: {
                width: 80,
                height: 40
            },
            attrs: {
                ".": {
                    magnet: !1
                },
                ".body": {
                    width: 100,
                    height: 50
                },
                circle: {
                    r: 7,
                    stroke: "black",
                    fill: "transparent",
                    "stroke-width": 2
                }
            }
        }, joint.shapes.basic.Generic.prototype.defaults),
        operation: function() {
            return !0
        }
    }), joint.shapes.logic.IO = joint.shapes.logic.Gate.extend({
        markup: '<g class="rotatable"><g class="scalable"><rect class="body"/></g><path class="wire"/><circle/><text/></g>',
        defaults: _.defaultsDeep({
            type: "logic.IO",
            size: {
                width: 60,
                height: 30
            },
            attrs: {
                ".body": {
                    fill: "white",
                    stroke: "black",
                    "stroke-width": 2
                },
                ".wire": {
                    ref: ".body",
                    "ref-y": .5,
                    stroke: "black"
                },
                text: {
                    fill: "black",
                    ref: ".body",
                    "ref-x": .5,
                    "ref-y": .5,
                    "y-alignment": "middle",
                    "text-anchor": "middle",
                    "font-weight": "bold",
                    "font-variant": "small-caps",
                    "text-transform": "capitalize",
                    "font-size": "14px"
                }
            }
        }, joint.shapes.logic.Gate.prototype.defaults)
    }), joint.shapes.logic.Input = joint.shapes.logic.IO.extend({
        defaults: _.defaultsDeep({
            type: "logic.Input",
            attrs: {
                ".wire": {
                    "ref-dx": 0,
                    d: "M 0 0 L 23 0"
                },
                circle: {
                    ref: ".body",
                    "ref-dx": 30,
                    "ref-y": .5,
                    magnet: !0,
                    class: "output",
                    port: "out"
                },
                text: {
                    text: "input"
                }
            }
        }, joint.shapes.logic.IO.prototype.defaults)
    }), joint.shapes.logic.Output = joint.shapes.logic.IO.extend({
        defaults: _.defaultsDeep({
            type: "logic.Output",
            attrs: {
                ".wire": {
                    "ref-x": 0,
                    d: "M 0 0 L -23 0"
                },
                circle: {
                    ref: ".body",
                    "ref-x": -30,
                    "ref-y": .5,
                    magnet: "passive",
                    class: "input",
                    port: "in"
                },
                text: {
                    text: "output"
                }
            }
        }, joint.shapes.logic.IO.prototype.defaults)
    }), joint.shapes.logic.Gate11 = joint.shapes.logic.Gate.extend({
        markup: '<g class="rotatable"><g class="scalable"><image class="body"/></g><circle class="input"/><circle class="output"/></g>',
        defaults: _.defaultsDeep({
            type: "logic.Gate11",
            attrs: {
                ".input": {
                    ref: ".body",
                    "ref-x": -2,
                    "ref-y": .5,
                    magnet: "passive",
                    port: "in"
                },
                ".output": {
                    ref: ".body",
                    "ref-dx": 2,
                    "ref-y": .5,
                    magnet: !0,
                    port: "out"
                }
            }
        }, joint.shapes.logic.Gate.prototype.defaults)
    }), joint.shapes.logic.Gate21 = joint.shapes.logic.Gate.extend({
        markup: '<g class="rotatable"><g class="scalable"><image class="body"/></g><circle class="input input1"/><circle  class="input input2"/><circle class="output"/></g>',
        defaults: _.defaultsDeep({
            type: "logic.Gate21",
            attrs: {
                ".input1": {
                    ref: ".body",
                    "ref-x": -2,
                    "ref-y": .3,
                    magnet: "passive",
                    port: "in1"
                },
                ".input2": {
                    ref: ".body",
                    "ref-x": -2,
                    "ref-y": .7,
                    magnet: "passive",
                    port: "in2"
                },
                ".output": {
                    ref: ".body",
                    "ref-dx": 2,
                    "ref-y": .5,
                    magnet: !0,
                    port: "out"
                }
            }
        }, joint.shapes.logic.Gate.prototype.defaults)
    }), joint.shapes.logic.Repeater = joint.shapes.logic.Gate11.extend({
        defaults: _.defaultsDeep({
            type: "logic.Repeater",
            attrs: {
                image: {
                    "xlink:href": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy8pIC0tPgo8c3ZnCiAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgeG1sbnM6Y2M9Imh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL25zIyIKICAgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIgogICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zOnNvZGlwb2RpPSJodHRwOi8vc29kaXBvZGkuc291cmNlZm9yZ2UubmV0L0RURC9zb2RpcG9kaS0wLmR0ZCIKICAgeG1sbnM6aW5rc2NhcGU9Imh0dHA6Ly93d3cuaW5rc2NhcGUub3JnL25hbWVzcGFjZXMvaW5rc2NhcGUiCiAgIHdpZHRoPSIxMDAiCiAgIGhlaWdodD0iNTAiCiAgIGlkPSJzdmcyIgogICBzb2RpcG9kaTp2ZXJzaW9uPSIwLjMyIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ2IgogICB2ZXJzaW9uPSIxLjAiCiAgIHNvZGlwb2RpOmRvY25hbWU9Ik5PVCBBTlNJLnN2ZyIKICAgaW5rc2NhcGU6b3V0cHV0X2V4dGVuc2lvbj0ib3JnLmlua3NjYXBlLm91dHB1dC5zdmcuaW5rc2NhcGUiPgogIDxkZWZzCiAgICAgaWQ9ImRlZnM0Ij4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAxNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF96PSI1MCA6IDE1IDogMSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIyNSA6IDEwIDogMSIKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI3MTQiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMC41IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEgOiAwLjUgOiAxIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjAuNSA6IDAuMzMzMzMzMzMgOiAxIgogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgwNiIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgxOSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIzNzIuMDQ3MjQgOiAzNTAuNzg3MzkgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNzQ0LjA5NDQ4IDogNTI2LjE4MTA5IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MjYuMTgxMDkgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjc3NyIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSI3NSA6IDQwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjE1MCA6IDYwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA2MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmUzMjc1IgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjUwIDogMzMuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEwMCA6IDUwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmU1NTMzIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjMyIDogMjEuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjY0IDogMzIgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDMyIDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI1NTciCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMjUgOiAxNi42NjY2NjcgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNTAgOiAyNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMjUgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICA8L2RlZnM+CiAgPHNvZGlwb2RpOm5hbWVkdmlldwogICAgIGlkPSJiYXNlIgogICAgIHBhZ2Vjb2xvcj0iI2ZmZmZmZiIKICAgICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgICBib3JkZXJvcGFjaXR5PSIxLjAiCiAgICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAuMCIKICAgICBpbmtzY2FwZTpwYWdlc2hhZG93PSIyIgogICAgIGlua3NjYXBlOnpvb209IjgiCiAgICAgaW5rc2NhcGU6Y3g9Ijg0LjY4NTM1MiIKICAgICBpbmtzY2FwZTpjeT0iMTUuMjg4NjI4IgogICAgIGlua3NjYXBlOmRvY3VtZW50LXVuaXRzPSJweCIKICAgICBpbmtzY2FwZTpjdXJyZW50LWxheWVyPSJsYXllcjEiCiAgICAgc2hvd2dyaWQ9InRydWUiCiAgICAgaW5rc2NhcGU6Z3JpZC1iYm94PSJ0cnVlIgogICAgIGlua3NjYXBlOmdyaWQtcG9pbnRzPSJ0cnVlIgogICAgIGdyaWR0b2xlcmFuY2U9IjEwMDAwIgogICAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTM5OSIKICAgICBpbmtzY2FwZTp3aW5kb3ctaGVpZ2h0PSI4NzQiCiAgICAgaW5rc2NhcGU6d2luZG93LXg9IjMzIgogICAgIGlua3NjYXBlOndpbmRvdy15PSIwIgogICAgIGlua3NjYXBlOnNuYXAtYmJveD0idHJ1ZSI+CiAgICA8aW5rc2NhcGU6Z3JpZAogICAgICAgaWQ9IkdyaWRGcm9tUHJlMDQ2U2V0dGluZ3MiCiAgICAgICB0eXBlPSJ4eWdyaWQiCiAgICAgICBvcmlnaW54PSIwcHgiCiAgICAgICBvcmlnaW55PSIwcHgiCiAgICAgICBzcGFjaW5neD0iMXB4IgogICAgICAgc3BhY2luZ3k9IjFweCIKICAgICAgIGNvbG9yPSIjMDAwMGZmIgogICAgICAgZW1wY29sb3I9IiMwMDAwZmYiCiAgICAgICBvcGFjaXR5PSIwLjIiCiAgICAgICBlbXBvcGFjaXR5PSIwLjQiCiAgICAgICBlbXBzcGFjaW5nPSI1IgogICAgICAgdmlzaWJsZT0idHJ1ZSIKICAgICAgIGVuYWJsZWQ9InRydWUiIC8+CiAgPC9zb2RpcG9kaTpuYW1lZHZpZXc+CiAgPG1ldGFkYXRhCiAgICAgaWQ9Im1ldGFkYXRhNyI+CiAgICA8cmRmOlJERj4KICAgICAgPGNjOldvcmsKICAgICAgICAgcmRmOmFib3V0PSIiPgogICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2Uvc3ZnK3htbDwvZGM6Zm9ybWF0PgogICAgICAgIDxkYzp0eXBlCiAgICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz4KICAgICAgPC9jYzpXb3JrPgogICAgPC9yZGY6UkRGPgogIDwvbWV0YWRhdGE+CiAgPGcKICAgICBpbmtzY2FwZTpsYWJlbD0iTGF5ZXIgMSIKICAgICBpbmtzY2FwZTpncm91cG1vZGU9ImxheWVyIgogICAgIGlkPSJsYXllcjEiPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjEuOTk5OTk5ODg7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Ik0gNzIuMTU2OTEsMjUgTCA5NSwyNSIKICAgICAgIGlkPSJwYXRoMzA1OSIKICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2MiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDAwMDtzdHJva2Utd2lkdGg6MjtzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgZD0iTSAyOS4wNDM0NzgsMjUgTCA1LjA0MzQ3ODEsMjUiCiAgICAgICBpZD0icGF0aDMwNjEiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZpbGw6IzAwMDAwMDtmaWxsLW9wYWNpdHk6MTtzdHJva2U6bm9uZTtzdHJva2Utd2lkdGg6MztzdHJva2UtbGluZWpvaW46bWl0ZXI7bWFya2VyOm5vbmU7c3Ryb2tlLW9wYWNpdHk6MTt2aXNpYmlsaXR5OnZpc2libGU7ZGlzcGxheTppbmxpbmU7b3ZlcmZsb3c6dmlzaWJsZTtlbmFibGUtYmFja2dyb3VuZDphY2N1bXVsYXRlIgogICAgICAgZD0iTSAyOC45Njg3NSwyLjU5Mzc1IEwgMjguOTY4NzUsNSBMIDI4Ljk2ODc1LDQ1IEwgMjguOTY4NzUsNDcuNDA2MjUgTCAzMS4xMjUsNDYuMzQzNzUgTCA3Mi4xNTYyNSwyNi4zNDM3NSBMIDcyLjE1NjI1LDIzLjY1NjI1IEwgMzEuMTI1LDMuNjU2MjUgTCAyOC45Njg3NSwyLjU5Mzc1IHogTSAzMS45Njg3NSw3LjQwNjI1IEwgNjguMDkzNzUsMjUgTCAzMS45Njg3NSw0Mi41OTM3NSBMIDMxLjk2ODc1LDcuNDA2MjUgeiIKICAgICAgIGlkPSJwYXRoMjYzOCIKICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2NjY2NjY2NjY2NjYyIgLz4KICA8L2c+Cjwvc3ZnPgo="
                }
            }
        }, joint.shapes.logic.Gate11.prototype.defaults),
        operation: function(a) {
            return a
        }
    }), joint.shapes.logic.Not = joint.shapes.logic.Gate11.extend({
        defaults: _.defaultsDeep({
            type: "logic.Not",
            attrs: {
                image: {
                    "xlink:href": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy8pIC0tPgo8c3ZnCiAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgeG1sbnM6Y2M9Imh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL25zIyIKICAgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIgogICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zOnNvZGlwb2RpPSJodHRwOi8vc29kaXBvZGkuc291cmNlZm9yZ2UubmV0L0RURC9zb2RpcG9kaS0wLmR0ZCIKICAgeG1sbnM6aW5rc2NhcGU9Imh0dHA6Ly93d3cuaW5rc2NhcGUub3JnL25hbWVzcGFjZXMvaW5rc2NhcGUiCiAgIHdpZHRoPSIxMDAiCiAgIGhlaWdodD0iNTAiCiAgIGlkPSJzdmcyIgogICBzb2RpcG9kaTp2ZXJzaW9uPSIwLjMyIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ2IgogICB2ZXJzaW9uPSIxLjAiCiAgIHNvZGlwb2RpOmRvY25hbWU9Ik5PVCBBTlNJLnN2ZyIKICAgaW5rc2NhcGU6b3V0cHV0X2V4dGVuc2lvbj0ib3JnLmlua3NjYXBlLm91dHB1dC5zdmcuaW5rc2NhcGUiPgogIDxkZWZzCiAgICAgaWQ9ImRlZnM0Ij4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAxNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF96PSI1MCA6IDE1IDogMSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIyNSA6IDEwIDogMSIKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI3MTQiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMC41IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEgOiAwLjUgOiAxIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjAuNSA6IDAuMzMzMzMzMzMgOiAxIgogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgwNiIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgxOSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIzNzIuMDQ3MjQgOiAzNTAuNzg3MzkgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNzQ0LjA5NDQ4IDogNTI2LjE4MTA5IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MjYuMTgxMDkgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjc3NyIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSI3NSA6IDQwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjE1MCA6IDYwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA2MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmUzMjc1IgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjUwIDogMzMuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEwMCA6IDUwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmU1NTMzIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjMyIDogMjEuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjY0IDogMzIgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDMyIDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI1NTciCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMjUgOiAxNi42NjY2NjcgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNTAgOiAyNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMjUgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICA8L2RlZnM+CiAgPHNvZGlwb2RpOm5hbWVkdmlldwogICAgIGlkPSJiYXNlIgogICAgIHBhZ2Vjb2xvcj0iI2ZmZmZmZiIKICAgICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgICBib3JkZXJvcGFjaXR5PSIxLjAiCiAgICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAuMCIKICAgICBpbmtzY2FwZTpwYWdlc2hhZG93PSIyIgogICAgIGlua3NjYXBlOnpvb209IjgiCiAgICAgaW5rc2NhcGU6Y3g9Ijg0LjY4NTM1MiIKICAgICBpbmtzY2FwZTpjeT0iMTUuMjg4NjI4IgogICAgIGlua3NjYXBlOmRvY3VtZW50LXVuaXRzPSJweCIKICAgICBpbmtzY2FwZTpjdXJyZW50LWxheWVyPSJsYXllcjEiCiAgICAgc2hvd2dyaWQ9InRydWUiCiAgICAgaW5rc2NhcGU6Z3JpZC1iYm94PSJ0cnVlIgogICAgIGlua3NjYXBlOmdyaWQtcG9pbnRzPSJ0cnVlIgogICAgIGdyaWR0b2xlcmFuY2U9IjEwMDAwIgogICAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTM5OSIKICAgICBpbmtzY2FwZTp3aW5kb3ctaGVpZ2h0PSI4NzQiCiAgICAgaW5rc2NhcGU6d2luZG93LXg9IjMzIgogICAgIGlua3NjYXBlOndpbmRvdy15PSIwIgogICAgIGlua3NjYXBlOnNuYXAtYmJveD0idHJ1ZSI+CiAgICA8aW5rc2NhcGU6Z3JpZAogICAgICAgaWQ9IkdyaWRGcm9tUHJlMDQ2U2V0dGluZ3MiCiAgICAgICB0eXBlPSJ4eWdyaWQiCiAgICAgICBvcmlnaW54PSIwcHgiCiAgICAgICBvcmlnaW55PSIwcHgiCiAgICAgICBzcGFjaW5neD0iMXB4IgogICAgICAgc3BhY2luZ3k9IjFweCIKICAgICAgIGNvbG9yPSIjMDAwMGZmIgogICAgICAgZW1wY29sb3I9IiMwMDAwZmYiCiAgICAgICBvcGFjaXR5PSIwLjIiCiAgICAgICBlbXBvcGFjaXR5PSIwLjQiCiAgICAgICBlbXBzcGFjaW5nPSI1IgogICAgICAgdmlzaWJsZT0idHJ1ZSIKICAgICAgIGVuYWJsZWQ9InRydWUiIC8+CiAgPC9zb2RpcG9kaTpuYW1lZHZpZXc+CiAgPG1ldGFkYXRhCiAgICAgaWQ9Im1ldGFkYXRhNyI+CiAgICA8cmRmOlJERj4KICAgICAgPGNjOldvcmsKICAgICAgICAgcmRmOmFib3V0PSIiPgogICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2Uvc3ZnK3htbDwvZGM6Zm9ybWF0PgogICAgICAgIDxkYzp0eXBlCiAgICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz4KICAgICAgPC9jYzpXb3JrPgogICAgPC9yZGY6UkRGPgogIDwvbWV0YWRhdGE+CiAgPGcKICAgICBpbmtzY2FwZTpsYWJlbD0iTGF5ZXIgMSIKICAgICBpbmtzY2FwZTpncm91cG1vZGU9ImxheWVyIgogICAgIGlkPSJsYXllcjEiPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjEuOTk5OTk5ODg7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Ik0gNzkuMTU2OTEsMjUgTCA5NSwyNSIKICAgICAgIGlkPSJwYXRoMzA1OSIKICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2MiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDAwMDtzdHJva2Utd2lkdGg6MjtzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgZD0iTSAyOS4wNDM0NzgsMjUgTCA1LjA0MzQ3ODEsMjUiCiAgICAgICBpZD0icGF0aDMwNjEiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZpbGw6IzAwMDAwMDtmaWxsLW9wYWNpdHk6MTtzdHJva2U6bm9uZTtzdHJva2Utd2lkdGg6MztzdHJva2UtbGluZWpvaW46bWl0ZXI7bWFya2VyOm5vbmU7c3Ryb2tlLW9wYWNpdHk6MTt2aXNpYmlsaXR5OnZpc2libGU7ZGlzcGxheTppbmxpbmU7b3ZlcmZsb3c6dmlzaWJsZTtlbmFibGUtYmFja2dyb3VuZDphY2N1bXVsYXRlIgogICAgICAgZD0iTSAyOC45Njg3NSwyLjU5Mzc1IEwgMjguOTY4NzUsNSBMIDI4Ljk2ODc1LDQ1IEwgMjguOTY4NzUsNDcuNDA2MjUgTCAzMS4xMjUsNDYuMzQzNzUgTCA3Mi4xNTYyNSwyNi4zNDM3NSBMIDcyLjE1NjI1LDIzLjY1NjI1IEwgMzEuMTI1LDMuNjU2MjUgTCAyOC45Njg3NSwyLjU5Mzc1IHogTSAzMS45Njg3NSw3LjQwNjI1IEwgNjguMDkzNzUsMjUgTCAzMS45Njg3NSw0Mi41OTM3NSBMIDMxLjk2ODc1LDcuNDA2MjUgeiIKICAgICAgIGlkPSJwYXRoMjYzOCIKICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2NjY2NjY2NjY2NjYyIgLz4KICAgIDxwYXRoCiAgICAgICBzb2RpcG9kaTp0eXBlPSJhcmMiCiAgICAgICBzdHlsZT0iZmlsbDpub25lO2ZpbGwtb3BhY2l0eToxO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDozO3N0cm9rZS1saW5lam9pbjptaXRlcjttYXJrZXI6bm9uZTtzdHJva2Utb3BhY2l0eToxO3Zpc2liaWxpdHk6dmlzaWJsZTtkaXNwbGF5OmlubGluZTtvdmVyZmxvdzp2aXNpYmxlO2VuYWJsZS1iYWNrZ3JvdW5kOmFjY3VtdWxhdGUiCiAgICAgICBpZD0icGF0aDI2NzEiCiAgICAgICBzb2RpcG9kaTpjeD0iNzYiCiAgICAgICBzb2RpcG9kaTpjeT0iMjUiCiAgICAgICBzb2RpcG9kaTpyeD0iNCIKICAgICAgIHNvZGlwb2RpOnJ5PSI0IgogICAgICAgZD0iTSA4MCwyNSBBIDQsNCAwIDEgMSA3MiwyNSBBIDQsNCAwIDEgMSA4MCwyNSB6IgogICAgICAgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTEsMCkiIC8+CiAgPC9nPgo8L3N2Zz4K"
                }
            }
        }, joint.shapes.logic.Gate11.prototype.defaults),
        operation: function(a) {
            return !a
        }
    }), joint.shapes.logic.Or = joint.shapes.logic.Gate21.extend({
        defaults: _.defaultsDeep({
            type: "logic.Or",
            attrs: {
                image: {
                    "xlink:href": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy8pIC0tPgo8c3ZnCiAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgeG1sbnM6Y2M9Imh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL25zIyIKICAgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIgogICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zOnNvZGlwb2RpPSJodHRwOi8vc29kaXBvZGkuc291cmNlZm9yZ2UubmV0L0RURC9zb2RpcG9kaS0wLmR0ZCIKICAgeG1sbnM6aW5rc2NhcGU9Imh0dHA6Ly93d3cuaW5rc2NhcGUub3JnL25hbWVzcGFjZXMvaW5rc2NhcGUiCiAgIHdpZHRoPSIxMDAiCiAgIGhlaWdodD0iNTAiCiAgIGlkPSJzdmcyIgogICBzb2RpcG9kaTp2ZXJzaW9uPSIwLjMyIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ2IgogICB2ZXJzaW9uPSIxLjAiCiAgIHNvZGlwb2RpOmRvY25hbWU9Ik9SIEFOU0kuc3ZnIgogICBpbmtzY2FwZTpvdXRwdXRfZXh0ZW5zaW9uPSJvcmcuaW5rc2NhcGUub3V0cHV0LnN2Zy5pbmtzY2FwZSI+CiAgPGRlZnMKICAgICBpZD0iZGVmczQiPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDE1IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3o9IjUwIDogMTUgOiAxIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjI1IDogMTAgOiAxIgogICAgICAgaWQ9InBlcnNwZWN0aXZlMjcxNCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAwLjUgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfej0iMSA6IDAuNSA6IDEiCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMC41IDogMC4zMzMzMzMzMyA6IDEiCiAgICAgICBpZD0icGVyc3BlY3RpdmUyODA2IiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmUyODE5IgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjM3Mi4wNDcyNCA6IDM1MC43ODczOSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF96PSI3NDQuMDk0NDggOiA1MjYuMTgxMDkgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDUyNi4xODEwOSA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmUyNzc3IgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49Ijc1IDogNDAgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iMTUwIDogNjAgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDYwIDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTMyNzUiCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iNTAgOiAzMy4zMzMzMzMgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iMTAwIDogNTAgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDUwIDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTU1MzMiCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMzIgOiAyMS4zMzMzMzMgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNjQgOiAzMiA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMzIgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjU1NyIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIyNSA6IDE2LjY2NjY2NyA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF96PSI1MCA6IDI1IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAyNSA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogIDwvZGVmcz4KICA8c29kaXBvZGk6bmFtZWR2aWV3CiAgICAgaWQ9ImJhc2UiCiAgICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICAgIGJvcmRlcmNvbG9yPSIjNjY2NjY2IgogICAgIGJvcmRlcm9wYWNpdHk9IjEuMCIKICAgICBpbmtzY2FwZTpwYWdlb3BhY2l0eT0iMC4wIgogICAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgICAgaW5rc2NhcGU6em9vbT0iNCIKICAgICBpbmtzY2FwZTpjeD0iMTEzLjAwMDM5IgogICAgIGlua3NjYXBlOmN5PSIxMi44OTM3MzEiCiAgICAgaW5rc2NhcGU6ZG9jdW1lbnQtdW5pdHM9InB4IgogICAgIGlua3NjYXBlOmN1cnJlbnQtbGF5ZXI9ImcyNTYwIgogICAgIHNob3dncmlkPSJmYWxzZSIKICAgICBpbmtzY2FwZTpncmlkLWJib3g9InRydWUiCiAgICAgaW5rc2NhcGU6Z3JpZC1wb2ludHM9InRydWUiCiAgICAgZ3JpZHRvbGVyYW5jZT0iMTAwMDAiCiAgICAgaW5rc2NhcGU6d2luZG93LXdpZHRoPSIxMzk5IgogICAgIGlua3NjYXBlOndpbmRvdy1oZWlnaHQ9Ijg3NCIKICAgICBpbmtzY2FwZTp3aW5kb3cteD0iMzciCiAgICAgaW5rc2NhcGU6d2luZG93LXk9Ii00IgogICAgIGlua3NjYXBlOnNuYXAtYmJveD0idHJ1ZSI+CiAgICA8aW5rc2NhcGU6Z3JpZAogICAgICAgaWQ9IkdyaWRGcm9tUHJlMDQ2U2V0dGluZ3MiCiAgICAgICB0eXBlPSJ4eWdyaWQiCiAgICAgICBvcmlnaW54PSIwcHgiCiAgICAgICBvcmlnaW55PSIwcHgiCiAgICAgICBzcGFjaW5neD0iMXB4IgogICAgICAgc3BhY2luZ3k9IjFweCIKICAgICAgIGNvbG9yPSIjMDAwMGZmIgogICAgICAgZW1wY29sb3I9IiMwMDAwZmYiCiAgICAgICBvcGFjaXR5PSIwLjIiCiAgICAgICBlbXBvcGFjaXR5PSIwLjQiCiAgICAgICBlbXBzcGFjaW5nPSI1IgogICAgICAgdmlzaWJsZT0idHJ1ZSIKICAgICAgIGVuYWJsZWQ9InRydWUiIC8+CiAgPC9zb2RpcG9kaTpuYW1lZHZpZXc+CiAgPG1ldGFkYXRhCiAgICAgaWQ9Im1ldGFkYXRhNyI+CiAgICA8cmRmOlJERj4KICAgICAgPGNjOldvcmsKICAgICAgICAgcmRmOmFib3V0PSIiPgogICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2Uvc3ZnK3htbDwvZGM6Zm9ybWF0PgogICAgICAgIDxkYzp0eXBlCiAgICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz4KICAgICAgPC9jYzpXb3JrPgogICAgPC9yZGY6UkRGPgogIDwvbWV0YWRhdGE+CiAgPGcKICAgICBpbmtzY2FwZTpsYWJlbD0iTGF5ZXIgMSIKICAgICBpbmtzY2FwZTpncm91cG1vZGU9ImxheWVyIgogICAgIGlkPSJsYXllcjEiPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjI7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Im0gNzAsMjUgYyAyMCwwIDI1LDAgMjUsMCIKICAgICAgIGlkPSJwYXRoMzA1OSIKICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2MiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDAwMDtzdHJva2Utd2lkdGg6MjtzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgZD0iTSAzMSwxNSA1LDE1IgogICAgICAgaWQ9InBhdGgzMDYxIiAvPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjEuOTk5OTk5ODg7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Ik0gMzIsMzUgNSwzNSIKICAgICAgIGlkPSJwYXRoMzk0NCIgLz4KICAgIDxnCiAgICAgICBpZD0iZzI1NjAiCiAgICAgICBpbmtzY2FwZTpsYWJlbD0iTGF5ZXIgMSIKICAgICAgIHRyYW5zZm9ybT0idHJhbnNsYXRlKDI2LjUsLTM5LjUpIj4KICAgICAgPHBhdGgKICAgICAgICAgc3R5bGU9ImZpbGw6IzAwMDAwMDtmaWxsLW9wYWNpdHk6MTtmaWxsLXJ1bGU6ZXZlbm9kZDtzdHJva2U6bm9uZTtzdHJva2Utd2lkdGg6MztzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgICBkPSJNIC0yLjQwNjI1LDQ0LjUgTCAtMC40MDYyNSw0Ni45Mzc1IEMgLTAuNDA2MjUsNDYuOTM3NSA1LjI1LDUzLjkzNzU0OSA1LjI1LDY0LjUgQyA1LjI1LDc1LjA2MjQ1MSAtMC40MDYyNSw4Mi4wNjI1IC0wLjQwNjI1LDgyLjA2MjUgTCAtMi40MDYyNSw4NC41IEwgMC43NSw4NC41IEwgMTQuNzUsODQuNSBDIDE3LjE1ODA3Niw4NC41MDAwMDEgMjIuNDM5Njk5LDg0LjUyNDUxNCAyOC4zNzUsODIuMDkzNzUgQyAzNC4zMTAzMDEsNzkuNjYyOTg2IDQwLjkxMTUzNiw3NC43NTA0ODQgNDYuMDYyNSw2NS4yMTg3NSBMIDQ0Ljc1LDY0LjUgTCA0Ni4wNjI1LDYzLjc4MTI1IEMgMzUuNzU5Mzg3LDQ0LjcxNTU5IDE5LjUwNjU3NCw0NC41IDE0Ljc1LDQ0LjUgTCAwLjc1LDQ0LjUgTCAtMi40MDYyNSw0NC41IHogTSAzLjQ2ODc1LDQ3LjUgTCAxNC43NSw0Ny41IEMgMTkuNDM0MTczLDQ3LjUgMzMuMDM2ODUsNDcuMzY5NzkzIDQyLjcxODc1LDY0LjUgQyAzNy45NTE5NjQsNzIuOTI5MDc1IDMyLjE5NzQ2OSw3Ny4xODM5MSAyNyw3OS4zMTI1IEMgMjEuNjM5MzM5LDgxLjUwNzkyNCAxNy4xNTgwNzUsODEuNTAwMDAxIDE0Ljc1LDgxLjUgTCAzLjUsODEuNSBDIDUuMzczNTg4NCw3OC4zOTE1NjYgOC4yNSw3Mi40NTA2NSA4LjI1LDY0LjUgQyA4LjI1LDU2LjUyNjY0NiA1LjM0MTQ2ODYsNTAuNTk5ODE1IDMuNDY4NzUsNDcuNSB6IgogICAgICAgICBpZD0icGF0aDQ5NzMiCiAgICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2NzY2NjY3NjY2NjY2NjY2NzY2NzYyIgLz4KICAgIDwvZz4KICA8L2c+Cjwvc3ZnPgo="
                }
            }
        }, joint.shapes.logic.Gate21.prototype.defaults),
        operation: function(a, b) {
            return a || b
        }
    }), joint.shapes.logic.And = joint.shapes.logic.Gate21.extend({
        defaults: _.defaultsDeep({
            type: "logic.And",
            attrs: {
                image: {
                    "xlink:href": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy8pIC0tPgo8c3ZnCiAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgeG1sbnM6Y2M9Imh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL25zIyIKICAgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIgogICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zOnNvZGlwb2RpPSJodHRwOi8vc29kaXBvZGkuc291cmNlZm9yZ2UubmV0L0RURC9zb2RpcG9kaS0wLmR0ZCIKICAgeG1sbnM6aW5rc2NhcGU9Imh0dHA6Ly93d3cuaW5rc2NhcGUub3JnL25hbWVzcGFjZXMvaW5rc2NhcGUiCiAgIHdpZHRoPSIxMDAiCiAgIGhlaWdodD0iNTAiCiAgIGlkPSJzdmcyIgogICBzb2RpcG9kaTp2ZXJzaW9uPSIwLjMyIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ2IgogICB2ZXJzaW9uPSIxLjAiCiAgIHNvZGlwb2RpOmRvY25hbWU9IkFORCBBTlNJLnN2ZyIKICAgaW5rc2NhcGU6b3V0cHV0X2V4dGVuc2lvbj0ib3JnLmlua3NjYXBlLm91dHB1dC5zdmcuaW5rc2NhcGUiPgogIDxkZWZzCiAgICAgaWQ9ImRlZnM0Ij4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAxNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF96PSI1MCA6IDE1IDogMSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIyNSA6IDEwIDogMSIKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI3MTQiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMC41IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEgOiAwLjUgOiAxIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjAuNSA6IDAuMzMzMzMzMzMgOiAxIgogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgwNiIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgxOSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIzNzIuMDQ3MjQgOiAzNTAuNzg3MzkgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNzQ0LjA5NDQ4IDogNTI2LjE4MTA5IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MjYuMTgxMDkgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjc3NyIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSI3NSA6IDQwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjE1MCA6IDYwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA2MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmUzMjc1IgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjUwIDogMzMuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEwMCA6IDUwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmU1NTMzIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjMyIDogMjEuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjY0IDogMzIgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDMyIDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgPC9kZWZzPgogIDxzb2RpcG9kaTpuYW1lZHZpZXcKICAgICBpZD0iYmFzZSIKICAgICBwYWdlY29sb3I9IiNmZmZmZmYiCiAgICAgYm9yZGVyY29sb3I9IiM2NjY2NjYiCiAgICAgYm9yZGVyb3BhY2l0eT0iMS4wIgogICAgIGlua3NjYXBlOnBhZ2VvcGFjaXR5PSIwLjAiCiAgICAgaW5rc2NhcGU6cGFnZXNoYWRvdz0iMiIKICAgICBpbmtzY2FwZTp6b29tPSI4IgogICAgIGlua3NjYXBlOmN4PSI1Ni42OTgzNDgiCiAgICAgaW5rc2NhcGU6Y3k9IjI1LjMyNjg5OSIKICAgICBpbmtzY2FwZTpkb2N1bWVudC11bml0cz0icHgiCiAgICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ibGF5ZXIxIgogICAgIHNob3dncmlkPSJ0cnVlIgogICAgIGlua3NjYXBlOmdyaWQtYmJveD0idHJ1ZSIKICAgICBpbmtzY2FwZTpncmlkLXBvaW50cz0idHJ1ZSIKICAgICBncmlkdG9sZXJhbmNlPSIxMDAwMCIKICAgICBpbmtzY2FwZTp3aW5kb3ctd2lkdGg9IjEzOTkiCiAgICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iODc0IgogICAgIGlua3NjYXBlOndpbmRvdy14PSIzMyIKICAgICBpbmtzY2FwZTp3aW5kb3cteT0iMCIKICAgICBpbmtzY2FwZTpzbmFwLWJib3g9InRydWUiPgogICAgPGlua3NjYXBlOmdyaWQKICAgICAgIGlkPSJHcmlkRnJvbVByZTA0NlNldHRpbmdzIgogICAgICAgdHlwZT0ieHlncmlkIgogICAgICAgb3JpZ2lueD0iMHB4IgogICAgICAgb3JpZ2lueT0iMHB4IgogICAgICAgc3BhY2luZ3g9IjFweCIKICAgICAgIHNwYWNpbmd5PSIxcHgiCiAgICAgICBjb2xvcj0iIzAwMDBmZiIKICAgICAgIGVtcGNvbG9yPSIjMDAwMGZmIgogICAgICAgb3BhY2l0eT0iMC4yIgogICAgICAgZW1wb3BhY2l0eT0iMC40IgogICAgICAgZW1wc3BhY2luZz0iNSIKICAgICAgIHZpc2libGU9InRydWUiCiAgICAgICBlbmFibGVkPSJ0cnVlIiAvPgogIDwvc29kaXBvZGk6bmFtZWR2aWV3PgogIDxtZXRhZGF0YQogICAgIGlkPSJtZXRhZGF0YTciPgogICAgPHJkZjpSREY+CiAgICAgIDxjYzpXb3JrCiAgICAgICAgIHJkZjphYm91dD0iIj4KICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD4KICAgICAgICA8ZGM6dHlwZQogICAgICAgICAgIHJkZjpyZXNvdXJjZT0iaHR0cDovL3B1cmwub3JnL2RjL2RjbWl0eXBlL1N0aWxsSW1hZ2UiIC8+CiAgICAgIDwvY2M6V29yaz4KICAgIDwvcmRmOlJERj4KICA8L21ldGFkYXRhPgogIDxnCiAgICAgaW5rc2NhcGU6bGFiZWw9IkxheWVyIDEiCiAgICAgaW5rc2NhcGU6Z3JvdXBtb2RlPSJsYXllciIKICAgICBpZD0ibGF5ZXIxIj4KICAgIDxwYXRoCiAgICAgICBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDoyO3N0cm9rZS1saW5lY2FwOmJ1dHQ7c3Ryb2tlLWxpbmVqb2luOm1pdGVyO3N0cm9rZS1vcGFjaXR5OjEiCiAgICAgICBkPSJtIDcwLDI1IGMgMjAsMCAyNSwwIDI1LDAiCiAgICAgICBpZD0icGF0aDMwNTkiCiAgICAgICBzb2RpcG9kaTpub2RldHlwZXM9ImNjIiAvPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjI7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Ik0gMzEsMTUgNSwxNSIKICAgICAgIGlkPSJwYXRoMzA2MSIgLz4KICAgIDxwYXRoCiAgICAgICBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDoxLjk5OTk5OTg4O3N0cm9rZS1saW5lY2FwOmJ1dHQ7c3Ryb2tlLWxpbmVqb2luOm1pdGVyO3N0cm9rZS1vcGFjaXR5OjEiCiAgICAgICBkPSJNIDMyLDM1IDUsMzUiCiAgICAgICBpZD0icGF0aDM5NDQiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZvbnQtc2l6ZTptZWRpdW07Zm9udC1zdHlsZTpub3JtYWw7Zm9udC12YXJpYW50Om5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7Zm9udC1zdHJldGNoOm5vcm1hbDt0ZXh0LWluZGVudDowO3RleHQtYWxpZ246c3RhcnQ7dGV4dC1kZWNvcmF0aW9uOm5vbmU7bGluZS1oZWlnaHQ6bm9ybWFsO2xldHRlci1zcGFjaW5nOm5vcm1hbDt3b3JkLXNwYWNpbmc6bm9ybWFsO3RleHQtdHJhbnNmb3JtOm5vbmU7ZGlyZWN0aW9uOmx0cjtibG9jay1wcm9ncmVzc2lvbjp0Yjt3cml0aW5nLW1vZGU6bHItdGI7dGV4dC1hbmNob3I6c3RhcnQ7ZmlsbDojMDAwMDAwO2ZpbGwtb3BhY2l0eToxO3N0cm9rZTpub25lO3N0cm9rZS13aWR0aDozO21hcmtlcjpub25lO3Zpc2liaWxpdHk6dmlzaWJsZTtkaXNwbGF5OmlubGluZTtvdmVyZmxvdzp2aXNpYmxlO2VuYWJsZS1iYWNrZ3JvdW5kOmFjY3VtdWxhdGU7Zm9udC1mYW1pbHk6Qml0c3RyZWFtIFZlcmEgU2FuczstaW5rc2NhcGUtZm9udC1zcGVjaWZpY2F0aW9uOkJpdHN0cmVhbSBWZXJhIFNhbnMiCiAgICAgICBkPSJNIDMwLDUgTCAzMCw2LjQyODU3MTQgTCAzMCw0My41NzE0MjkgTCAzMCw0NSBMIDMxLjQyODU3MSw0NSBMIDUwLjQ3NjE5LDQ1IEMgNjEuNzQ0MDk4LDQ1IDcwLjQ3NjE5LDM1Ljk5OTk1NSA3MC40NzYxOSwyNSBDIDcwLjQ3NjE5LDE0LjAwMDA0NSA2MS43NDQwOTksNS4wMDAwMDAyIDUwLjQ3NjE5LDUgQyA1MC40NzYxOSw1IDUwLjQ3NjE5LDUgMzEuNDI4NTcxLDUgTCAzMCw1IHogTSAzMi44NTcxNDMsNy44NTcxNDI5IEMgNDAuODM0MjY0LDcuODU3MTQyOSA0NS45MTgzNjgsNy44NTcxNDI5IDQ4LjA5NTIzOCw3Ljg1NzE0MjkgQyA0OS4yODU3MTQsNy44NTcxNDI5IDQ5Ljg4MDk1Miw3Ljg1NzE0MjkgNTAuMTc4NTcxLDcuODU3MTQyOSBDIDUwLjMyNzM4MSw3Ljg1NzE0MjkgNTAuNDA5MjI3LDcuODU3MTQyOSA1MC40NDY0MjksNy44NTcxNDI5IEMgNTAuNDY1MDI5LDcuODU3MTQyOSA1MC40NzE1NDMsNy44NTcxNDI5IDUwLjQ3NjE5LDcuODU3MTQyOSBDIDYwLjIzNjg1Myw3Ljg1NzE0MyA2Ny4xNDI4NTcsMTUuNDk3MDk4IDY3LjE0Mjg1NywyNSBDIDY3LjE0Mjg1NywzNC41MDI5MDIgNTkuNzYwNjYyLDQyLjE0Mjg1NyA1MCw0Mi4xNDI4NTcgTCAzMi44NTcxNDMsNDIuMTQyODU3IEwgMzIuODU3MTQzLDcuODU3MTQyOSB6IgogICAgICAgaWQ9InBhdGgyODg0IgogICAgICAgc29kaXBvZGk6bm9kZXR5cGVzPSJjY2NjY2NzY2NjY3Nzc3NzY2NjIiAvPgogIDwvZz4KPC9zdmc+Cg=="
                }
            }
        }, joint.shapes.logic.Gate21.prototype.defaults),
        operation: function(a, b) {
            return a && b
        }
    }), joint.shapes.logic.Nor = joint.shapes.logic.Gate21.extend({
        defaults: _.defaultsDeep({
            type: "logic.Nor",
            attrs: {
                image: {
                    "xlink:href": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy8pIC0tPgo8c3ZnCiAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgeG1sbnM6Y2M9Imh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL25zIyIKICAgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIgogICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zOnNvZGlwb2RpPSJodHRwOi8vc29kaXBvZGkuc291cmNlZm9yZ2UubmV0L0RURC9zb2RpcG9kaS0wLmR0ZCIKICAgeG1sbnM6aW5rc2NhcGU9Imh0dHA6Ly93d3cuaW5rc2NhcGUub3JnL25hbWVzcGFjZXMvaW5rc2NhcGUiCiAgIHdpZHRoPSIxMDAiCiAgIGhlaWdodD0iNTAiCiAgIGlkPSJzdmcyIgogICBzb2RpcG9kaTp2ZXJzaW9uPSIwLjMyIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ2IgogICB2ZXJzaW9uPSIxLjAiCiAgIHNvZGlwb2RpOmRvY25hbWU9Ik5PUiBBTlNJLnN2ZyIKICAgaW5rc2NhcGU6b3V0cHV0X2V4dGVuc2lvbj0ib3JnLmlua3NjYXBlLm91dHB1dC5zdmcuaW5rc2NhcGUiPgogIDxkZWZzCiAgICAgaWQ9ImRlZnM0Ij4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAxNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF96PSI1MCA6IDE1IDogMSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIyNSA6IDEwIDogMSIKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI3MTQiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMC41IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEgOiAwLjUgOiAxIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjAuNSA6IDAuMzMzMzMzMzMgOiAxIgogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgwNiIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgxOSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIzNzIuMDQ3MjQgOiAzNTAuNzg3MzkgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNzQ0LjA5NDQ4IDogNTI2LjE4MTA5IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MjYuMTgxMDkgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjc3NyIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSI3NSA6IDQwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjE1MCA6IDYwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA2MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmUzMjc1IgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjUwIDogMzMuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEwMCA6IDUwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmU1NTMzIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjMyIDogMjEuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjY0IDogMzIgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDMyIDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI1NTciCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMjUgOiAxNi42NjY2NjcgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNTAgOiAyNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMjUgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICA8L2RlZnM+CiAgPHNvZGlwb2RpOm5hbWVkdmlldwogICAgIGlkPSJiYXNlIgogICAgIHBhZ2Vjb2xvcj0iI2ZmZmZmZiIKICAgICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgICBib3JkZXJvcGFjaXR5PSIxLjAiCiAgICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAuMCIKICAgICBpbmtzY2FwZTpwYWdlc2hhZG93PSIyIgogICAgIGlua3NjYXBlOnpvb209IjEiCiAgICAgaW5rc2NhcGU6Y3g9Ijc4LjY3NzY0NCIKICAgICBpbmtzY2FwZTpjeT0iMjIuMTAyMzQ0IgogICAgIGlua3NjYXBlOmRvY3VtZW50LXVuaXRzPSJweCIKICAgICBpbmtzY2FwZTpjdXJyZW50LWxheWVyPSJsYXllcjEiCiAgICAgc2hvd2dyaWQ9InRydWUiCiAgICAgaW5rc2NhcGU6Z3JpZC1iYm94PSJ0cnVlIgogICAgIGlua3NjYXBlOmdyaWQtcG9pbnRzPSJ0cnVlIgogICAgIGdyaWR0b2xlcmFuY2U9IjEwMDAwIgogICAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTM5OSIKICAgICBpbmtzY2FwZTp3aW5kb3ctaGVpZ2h0PSI4NzQiCiAgICAgaW5rc2NhcGU6d2luZG93LXg9IjM3IgogICAgIGlua3NjYXBlOndpbmRvdy15PSItNCIKICAgICBpbmtzY2FwZTpzbmFwLWJib3g9InRydWUiPgogICAgPGlua3NjYXBlOmdyaWQKICAgICAgIGlkPSJHcmlkRnJvbVByZTA0NlNldHRpbmdzIgogICAgICAgdHlwZT0ieHlncmlkIgogICAgICAgb3JpZ2lueD0iMHB4IgogICAgICAgb3JpZ2lueT0iMHB4IgogICAgICAgc3BhY2luZ3g9IjFweCIKICAgICAgIHNwYWNpbmd5PSIxcHgiCiAgICAgICBjb2xvcj0iIzAwMDBmZiIKICAgICAgIGVtcGNvbG9yPSIjMDAwMGZmIgogICAgICAgb3BhY2l0eT0iMC4yIgogICAgICAgZW1wb3BhY2l0eT0iMC40IgogICAgICAgZW1wc3BhY2luZz0iNSIKICAgICAgIHZpc2libGU9InRydWUiCiAgICAgICBlbmFibGVkPSJ0cnVlIiAvPgogIDwvc29kaXBvZGk6bmFtZWR2aWV3PgogIDxtZXRhZGF0YQogICAgIGlkPSJtZXRhZGF0YTciPgogICAgPHJkZjpSREY+CiAgICAgIDxjYzpXb3JrCiAgICAgICAgIHJkZjphYm91dD0iIj4KICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD4KICAgICAgICA8ZGM6dHlwZQogICAgICAgICAgIHJkZjpyZXNvdXJjZT0iaHR0cDovL3B1cmwub3JnL2RjL2RjbWl0eXBlL1N0aWxsSW1hZ2UiIC8+CiAgICAgIDwvY2M6V29yaz4KICAgIDwvcmRmOlJERj4KICA8L21ldGFkYXRhPgogIDxnCiAgICAgaW5rc2NhcGU6bGFiZWw9IkxheWVyIDEiCiAgICAgaW5rc2NhcGU6Z3JvdXBtb2RlPSJsYXllciIKICAgICBpZD0ibGF5ZXIxIj4KICAgIDxwYXRoCiAgICAgICBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDoyO3N0cm9rZS1saW5lY2FwOmJ1dHQ7c3Ryb2tlLWxpbmVqb2luOm1pdGVyO3N0cm9rZS1vcGFjaXR5OjEiCiAgICAgICBkPSJNIDc5LDI1IEMgOTksMjUgOTUsMjUgOTUsMjUiCiAgICAgICBpZD0icGF0aDMwNTkiCiAgICAgICBzb2RpcG9kaTpub2RldHlwZXM9ImNjIiAvPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjI7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Ik0gMzEsMTUgNSwxNSIKICAgICAgIGlkPSJwYXRoMzA2MSIgLz4KICAgIDxwYXRoCiAgICAgICBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDoxLjk5OTk5OTg4O3N0cm9rZS1saW5lY2FwOmJ1dHQ7c3Ryb2tlLWxpbmVqb2luOm1pdGVyO3N0cm9rZS1vcGFjaXR5OjEiCiAgICAgICBkPSJNIDMyLDM1IDUsMzUiCiAgICAgICBpZD0icGF0aDM5NDQiIC8+CiAgICA8ZwogICAgICAgaWQ9ImcyNTYwIgogICAgICAgaW5rc2NhcGU6bGFiZWw9IkxheWVyIDEiCiAgICAgICB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyNi41LC0zOS41KSI+CiAgICAgIDxwYXRoCiAgICAgICAgIHN0eWxlPSJmaWxsOiMwMDAwMDA7ZmlsbC1vcGFjaXR5OjE7ZmlsbC1ydWxlOmV2ZW5vZGQ7c3Ryb2tlOm5vbmU7c3Ryb2tlLXdpZHRoOjM7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgICAgZD0iTSAtMi40MDYyNSw0NC41IEwgLTAuNDA2MjUsNDYuOTM3NSBDIC0wLjQwNjI1LDQ2LjkzNzUgNS4yNSw1My45Mzc1NDkgNS4yNSw2NC41IEMgNS4yNSw3NS4wNjI0NTEgLTAuNDA2MjUsODIuMDYyNSAtMC40MDYyNSw4Mi4wNjI1IEwgLTIuNDA2MjUsODQuNSBMIDAuNzUsODQuNSBMIDE0Ljc1LDg0LjUgQyAxNy4xNTgwNzYsODQuNTAwMDAxIDIyLjQzOTY5OSw4NC41MjQ1MTQgMjguMzc1LDgyLjA5Mzc1IEMgMzQuMzEwMzAxLDc5LjY2Mjk4NiA0MC45MTE1MzYsNzQuNzUwNDg0IDQ2LjA2MjUsNjUuMjE4NzUgTCA0NC43NSw2NC41IEwgNDYuMDYyNSw2My43ODEyNSBDIDM1Ljc1OTM4Nyw0NC43MTU1OSAxOS41MDY1NzQsNDQuNSAxNC43NSw0NC41IEwgMC43NSw0NC41IEwgLTIuNDA2MjUsNDQuNSB6IE0gMy40Njg3NSw0Ny41IEwgMTQuNzUsNDcuNSBDIDE5LjQzNDE3Myw0Ny41IDMzLjAzNjg1LDQ3LjM2OTc5MyA0Mi43MTg3NSw2NC41IEMgMzcuOTUxOTY0LDcyLjkyOTA3NSAzMi4xOTc0NjksNzcuMTgzOTEgMjcsNzkuMzEyNSBDIDIxLjYzOTMzOSw4MS41MDc5MjQgMTcuMTU4MDc1LDgxLjUwMDAwMSAxNC43NSw4MS41IEwgMy41LDgxLjUgQyA1LjM3MzU4ODQsNzguMzkxNTY2IDguMjUsNzIuNDUwNjUgOC4yNSw2NC41IEMgOC4yNSw1Ni41MjY2NDYgNS4zNDE0Njg2LDUwLjU5OTgxNSAzLjQ2ODc1LDQ3LjUgeiIKICAgICAgICAgaWQ9InBhdGg0OTczIgogICAgICAgICBzb2RpcG9kaTpub2RldHlwZXM9ImNjc2NjY2NzY2NjY2NjY2Njc2Njc2MiIC8+CiAgICAgIDxwYXRoCiAgICAgICAgIHNvZGlwb2RpOnR5cGU9ImFyYyIKICAgICAgICAgc3R5bGU9ImZpbGw6bm9uZTtmaWxsLW9wYWNpdHk6MTtzdHJva2U6IzAwMDAwMDtzdHJva2Utd2lkdGg6MztzdHJva2UtbGluZWpvaW46bWl0ZXI7bWFya2VyOm5vbmU7c3Ryb2tlLW9wYWNpdHk6MTt2aXNpYmlsaXR5OnZpc2libGU7ZGlzcGxheTppbmxpbmU7b3ZlcmZsb3c6dmlzaWJsZTtlbmFibGUtYmFja2dyb3VuZDphY2N1bXVsYXRlIgogICAgICAgICBpZD0icGF0aDI2MDQiCiAgICAgICAgIHNvZGlwb2RpOmN4PSI3NSIKICAgICAgICAgc29kaXBvZGk6Y3k9IjI1IgogICAgICAgICBzb2RpcG9kaTpyeD0iNCIKICAgICAgICAgc29kaXBvZGk6cnk9IjQiCiAgICAgICAgIGQ9Ik0gNzksMjUgQSA0LDQgMCAxIDEgNzEsMjUgQSA0LDQgMCAxIDEgNzksMjUgeiIKICAgICAgICAgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTI2LjUsMzkuNSkiIC8+CiAgICA8L2c+CiAgPC9nPgo8L3N2Zz4K"
                }
            }
        }, joint.shapes.logic.Gate21.prototype.defaults),
        operation: function(a, b) {
            return !(a || b)
        }
    }), joint.shapes.logic.Nand = joint.shapes.logic.Gate21.extend({
        defaults: _.defaultsDeep({
            type: "logic.Nand",
            attrs: {
                image: {
                    "xlink:href": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy8pIC0tPgo8c3ZnCiAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgeG1sbnM6Y2M9Imh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL25zIyIKICAgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIgogICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zOnNvZGlwb2RpPSJodHRwOi8vc29kaXBvZGkuc291cmNlZm9yZ2UubmV0L0RURC9zb2RpcG9kaS0wLmR0ZCIKICAgeG1sbnM6aW5rc2NhcGU9Imh0dHA6Ly93d3cuaW5rc2NhcGUub3JnL25hbWVzcGFjZXMvaW5rc2NhcGUiCiAgIHdpZHRoPSIxMDAiCiAgIGhlaWdodD0iNTAiCiAgIGlkPSJzdmcyIgogICBzb2RpcG9kaTp2ZXJzaW9uPSIwLjMyIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ2IgogICB2ZXJzaW9uPSIxLjAiCiAgIHNvZGlwb2RpOmRvY25hbWU9Ik5BTkQgQU5TSS5zdmciCiAgIGlua3NjYXBlOm91dHB1dF9leHRlbnNpb249Im9yZy5pbmtzY2FwZS5vdXRwdXQuc3ZnLmlua3NjYXBlIj4KICA8ZGVmcwogICAgIGlkPSJkZWZzNCI+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMTUgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfej0iNTAgOiAxNSA6IDEiCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMjUgOiAxMCA6IDEiCiAgICAgICBpZD0icGVyc3BlY3RpdmUyNzE0IiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDAuNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF96PSIxIDogMC41IDogMSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIwLjUgOiAwLjMzMzMzMzMzIDogMSIKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI4MDYiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI4MTkiCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMzcyLjA0NzI0IDogMzUwLjc4NzM5IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9Ijc0NC4wOTQ0OCA6IDUyNi4xODEwOSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogNTI2LjE4MTA5IDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI3NzciCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iNzUgOiA0MCA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF96PSIxNTAgOiA2MCA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogNjAgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMzI3NSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSI1MCA6IDMzLjMzMzMzMyA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF96PSIxMDAgOiA1MCA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogNTAgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlNTUzMyIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIzMiA6IDIxLjMzMzMzMyA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF96PSI2NCA6IDMyIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAzMiA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogIDwvZGVmcz4KICA8c29kaXBvZGk6bmFtZWR2aWV3CiAgICAgaWQ9ImJhc2UiCiAgICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICAgIGJvcmRlcmNvbG9yPSIjNjY2NjY2IgogICAgIGJvcmRlcm9wYWNpdHk9IjEuMCIKICAgICBpbmtzY2FwZTpwYWdlb3BhY2l0eT0iMC4wIgogICAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgICAgaW5rc2NhcGU6em9vbT0iMTYiCiAgICAgaW5rc2NhcGU6Y3g9Ijc4LjI4MzMwNyIKICAgICBpbmtzY2FwZTpjeT0iMTYuNDQyODQzIgogICAgIGlua3NjYXBlOmRvY3VtZW50LXVuaXRzPSJweCIKICAgICBpbmtzY2FwZTpjdXJyZW50LWxheWVyPSJsYXllcjEiCiAgICAgc2hvd2dyaWQ9InRydWUiCiAgICAgaW5rc2NhcGU6Z3JpZC1iYm94PSJ0cnVlIgogICAgIGlua3NjYXBlOmdyaWQtcG9pbnRzPSJ0cnVlIgogICAgIGdyaWR0b2xlcmFuY2U9IjEwMDAwIgogICAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTM5OSIKICAgICBpbmtzY2FwZTp3aW5kb3ctaGVpZ2h0PSI4NzQiCiAgICAgaW5rc2NhcGU6d2luZG93LXg9IjMzIgogICAgIGlua3NjYXBlOndpbmRvdy15PSIwIgogICAgIGlua3NjYXBlOnNuYXAtYmJveD0idHJ1ZSI+CiAgICA8aW5rc2NhcGU6Z3JpZAogICAgICAgaWQ9IkdyaWRGcm9tUHJlMDQ2U2V0dGluZ3MiCiAgICAgICB0eXBlPSJ4eWdyaWQiCiAgICAgICBvcmlnaW54PSIwcHgiCiAgICAgICBvcmlnaW55PSIwcHgiCiAgICAgICBzcGFjaW5neD0iMXB4IgogICAgICAgc3BhY2luZ3k9IjFweCIKICAgICAgIGNvbG9yPSIjMDAwMGZmIgogICAgICAgZW1wY29sb3I9IiMwMDAwZmYiCiAgICAgICBvcGFjaXR5PSIwLjIiCiAgICAgICBlbXBvcGFjaXR5PSIwLjQiCiAgICAgICBlbXBzcGFjaW5nPSI1IgogICAgICAgdmlzaWJsZT0idHJ1ZSIKICAgICAgIGVuYWJsZWQ9InRydWUiIC8+CiAgPC9zb2RpcG9kaTpuYW1lZHZpZXc+CiAgPG1ldGFkYXRhCiAgICAgaWQ9Im1ldGFkYXRhNyI+CiAgICA8cmRmOlJERj4KICAgICAgPGNjOldvcmsKICAgICAgICAgcmRmOmFib3V0PSIiPgogICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2Uvc3ZnK3htbDwvZGM6Zm9ybWF0PgogICAgICAgIDxkYzp0eXBlCiAgICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz4KICAgICAgPC9jYzpXb3JrPgogICAgPC9yZGY6UkRGPgogIDwvbWV0YWRhdGE+CiAgPGcKICAgICBpbmtzY2FwZTpsYWJlbD0iTGF5ZXIgMSIKICAgICBpbmtzY2FwZTpncm91cG1vZGU9ImxheWVyIgogICAgIGlkPSJsYXllcjEiPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjI7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Ik0gNzksMjUgQyA5MS44LDI1IDk1LDI1IDk1LDI1IgogICAgICAgaWQ9InBhdGgzMDU5IgogICAgICAgc29kaXBvZGk6bm9kZXR5cGVzPSJjYyIgLz4KICAgIDxwYXRoCiAgICAgICBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDoyO3N0cm9rZS1saW5lY2FwOmJ1dHQ7c3Ryb2tlLWxpbmVqb2luOm1pdGVyO3N0cm9rZS1vcGFjaXR5OjEiCiAgICAgICBkPSJNIDMxLDE1IDUsMTUiCiAgICAgICBpZD0icGF0aDMwNjEiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDAwMDtzdHJva2Utd2lkdGg6MS45OTk5OTk4ODtzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgZD0iTSAzMiwzNSA1LDM1IgogICAgICAgaWQ9InBhdGgzOTQ0IiAvPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmb250LXNpemU6bWVkaXVtO2ZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtdmFyaWFudDpub3JtYWw7Zm9udC13ZWlnaHQ6bm9ybWFsO2ZvbnQtc3RyZXRjaDpub3JtYWw7dGV4dC1pbmRlbnQ6MDt0ZXh0LWFsaWduOnN0YXJ0O3RleHQtZGVjb3JhdGlvbjpub25lO2xpbmUtaGVpZ2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzpub3JtYWw7d29yZC1zcGFjaW5nOm5vcm1hbDt0ZXh0LXRyYW5zZm9ybTpub25lO2RpcmVjdGlvbjpsdHI7YmxvY2stcHJvZ3Jlc3Npb246dGI7d3JpdGluZy1tb2RlOmxyLXRiO3RleHQtYW5jaG9yOnN0YXJ0O2ZpbGw6IzAwMDAwMDtmaWxsLW9wYWNpdHk6MTtzdHJva2U6bm9uZTtzdHJva2Utd2lkdGg6MzttYXJrZXI6bm9uZTt2aXNpYmlsaXR5OnZpc2libGU7ZGlzcGxheTppbmxpbmU7b3ZlcmZsb3c6dmlzaWJsZTtlbmFibGUtYmFja2dyb3VuZDphY2N1bXVsYXRlO2ZvbnQtZmFtaWx5OkJpdHN0cmVhbSBWZXJhIFNhbnM7LWlua3NjYXBlLWZvbnQtc3BlY2lmaWNhdGlvbjpCaXRzdHJlYW0gVmVyYSBTYW5zIgogICAgICAgZD0iTSAzMCw1IEwgMzAsNi40Mjg1NzE0IEwgMzAsNDMuNTcxNDI5IEwgMzAsNDUgTCAzMS40Mjg1NzEsNDUgTCA1MC40NzYxOSw0NSBDIDYxLjc0NDA5OCw0NSA3MC40NzYxOSwzNS45OTk5NTUgNzAuNDc2MTksMjUgQyA3MC40NzYxOSwxNC4wMDAwNDUgNjEuNzQ0MDk5LDUuMDAwMDAwMiA1MC40NzYxOSw1IEMgNTAuNDc2MTksNSA1MC40NzYxOSw1IDMxLjQyODU3MSw1IEwgMzAsNSB6IE0gMzIuODU3MTQzLDcuODU3MTQyOSBDIDQwLjgzNDI2NCw3Ljg1NzE0MjkgNDUuOTE4MzY4LDcuODU3MTQyOSA0OC4wOTUyMzgsNy44NTcxNDI5IEMgNDkuMjg1NzE0LDcuODU3MTQyOSA0OS44ODA5NTIsNy44NTcxNDI5IDUwLjE3ODU3MSw3Ljg1NzE0MjkgQyA1MC4zMjczODEsNy44NTcxNDI5IDUwLjQwOTIyNyw3Ljg1NzE0MjkgNTAuNDQ2NDI5LDcuODU3MTQyOSBDIDUwLjQ2NTAyOSw3Ljg1NzE0MjkgNTAuNDcxNTQzLDcuODU3MTQyOSA1MC40NzYxOSw3Ljg1NzE0MjkgQyA2MC4yMzY4NTMsNy44NTcxNDMgNjcuMTQyODU3LDE1LjQ5NzA5OCA2Ny4xNDI4NTcsMjUgQyA2Ny4xNDI4NTcsMzQuNTAyOTAyIDU5Ljc2MDY2Miw0Mi4xNDI4NTcgNTAsNDIuMTQyODU3IEwgMzIuODU3MTQzLDQyLjE0Mjg1NyBMIDMyLjg1NzE0Myw3Ljg1NzE0MjkgeiIKICAgICAgIGlkPSJwYXRoMjg4NCIKICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2NjY2Njc2NjY2Nzc3Nzc2NjYyIgLz4KICAgIDxwYXRoCiAgICAgICBzb2RpcG9kaTp0eXBlPSJhcmMiCiAgICAgICBzdHlsZT0iZmlsbDpub25lO2ZpbGwtb3BhY2l0eToxO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDozO3N0cm9rZS1saW5lam9pbjptaXRlcjttYXJrZXI6bm9uZTtzdHJva2Utb3BhY2l0eToxO3Zpc2liaWxpdHk6dmlzaWJsZTtkaXNwbGF5OmlubGluZTtvdmVyZmxvdzp2aXNpYmxlO2VuYWJsZS1iYWNrZ3JvdW5kOmFjY3VtdWxhdGUiCiAgICAgICBpZD0icGF0aDQwMDgiCiAgICAgICBzb2RpcG9kaTpjeD0iNzUiCiAgICAgICBzb2RpcG9kaTpjeT0iMjUiCiAgICAgICBzb2RpcG9kaTpyeD0iNCIKICAgICAgIHNvZGlwb2RpOnJ5PSI0IgogICAgICAgZD0iTSA3OSwyNSBBIDQsNCAwIDEgMSA3MSwyNSBBIDQsNCAwIDEgMSA3OSwyNSB6IiAvPgogIDwvZz4KPC9zdmc+Cg=="
                }
            }
        }, joint.shapes.logic.Gate21.prototype.defaults),
        operation: function(a, b) {
            return !(a && b)
        }
    }), joint.shapes.logic.Xor = joint.shapes.logic.Gate21.extend({
        defaults: _.defaultsDeep({
            type: "logic.Xor",
            attrs: {
                image: {
                    "xlink:href": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy8pIC0tPgo8c3ZnCiAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgeG1sbnM6Y2M9Imh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL25zIyIKICAgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIgogICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zOnNvZGlwb2RpPSJodHRwOi8vc29kaXBvZGkuc291cmNlZm9yZ2UubmV0L0RURC9zb2RpcG9kaS0wLmR0ZCIKICAgeG1sbnM6aW5rc2NhcGU9Imh0dHA6Ly93d3cuaW5rc2NhcGUub3JnL25hbWVzcGFjZXMvaW5rc2NhcGUiCiAgIHdpZHRoPSIxMDAiCiAgIGhlaWdodD0iNTAiCiAgIGlkPSJzdmcyIgogICBzb2RpcG9kaTp2ZXJzaW9uPSIwLjMyIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ2IgogICB2ZXJzaW9uPSIxLjAiCiAgIHNvZGlwb2RpOmRvY25hbWU9IlhPUiBBTlNJLnN2ZyIKICAgaW5rc2NhcGU6b3V0cHV0X2V4dGVuc2lvbj0ib3JnLmlua3NjYXBlLm91dHB1dC5zdmcuaW5rc2NhcGUiPgogIDxkZWZzCiAgICAgaWQ9ImRlZnM0Ij4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAxNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF96PSI1MCA6IDE1IDogMSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIyNSA6IDEwIDogMSIKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI3MTQiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMC41IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEgOiAwLjUgOiAxIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjAuNSA6IDAuMzMzMzMzMzMgOiAxIgogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgwNiIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjgxOSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIzNzIuMDQ3MjQgOiAzNTAuNzg3MzkgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNzQ0LjA5NDQ4IDogNTI2LjE4MTA5IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MjYuMTgxMDkgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMjc3NyIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSI3NSA6IDQwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjE1MCA6IDYwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA2MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmUzMjc1IgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjUwIDogMzMuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjEwMCA6IDUwIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiA1MCA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmU1NTMzIgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjMyIDogMjEuMzMzMzMzIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjY0IDogMzIgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDMyIDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI1NTciCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMjUgOiAxNi42NjY2NjcgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfej0iNTAgOiAyNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMjUgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICA8L2RlZnM+CiAgPHNvZGlwb2RpOm5hbWVkdmlldwogICAgIGlkPSJiYXNlIgogICAgIHBhZ2Vjb2xvcj0iI2ZmZmZmZiIKICAgICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgICBib3JkZXJvcGFjaXR5PSIxLjAiCiAgICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAuMCIKICAgICBpbmtzY2FwZTpwYWdlc2hhZG93PSIyIgogICAgIGlua3NjYXBlOnpvb209IjUuNjU2ODU0MiIKICAgICBpbmtzY2FwZTpjeD0iMjUuOTM4MTE2IgogICAgIGlua3NjYXBlOmN5PSIxNy4yMzAwNSIKICAgICBpbmtzY2FwZTpkb2N1bWVudC11bml0cz0icHgiCiAgICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ibGF5ZXIxIgogICAgIHNob3dncmlkPSJ0cnVlIgogICAgIGlua3NjYXBlOmdyaWQtYmJveD0idHJ1ZSIKICAgICBpbmtzY2FwZTpncmlkLXBvaW50cz0idHJ1ZSIKICAgICBncmlkdG9sZXJhbmNlPSIxMDAwMCIKICAgICBpbmtzY2FwZTp3aW5kb3ctd2lkdGg9IjEzOTkiCiAgICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iODc0IgogICAgIGlua3NjYXBlOndpbmRvdy14PSIzMyIKICAgICBpbmtzY2FwZTp3aW5kb3cteT0iMCIKICAgICBpbmtzY2FwZTpzbmFwLWJib3g9InRydWUiPgogICAgPGlua3NjYXBlOmdyaWQKICAgICAgIGlkPSJHcmlkRnJvbVByZTA0NlNldHRpbmdzIgogICAgICAgdHlwZT0ieHlncmlkIgogICAgICAgb3JpZ2lueD0iMHB4IgogICAgICAgb3JpZ2lueT0iMHB4IgogICAgICAgc3BhY2luZ3g9IjFweCIKICAgICAgIHNwYWNpbmd5PSIxcHgiCiAgICAgICBjb2xvcj0iIzAwMDBmZiIKICAgICAgIGVtcGNvbG9yPSIjMDAwMGZmIgogICAgICAgb3BhY2l0eT0iMC4yIgogICAgICAgZW1wb3BhY2l0eT0iMC40IgogICAgICAgZW1wc3BhY2luZz0iNSIKICAgICAgIHZpc2libGU9InRydWUiCiAgICAgICBlbmFibGVkPSJ0cnVlIiAvPgogIDwvc29kaXBvZGk6bmFtZWR2aWV3PgogIDxtZXRhZGF0YQogICAgIGlkPSJtZXRhZGF0YTciPgogICAgPHJkZjpSREY+CiAgICAgIDxjYzpXb3JrCiAgICAgICAgIHJkZjphYm91dD0iIj4KICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD4KICAgICAgICA8ZGM6dHlwZQogICAgICAgICAgIHJkZjpyZXNvdXJjZT0iaHR0cDovL3B1cmwub3JnL2RjL2RjbWl0eXBlL1N0aWxsSW1hZ2UiIC8+CiAgICAgIDwvY2M6V29yaz4KICAgIDwvcmRmOlJERj4KICA8L21ldGFkYXRhPgogIDxnCiAgICAgaW5rc2NhcGU6bGFiZWw9IkxheWVyIDEiCiAgICAgaW5rc2NhcGU6Z3JvdXBtb2RlPSJsYXllciIKICAgICBpZD0ibGF5ZXIxIj4KICAgIDxwYXRoCiAgICAgICBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDoyO3N0cm9rZS1saW5lY2FwOmJ1dHQ7c3Ryb2tlLWxpbmVqb2luOm1pdGVyO3N0cm9rZS1vcGFjaXR5OjEiCiAgICAgICBkPSJtIDcwLDI1IGMgMjAsMCAyNSwwIDI1LDAiCiAgICAgICBpZD0icGF0aDMwNTkiCiAgICAgICBzb2RpcG9kaTpub2RldHlwZXM9ImNjIiAvPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjEuOTk5OTk5ODg7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Ik0gMzAuMzg1NzE3LDE1IEwgNC45OTk5OTk4LDE1IgogICAgICAgaWQ9InBhdGgzMDYxIiAvPgogICAgPHBhdGgKICAgICAgIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjEuOTk5OTk5NzY7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgIGQ9Ik0gMzEuMzYyMDkxLDM1IEwgNC45OTk5OTk4LDM1IgogICAgICAgaWQ9InBhdGgzOTQ0IiAvPgogICAgPGcKICAgICAgIGlkPSJnMjU2MCIKICAgICAgIGlua3NjYXBlOmxhYmVsPSJMYXllciAxIgogICAgICAgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjYuNSwtMzkuNSkiPgogICAgICA8cGF0aAogICAgICAgICBpZD0icGF0aDM1MTYiCiAgICAgICAgIHN0eWxlPSJmaWxsOiMwMDAwMDA7ZmlsbC1vcGFjaXR5OjE7ZmlsbC1ydWxlOmV2ZW5vZGQ7c3Ryb2tlOm5vbmU7c3Ryb2tlLXdpZHRoOjM7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgICAgZD0iTSAtMi4yNSw4MS41MDAwMDUgQyAtMy44NDczNzQsODQuMTQ0NDA1IC00LjUsODQuNTAwMDA1IC00LjUsODQuNTAwMDA1IEwgLTguMTU2MjUsODQuNTAwMDA1IEwgLTYuMTU2MjUsODIuMDYyNTA1IEMgLTYuMTU2MjUsODIuMDYyNTA1IC0wLjUsNzUuMDYyNDUxIC0wLjUsNjQuNSBDIC0wLjUsNTMuOTM3NTQ5IC02LjE1NjI1LDQ2LjkzNzUgLTYuMTU2MjUsNDYuOTM3NSBMIC04LjE1NjI1LDQ0LjUgTCAtNC41LDQ0LjUgQyAtMy43MTg3NSw0NS40Mzc1IC0zLjA3ODEyNSw0Ni4xNTYyNSAtMi4yODEyNSw0Ny41IEMgLTAuNDA4NTMxLDUwLjU5OTgxNSAyLjUsNTYuNTI2NjQ2IDIuNSw2NC41IEMgMi41LDcyLjQ1MDY1IC0wLjM5NjY5Nyw3OC4zNzk0MjUgLTIuMjUsODEuNTAwMDA1IHoiCiAgICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2NjY3NjY2Njc2MiIC8+CiAgICAgIDxwYXRoCiAgICAgICAgIHN0eWxlPSJmaWxsOiMwMDAwMDA7ZmlsbC1vcGFjaXR5OjE7ZmlsbC1ydWxlOmV2ZW5vZGQ7c3Ryb2tlOm5vbmU7c3Ryb2tlLXdpZHRoOjM7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgICAgICAgZD0iTSAtMi40MDYyNSw0NC41IEwgLTAuNDA2MjUsNDYuOTM3NSBDIC0wLjQwNjI1LDQ2LjkzNzUgNS4yNSw1My45Mzc1NDkgNS4yNSw2NC41IEMgNS4yNSw3NS4wNjI0NTEgLTAuNDA2MjUsODIuMDYyNSAtMC40MDYyNSw4Mi4wNjI1IEwgLTIuNDA2MjUsODQuNSBMIDAuNzUsODQuNSBMIDE0Ljc1LDg0LjUgQyAxNy4xNTgwNzYsODQuNTAwMDAxIDIyLjQzOTY5OSw4NC41MjQ1MTQgMjguMzc1LDgyLjA5Mzc1IEMgMzQuMzEwMzAxLDc5LjY2Mjk4NiA0MC45MTE1MzYsNzQuNzUwNDg0IDQ2LjA2MjUsNjUuMjE4NzUgTCA0NC43NSw2NC41IEwgNDYuMDYyNSw2My43ODEyNSBDIDM1Ljc1OTM4Nyw0NC43MTU1OSAxOS41MDY1NzQsNDQuNSAxNC43NSw0NC41IEwgMC43NSw0NC41IEwgLTIuNDA2MjUsNDQuNSB6IE0gMy40Njg3NSw0Ny41IEwgMTQuNzUsNDcuNSBDIDE5LjQzNDE3Myw0Ny41IDMzLjAzNjg1LDQ3LjM2OTc5MyA0Mi43MTg3NSw2NC41IEMgMzcuOTUxOTY0LDcyLjkyOTA3NSAzMi4xOTc0NjksNzcuMTgzOTEgMjcsNzkuMzEyNSBDIDIxLjYzOTMzOSw4MS41MDc5MjQgMTcuMTU4MDc1LDgxLjUwMDAwMSAxNC43NSw4MS41IEwgMy41LDgxLjUgQyA1LjM3MzU4ODQsNzguMzkxNTY2IDguMjUsNzIuNDUwNjUgOC4yNSw2NC41IEMgOC4yNSw1Ni41MjY2NDYgNS4zNDE0Njg2LDUwLjU5OTgxNSAzLjQ2ODc1LDQ3LjUgeiIKICAgICAgICAgaWQ9InBhdGg0OTczIgogICAgICAgICBzb2RpcG9kaTpub2RldHlwZXM9ImNjc2NjY2NzY2NjY2NjY2Njc2Njc2MiIC8+CiAgICA8L2c+CiAgPC9nPgo8L3N2Zz4K"
                }
            }
        }, joint.shapes.logic.Gate21.prototype.defaults),
        operation: function(a, b) {
            return (!a || b) && (a || !b)
        }
    }), joint.shapes.logic.Xnor = joint.shapes.logic.Gate21.extend({
        defaults: _.defaultsDeep({
            type: "logic.Xnor",
            attrs: {
                image: {
                    "xlink:href": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy8pIC0tPgo8c3ZnCiAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgeG1sbnM6Y2M9Imh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL25zIyIKICAgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIgogICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zOnNvZGlwb2RpPSJodHRwOi8vc29kaXBvZGkuc291cmNlZm9yZ2UubmV0L0RURC9zb2RpcG9kaS0wLmR0ZCIKICAgeG1sbnM6aW5rc2NhcGU9Imh0dHA6Ly93d3cuaW5rc2NhcGUub3JnL25hbWVzcGFjZXMvaW5rc2NhcGUiCiAgIHdpZHRoPSIxMDAiCiAgIGhlaWdodD0iNTAiCiAgIGlkPSJzdmcyIgogICBzb2RpcG9kaTp2ZXJzaW9uPSIwLjMyIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjQ2IgogICB2ZXJzaW9uPSIxLjAiCiAgIHNvZGlwb2RpOmRvY25hbWU9IlhOT1IgQU5TSS5zdmciCiAgIGlua3NjYXBlOm91dHB1dF9leHRlbnNpb249Im9yZy5pbmtzY2FwZS5vdXRwdXQuc3ZnLmlua3NjYXBlIj4KICA8ZGVmcwogICAgIGlkPSJkZWZzNCI+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogMTUgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfej0iNTAgOiAxNSA6IDEiCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMjUgOiAxMCA6IDEiCiAgICAgICBpZD0icGVyc3BlY3RpdmUyNzE0IiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDAuNSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF96PSIxIDogMC41IDogMSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIwLjUgOiAwLjMzMzMzMzMzIDogMSIKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI4MDYiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI4MTkiCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iMzcyLjA0NzI0IDogMzUwLjc4NzM5IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9Ijc0NC4wOTQ0OCA6IDUyNi4xODEwOSA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogNTI2LjE4MTA5IDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgICA8aW5rc2NhcGU6cGVyc3BlY3RpdmUKICAgICAgIGlkPSJwZXJzcGVjdGl2ZTI3NzciCiAgICAgICBpbmtzY2FwZTpwZXJzcDNkLW9yaWdpbj0iNzUgOiA0MCA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF96PSIxNTAgOiA2MCA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogNjAgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlMzI3NSIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSI1MCA6IDMzLjMzMzMzMyA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF96PSIxMDAgOiA1MCA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF95PSIwIDogMTAwMCA6IDAiCiAgICAgICBpbmtzY2FwZTp2cF94PSIwIDogNTAgOiAxIgogICAgICAgc29kaXBvZGk6dHlwZT0iaW5rc2NhcGU6cGVyc3AzZCIgLz4KICAgIDxpbmtzY2FwZTpwZXJzcGVjdGl2ZQogICAgICAgaWQ9InBlcnNwZWN0aXZlNTUzMyIKICAgICAgIGlua3NjYXBlOnBlcnNwM2Qtb3JpZ2luPSIzMiA6IDIxLjMzMzMzMyA6IDEiCiAgICAgICBpbmtzY2FwZTp2cF96PSI2NCA6IDMyIDogMSIKICAgICAgIGlua3NjYXBlOnZwX3k9IjAgOiAxMDAwIDogMCIKICAgICAgIGlua3NjYXBlOnZwX3g9IjAgOiAzMiA6IDEiCiAgICAgICBzb2RpcG9kaTp0eXBlPSJpbmtzY2FwZTpwZXJzcDNkIiAvPgogICAgPGlua3NjYXBlOnBlcnNwZWN0aXZlCiAgICAgICBpZD0icGVyc3BlY3RpdmUyNTU3IgogICAgICAgaW5rc2NhcGU6cGVyc3AzZC1vcmlnaW49IjI1IDogMTYuNjY2NjY3IDogMSIKICAgICAgIGlua3NjYXBlOnZwX3o9IjUwIDogMjUgOiAxIgogICAgICAgaW5rc2NhcGU6dnBfeT0iMCA6IDEwMDAgOiAwIgogICAgICAgaW5rc2NhcGU6dnBfeD0iMCA6IDI1IDogMSIKICAgICAgIHNvZGlwb2RpOnR5cGU9Imlua3NjYXBlOnBlcnNwM2QiIC8+CiAgPC9kZWZzPgogIDxzb2RpcG9kaTpuYW1lZHZpZXcKICAgICBpZD0iYmFzZSIKICAgICBwYWdlY29sb3I9IiNmZmZmZmYiCiAgICAgYm9yZGVyY29sb3I9IiM2NjY2NjYiCiAgICAgYm9yZGVyb3BhY2l0eT0iMS4wIgogICAgIGlua3NjYXBlOnBhZ2VvcGFjaXR5PSIwLjAiCiAgICAgaW5rc2NhcGU6cGFnZXNoYWRvdz0iMiIKICAgICBpbmtzY2FwZTp6b29tPSI0IgogICAgIGlua3NjYXBlOmN4PSI5NS43MjM2NiIKICAgICBpbmtzY2FwZTpjeT0iLTI2Ljc3NTAyMyIKICAgICBpbmtzY2FwZTpkb2N1bWVudC11bml0cz0icHgiCiAgICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0ibGF5ZXIxIgogICAgIHNob3dncmlkPSJ0cnVlIgogICAgIGlua3NjYXBlOmdyaWQtYmJveD0idHJ1ZSIKICAgICBpbmtzY2FwZTpncmlkLXBvaW50cz0idHJ1ZSIKICAgICBncmlkdG9sZXJhbmNlPSIxMDAwMCIKICAgICBpbmtzY2FwZTp3aW5kb3ctd2lkdGg9IjEzOTkiCiAgICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iODc0IgogICAgIGlua3NjYXBlOndpbmRvdy14PSIzMyIKICAgICBpbmtzY2FwZTp3aW5kb3cteT0iMCIKICAgICBpbmtzY2FwZTpzbmFwLWJib3g9InRydWUiPgogICAgPGlua3NjYXBlOmdyaWQKICAgICAgIGlkPSJHcmlkRnJvbVByZTA0NlNldHRpbmdzIgogICAgICAgdHlwZT0ieHlncmlkIgogICAgICAgb3JpZ2lueD0iMHB4IgogICAgICAgb3JpZ2lueT0iMHB4IgogICAgICAgc3BhY2luZ3g9IjFweCIKICAgICAgIHNwYWNpbmd5PSIxcHgiCiAgICAgICBjb2xvcj0iIzAwMDBmZiIKICAgICAgIGVtcGNvbG9yPSIjMDAwMGZmIgogICAgICAgb3BhY2l0eT0iMC4yIgogICAgICAgZW1wb3BhY2l0eT0iMC40IgogICAgICAgZW1wc3BhY2luZz0iNSIKICAgICAgIHZpc2libGU9InRydWUiCiAgICAgICBlbmFibGVkPSJ0cnVlIiAvPgogIDwvc29kaXBvZGk6bmFtZWR2aWV3PgogIDxtZXRhZGF0YQogICAgIGlkPSJtZXRhZGF0YTciPgogICAgPHJkZjpSREY+CiAgICAgIDxjYzpXb3JrCiAgICAgICAgIHJkZjphYm91dD0iIj4KICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD4KICAgICAgICA8ZGM6dHlwZQogICAgICAgICAgIHJkZjpyZXNvdXJjZT0iaHR0cDovL3B1cmwub3JnL2RjL2RjbWl0eXBlL1N0aWxsSW1hZ2UiIC8+CiAgICAgIDwvY2M6V29yaz4KICAgIDwvcmRmOlJERj4KICA8L21ldGFkYXRhPgogIDxnCiAgICAgaW5rc2NhcGU6bGFiZWw9IkxheWVyIDEiCiAgICAgaW5rc2NhcGU6Z3JvdXBtb2RlPSJsYXllciIKICAgICBpZD0ibGF5ZXIxIj4KICAgIDxwYXRoCiAgICAgICBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDoyLjAwMDAwMDI0O3N0cm9rZS1saW5lY2FwOmJ1dHQ7c3Ryb2tlLWxpbmVqb2luOm1pdGVyO3N0cm9rZS1vcGFjaXR5OjEiCiAgICAgICBkPSJNIDc4LjMzMzMzMiwyNSBDIDkxLjY2NjY2NiwyNSA5NSwyNSA5NSwyNSIKICAgICAgIGlkPSJwYXRoMzA1OSIKICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2MiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDAwMDtzdHJva2Utd2lkdGg6MS45OTk5OTk4ODtzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgZD0iTSAzMC4zODU3MTcsMTUgTCA0Ljk5OTk5OTgsMTUiCiAgICAgICBpZD0icGF0aDMwNjEiIC8+CiAgICA8cGF0aAogICAgICAgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDAwMDtzdHJva2Utd2lkdGg6MS45OTk5OTk3NjtzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgZD0iTSAzMS4zNjIwOTEsMzUgTCA0Ljk5OTk5OTgsMzUiCiAgICAgICBpZD0icGF0aDM5NDQiIC8+CiAgICA8ZwogICAgICAgaWQ9ImcyNTYwIgogICAgICAgaW5rc2NhcGU6bGFiZWw9IkxheWVyIDEiCiAgICAgICB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyNi41LC0zOS41KSI+CiAgICAgIDxwYXRoCiAgICAgICAgIGlkPSJwYXRoMzUxNiIKICAgICAgICAgc3R5bGU9ImZpbGw6IzAwMDAwMDtmaWxsLW9wYWNpdHk6MTtmaWxsLXJ1bGU6ZXZlbm9kZDtzdHJva2U6bm9uZTtzdHJva2Utd2lkdGg6MztzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgICBkPSJNIC0yLjI1LDgxLjUwMDAwNSBDIC0zLjg0NzM3NCw4NC4xNDQ0MDUgLTQuNSw4NC41MDAwMDUgLTQuNSw4NC41MDAwMDUgTCAtOC4xNTYyNSw4NC41MDAwMDUgTCAtNi4xNTYyNSw4Mi4wNjI1MDUgQyAtNi4xNTYyNSw4Mi4wNjI1MDUgLTAuNSw3NS4wNjI0NTEgLTAuNSw2NC41IEMgLTAuNSw1My45Mzc1NDkgLTYuMTU2MjUsNDYuOTM3NSAtNi4xNTYyNSw0Ni45Mzc1IEwgLTguMTU2MjUsNDQuNSBMIC00LjUsNDQuNSBDIC0zLjcxODc1LDQ1LjQzNzUgLTMuMDc4MTI1LDQ2LjE1NjI1IC0yLjI4MTI1LDQ3LjUgQyAtMC40MDg1MzEsNTAuNTk5ODE1IDIuNSw1Ni41MjY2NDYgMi41LDY0LjUgQyAyLjUsNzIuNDUwNjUgLTAuMzk2Njk3LDc4LjM3OTQyNSAtMi4yNSw4MS41MDAwMDUgeiIKICAgICAgICAgc29kaXBvZGk6bm9kZXR5cGVzPSJjY2Njc2NjY2NzYyIgLz4KICAgICAgPHBhdGgKICAgICAgICAgc3R5bGU9ImZpbGw6IzAwMDAwMDtmaWxsLW9wYWNpdHk6MTtmaWxsLXJ1bGU6ZXZlbm9kZDtzdHJva2U6bm9uZTtzdHJva2Utd2lkdGg6MztzdHJva2UtbGluZWNhcDpidXR0O3N0cm9rZS1saW5lam9pbjptaXRlcjtzdHJva2Utb3BhY2l0eToxIgogICAgICAgICBkPSJNIC0yLjQwNjI1LDQ0LjUgTCAtMC40MDYyNSw0Ni45Mzc1IEMgLTAuNDA2MjUsNDYuOTM3NSA1LjI1LDUzLjkzNzU0OSA1LjI1LDY0LjUgQyA1LjI1LDc1LjA2MjQ1MSAtMC40MDYyNSw4Mi4wNjI1IC0wLjQwNjI1LDgyLjA2MjUgTCAtMi40MDYyNSw4NC41IEwgMC43NSw4NC41IEwgMTQuNzUsODQuNSBDIDE3LjE1ODA3Niw4NC41MDAwMDEgMjIuNDM5Njk5LDg0LjUyNDUxNCAyOC4zNzUsODIuMDkzNzUgQyAzNC4zMTAzMDEsNzkuNjYyOTg2IDQwLjkxMTUzNiw3NC43NTA0ODQgNDYuMDYyNSw2NS4yMTg3NSBMIDQ0Ljc1LDY0LjUgTCA0Ni4wNjI1LDYzLjc4MTI1IEMgMzUuNzU5Mzg3LDQ0LjcxNTU5IDE5LjUwNjU3NCw0NC41IDE0Ljc1LDQ0LjUgTCAwLjc1LDQ0LjUgTCAtMi40MDYyNSw0NC41IHogTSAzLjQ2ODc1LDQ3LjUgTCAxNC43NSw0Ny41IEMgMTkuNDM0MTczLDQ3LjUgMzMuMDM2ODUsNDcuMzY5NzkzIDQyLjcxODc1LDY0LjUgQyAzNy45NTE5NjQsNzIuOTI5MDc1IDMyLjE5NzQ2OSw3Ny4xODM5MSAyNyw3OS4zMTI1IEMgMjEuNjM5MzM5LDgxLjUwNzkyNCAxNy4xNTgwNzUsODEuNTAwMDAxIDE0Ljc1LDgxLjUgTCAzLjUsODEuNSBDIDUuMzczNTg4NCw3OC4zOTE1NjYgOC4yNSw3Mi40NTA2NSA4LjI1LDY0LjUgQyA4LjI1LDU2LjUyNjY0NiA1LjM0MTQ2ODYsNTAuNTk5ODE1IDMuNDY4NzUsNDcuNSB6IgogICAgICAgICBpZD0icGF0aDQ5NzMiCiAgICAgICAgIHNvZGlwb2RpOm5vZGV0eXBlcz0iY2NzY2NjY3NjY2NjY2NjY2NzY2NzYyIgLz4KICAgIDwvZz4KICAgIDxwYXRoCiAgICAgICBzb2RpcG9kaTp0eXBlPSJhcmMiCiAgICAgICBzdHlsZT0iZmlsbDpub25lO2ZpbGwtb3BhY2l0eToxO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDozO3N0cm9rZS1saW5lam9pbjptaXRlcjttYXJrZXI6bm9uZTtzdHJva2Utb3BhY2l0eToxO3Zpc2liaWxpdHk6dmlzaWJsZTtkaXNwbGF5OmlubGluZTtvdmVyZmxvdzp2aXNpYmxlO2VuYWJsZS1iYWNrZ3JvdW5kOmFjY3VtdWxhdGUiCiAgICAgICBpZD0icGF0aDM1NTEiCiAgICAgICBzb2RpcG9kaTpjeD0iNzUiCiAgICAgICBzb2RpcG9kaTpjeT0iMjUiCiAgICAgICBzb2RpcG9kaTpyeD0iNCIKICAgICAgIHNvZGlwb2RpOnJ5PSI0IgogICAgICAgZD0iTSA3OSwyNSBBIDQsNCAwIDEgMSA3MSwyNSBBIDQsNCAwIDEgMSA3OSwyNSB6IiAvPgogIDwvZz4KPC9zdmc+Cg=="
                }
            }
        }, joint.shapes.logic.Gate21.prototype.defaults),
        operation: function(a, b) {
            return (!a || !b) && (a || b)
        }
    }), joint.shapes.logic.Wire = joint.dia.Link.extend({
        arrowheadMarkup: ['<g class="marker-arrowhead-group marker-arrowhead-group-<%= end %>">', '<circle class="marker-arrowhead" end="<%= end %>" r="7"/>', "</g>"].join(""),
        vertexMarkup: ['<g class="marker-vertex-group" transform="translate(<%= x %>, <%= y %>)">', '<circle class="marker-vertex" idx="<%= idx %>" r="10" />', '<g class="marker-vertex-remove-group">', '<path class="marker-vertex-remove-area" idx="<%= idx %>" d="M16,5.333c-7.732,0-14,4.701-14,10.5c0,1.982,0.741,3.833,2.016,5.414L2,25.667l5.613-1.441c2.339,1.317,5.237,2.107,8.387,2.107c7.732,0,14-4.701,14-10.5C30,10.034,23.732,5.333,16,5.333z" transform="translate(5, -33)"/>', '<path class="marker-vertex-remove" idx="<%= idx %>" transform="scale(.8) translate(9.5, -37)" d="M24.778,21.419 19.276,15.917 24.777,10.415 21.949,7.585 16.447,13.087 10.945,7.585 8.117,10.415 13.618,15.917 8.116,21.419 10.946,24.248 16.447,18.746 21.948,24.248z">', "<title>Remove vertex.</title>", "</path>", "</g>", "</g>"].join(""),
        defaults: _.defaultsDeep({
            type: "logic.Wire",
            attrs: {
                ".connection": {
                    "stroke-width": 2
                },
                ".marker-vertex": {
                    r: 7
                }
            },
            router: {
                name: "orthogonal"
            },
            connector: {
                name: "rounded",
                args: {
                    radius: 10
                }
            }
        }, joint.dia.Link.prototype.defaults)
    });
    if ("object" == typeof exports) var graphlib = require("graphlib"),
        dagre = require("dagre");
    graphlib = graphlib || "undefined" != typeof window && window.graphlib, dagre = dagre || "undefined" != typeof window && window.dagre, joint.layout.DirectedGraph = {
        layout: function(a, b) {
            var c;
            c = a instanceof joint.dia.Graph ? a : (new joint.dia.Graph).resetCells(a, {
                dry: !0
            }), a = null, b = _.defaults(b || {}, {
                resizeClusters: !0,
                clusterPadding: 10
            });
            var d = c.toGraphLib({
                    directed: !0,
                    multigraph: !0,
                    compound: !0,
                    setNodeLabel: function(a) {
                        return {
                            width: a.get("size").width,
                            height: a.get("size").height,
                            rank: a.get("rank")
                        }
                    },
                    setEdgeLabel: function(a) {
                        return {
                            minLen: a.get("minLen") || 1
                        }
                    },
                    setEdgeName: function(a) {
                        return a.id
                    }
                }),
                e = {},
                f = b.marginX || 0,
                h = b.marginY || 0;
            b.rankDir && (e.rankdir = b.rankDir), b.align && (e.align = b.align), b.nodeSep && (e.nodesep = b.nodeSep), b.edgeSep && (e.edgesep = b.edgeSep), b.rankSep && (e.ranksep = b.rankSep), f && (e.marginx = f), h && (e.marginy = h), d.setGraph(e), dagre.layout(d, {
                debugTiming: !!b.debugTiming
            }), c.startBatch("layout"), c.fromGraphLib(d, {
                importNode: function(a, c) {
                    var d = this.getCell(a),
                        e = c.node(a);
                    b.setPosition ? b.setPosition(d, e) : d.set("position", {
                        x: e.x - e.width / 2,
                        y: e.y - e.height / 2
                    })
                },
                importEdge: function(a, c) {
                    var d = this.getCell(a.name),
                        e = c.edge(a),
                        f = e.points || [];
                    b.setLinkVertices && (b.setVertices ? b.setVertices(d, f) : d.set("vertices", f.slice(1, f.length - 1)))
                }
            }), b.resizeClusters && _.chain(d.nodes()).filter(function(a) {
                return d.children(a).length > 0
            }).map(c.getCell, c).sortBy(function(a) {
                return -a.getAncestors().length
            }).invoke("fitEmbeds", {
                padding: b.clusterPadding
            }).value(), c.stopBatch("layout");
            var i = d.graph();
            return g.Rect(f, h, Math.abs(i.width - 2 * f), Math.abs(i.height - 2 * h))
        },
        fromGraphLib: function(a, b) {
            b = b || {};
            var c = b.importNode || _.noop,
                d = b.importEdge || _.noop,
                e = this instanceof joint.dia.Graph ? this : new joint.dia.Graph;
            return a.nodes().forEach(function(d) {
                c.call(e, d, a, e, b)
            }), a.edges().forEach(function(c) {
                d.call(e, c, a, e, b)
            }), e
        },
        toGraphLib: function(a, b) {
            b = b || {};
            var c = _.pick(b, "directed", "compound", "multigraph"),
                d = new graphlib.Graph(c),
                e = b.setNodeLabel || _.noop,
                f = b.setEdgeLabel || _.noop,
                g = b.setEdgeName || _.noop;
            return a.get("cells").each(function(a) {
                if (a.isLink()) {
                    var b = a.get("source"),
                        c = a.get("target");
                    if (!b.id || !c.id) return;
                    d.setEdge(b.id, c.id, f(a), g(a))
                } else d.setNode(a.id, e(a)), d.isCompound() && a.has("parent") && d.setParent(a.id, a.get("parent"))
            }), d
        }
    }, joint.dia.Graph.prototype.toGraphLib = function(a) {
        return joint.layout.DirectedGraph.toGraphLib(this, a)
    }, joint.dia.Graph.prototype.fromGraphLib = function(a, b) {
        return joint.layout.DirectedGraph.fromGraphLib.call(this, a, b)
    };
    joint.shapes.chart = {}, joint.shapes.chart.Plot = joint.shapes.basic.Generic.extend({
        markup: ['<clipPath class="clip"><rect/></clipPath>', '<g class="rotatable">', '<g class="scalable"></g>', '<g class="background"><rect/><text/></g>', '<g class="axis">', '<g class="y-axis"><path/><g class="ticks"></g></g>', '<g class="x-axis"><path/><g class="ticks"></g></g>', '<g class="markings"></g>', "</g>", '<g class="data"><g class="series"></g></g>', '<g class="foreground">', '<rect/><text class="caption"/><text class="subcaption"/>', '<g class="legend"><g class="legend-items"></g></g>', '<line class="guideline x-guideline" /><line class="guideline y-guideline" />', "</g>", "</g>"].join(""),
        tickMarkup: '<g class="tick"><line/><text/></g>',
        pointMarkup: '<g class="point"><circle/><text/></g>',
        barMarkup: '<path class="bar"/>',
        markingMarkup: '<g class="marking"><rect/><text/></g>',
        serieMarkup: '<g><clipPath class="serie-clip"><rect/></clipPath><path/><g class="bars"></g><g class="points"></g></g>',
        legendItemMarkup: '<g class="legend-item"><circle/><text/></g>',
        defaults: joint.util.deepSupplement({
            type: "chart.Plot",
            attrs: {
                ".data path": {
                    fill: "none",
                    stroke: "black"
                },
                ".data .bars rect": {
                    fill: "none",
                    stroke: "black"
                },
                ".background rect": {
                    fill: "white",
                    stroke: "#e5e5e5",
                    opacity: 1
                },
                ".background text": {
                    fill: "black",
                    text: "No data available.",
                    ref: ".",
                    "ref-x": .5,
                    "ref-y": .5,
                    "text-anchor": "middle",
                    "y-alignment": "middle",
                    display: "none"
                },
                ".foreground > rect": {
                    fill: "white",
                    stroke: "#e5e5e5",
                    opacity: 0,
                    "pointer-events": "none"
                },
                ".foreground .caption": {
                    fill: "black",
                    text: "",
                    ref: ".foreground > rect",
                    "ref-x": .5,
                    "ref-y": 10,
                    "text-anchor": "middle",
                    "y-alignment": "middle",
                    "font-size": 14
                },
                ".foreground .subcaption": {
                    fill: "black",
                    text: "",
                    ref: ".foreground > rect",
                    "ref-x": .5,
                    "ref-y": 23,
                    "text-anchor": "middle",
                    "y-alignment": "middle",
                    "font-size": 10
                },
                ".point": {
                    display: "inline-block"
                },
                ".point circle": {
                    r: 2,
                    stroke: "black",
                    fill: "black",
                    opacity: .3
                },
                ".point text": {
                    fill: "black",
                    "font-size": 8,
                    "text-anchor": "middle",
                    display: "none"
                },
                ".axis path": {
                    fill: "none",
                    stroke: "black"
                },
                ".axis .tick": {
                    fill: "none",
                    stroke: "black"
                },
                ".y-axis .tick line": {
                    fill: "none",
                    stroke: "black",
                    x2: 2,
                    y2: 0,
                    opacity: 1
                },
                ".x-axis .tick line": {
                    fill: "none",
                    stroke: "black",
                    x2: 0,
                    y2: -3,
                    opacity: 1
                },
                ".y-axis .tick text": {
                    fill: "black",
                    stroke: "none",
                    "font-size": 10,
                    "text-anchor": "end"
                },
                ".x-axis .tick text": {
                    fill: "black",
                    stroke: "none",
                    "font-size": 10,
                    "text-anchor": "middle"
                },
                ".y-axis .tick text > tspan": {
                    dy: "-.5em",
                    x: -5
                },
                ".x-axis .tick text > tspan": {
                    dy: ".5em",
                    x: 0
                },
                ".axis .markings": {
                    fill: "black",
                    stroke: "none",
                    "fill-opacity": 1
                },
                ".axis .markings text": {
                    fill: "black",
                    "text-anchor": "end",
                    "font-size": 10,
                    dy: -5,
                    dx: -5
                },
                ".guideline": {
                    "pointer-events": "none",
                    display: "none"
                },
                ".x-guideline": {
                    stroke: "black",
                    visibility: "hidden"
                },
                ".y-guideline": {
                    stroke: "black",
                    visibility: "hidden"
                },
                ".legend": {
                    ref: ".background",
                    "ref-x": 10,
                    "ref-y": 10
                },
                ".legend-item text": {
                    fill: "black",
                    transform: "translate(14, 0)",
                    "font-size": 11
                },
                ".legend-item circle": {
                    r: 5,
                    transform: "translate(5,5)"
                },
                ".legend-item": {
                    cursor: "pointer"
                },
                ".legend-item.disabled circle": {
                    fill: "gray"
                },
                ".legend-item.disabled text": {
                    opacity: .5
                }
            }
        }, joint.shapes.basic.Generic.prototype.defaults),
        legendPosition: function(a, b) {
            b = b || {}, this.trigger("batch:start"), this.removeAttr([".legend/ref-x", ".legend/ref-y", ".legend/ref-dx", ".legend/ref-dy", ".legend/x-alignment", ".legend/y-alignment"], {
                silent: !0
            });
            var c = b.padding || 10,
                d = {
                    n: {
                        ".legend": {
                            "ref-x": .5,
                            "x-alignment": -.5,
                            "ref-y": c
                        }
                    },
                    ne: {
                        ".legend": {
                            "ref-dx": -c,
                            "x-alignment": -.999,
                            "ref-y": c
                        }
                    },
                    e: {
                        ".legend": {
                            "ref-dx": -c,
                            "x-alignment": -.999,
                            "ref-y": .5,
                            "y-alignment": -.5
                        }
                    },
                    se: {
                        ".legend": {
                            "ref-dx": -c,
                            "ref-dy": -c,
                            "x-alignment": -.999,
                            "y-alignment": -.999
                        }
                    },
                    s: {
                        ".legend": {
                            "ref-x": .5,
                            "ref-dy": -c,
                            "x-alignment": -.5,
                            "y-alignment": -.999
                        }
                    },
                    sw: {
                        ".legend": {
                            "ref-x": c,
                            "ref-dy": -c,
                            "y-alignment": -.999
                        }
                    },
                    w: {
                        ".legend": {
                            "ref-x": c,
                            "ref-y": .5,
                            "y-alignment": -.5
                        }
                    },
                    nw: {
                        ".legend": {
                            "ref-x": c,
                            "ref-y": c
                        }
                    },
                    nnw: {
                        ".legend": {
                            "ref-x": c,
                            "ref-y": -c,
                            "y-alignment": -.999
                        }
                    },
                    nn: {
                        ".legend": {
                            "ref-x": .5,
                            "ref-y": -c,
                            "x-alignment": -.5,
                            "y-alignment": -.999
                        }
                    },
                    nne: {
                        ".legend": {
                            "ref-dx": -c,
                            "ref-y": -c,
                            "x-alignment": -.999,
                            "y-alignment": -.999
                        }
                    },
                    nnee: {
                        ".legend": {
                            "ref-dx": c,
                            "ref-y": -c,
                            "y-alignment": -.999
                        }
                    },
                    nee: {
                        ".legend": {
                            "ref-y": c,
                            "ref-dx": c
                        }
                    },
                    ee: {
                        ".legend": {
                            "ref-dx": c,
                            "ref-y": .5,
                            "y-alignment": -.5
                        }
                    },
                    see: {
                        ".legend": {
                            "ref-dx": c,
                            "ref-dy": -c,
                            "y-alignment": -.999
                        }
                    },
                    ssee: {
                        ".legend": {
                            "ref-dx": c,
                            "ref-dy": c
                        }
                    },
                    sse: {
                        ".legend": {
                            "ref-dx": -c,
                            "ref-dy": c,
                            "x-alignment": -.999
                        }
                    },
                    ss: {
                        ".legend": {
                            "ref-x": .5,
                            "ref-dy": c,
                            "x-alignment": -.5
                        }
                    },
                    ssw: {
                        ".legend": {
                            "ref-x": c,
                            "ref-dy": c
                        }
                    },
                    ssww: {
                        ".legend": {
                            "ref-x": -c,
                            "ref-dy": c,
                            "x-alignment": -.999
                        }
                    },
                    sww: {
                        ".legend": {
                            "ref-x": -c,
                            "ref-dy": -c,
                            "x-alignment": -.999,
                            "y-alignment": -.999
                        }
                    },
                    ww: {
                        ".legend": {
                            "ref-x": -c,
                            "ref-y": .5,
                            "x-alignment": -.999,
                            "y-alignment": -.5
                        }
                    },
                    nww: {
                        ".legend": {
                            "ref-x": -c,
                            "ref-y": c,
                            "x-alignment": -.999
                        }
                    },
                    nnww: {
                        ".legend": {
                            "ref-x": -c,
                            "ref-y": -c,
                            "x-alignment": -.999,
                            "y-alignment": -.999
                        }
                    }
                };
            d[a] && this.attr(d[a]), this.trigger("batch:stop")
        },
        addPoint: function(a, b, c) {
            c = c || {};
            var d = this.get("series"),
                e = _.findIndex(d, {
                    name: b
                });
            if (e === -1) throw new Error("Serie " + b + " was not found.");
            var f = _.cloneDeep(d[e]);
            f.data.push(a), _.isFinite(c.maxLen) && f.data.length > c.maxLen && f.data.shift(), d = d.slice(), d[e] = f, this.set("series", d, c)
        },
        lastPoint: function(a) {
            return _.last(_.findWhere(this.get("series"), {
                name: a
            }).data)
        },
        firstPoint: function(a) {
            return _.first(_.findWhere(this.get("series"), {
                name: a
            }).data)
        }
    }), joint.shapes.chart.PlotView = joint.dia.ElementView.extend({
        events: {
            mousemove: "onMouseMove",
            mouseout: "onMouseOut"
        },
        initialize: function() {
            joint.dia.ElementView.prototype.initialize.apply(this, arguments), this.listenTo(this.model, "change:series change:interpolate change:padding change:canvas change:markings change:axis", _.bind(function() {
                this.update()
            }, this)), this.on("cell:pointerdown", this.onPointerDown, this), this._disabledSeries = []
        },
        renderMarkup: function() {
            joint.dia.ElementView.prototype.renderMarkup.apply(this, arguments), this.elDataClipPath = this.$(".clip")[0], this.elDataClipPathRect = this.elDataClipPath.firstChild, this.elBackgroundRect = this.$(".background rect")[0], this.elBackgroundText = this.$(".background text")[0], this.elForeground = this.$(".foreground")[0], this.elForegroundRect = this.$(".foreground rect")[0], this.elDataSeries = this.$(".data .series")[0], this.elYAxisPath = this.$(".y-axis path")[0], this.elYAxisTicks = this.$(".y-axis .ticks")[0], this.elXAxisPath = this.$(".x-axis path")[0], this.elXAxisTicks = this.$(".x-axis .ticks")[0], this.elMarkings = this.$(".axis .markings")[0], this.elXGuideline = this.$(".x-guideline")[0], this.elYGuideline = this.$(".y-guideline")[0], this.elLegend = this.$(".legend")[0], this.elLegendItems = this.$(".legend-items")[0], this.elTick = V(this.model.tickMarkup), this.elMarking = V(this.model.markingMarkup), this.elLegendItem = V(this.model.legendItemMarkup), this.elPoint = V(this.model.pointMarkup), this.elBar = V(this.model.barMarkup), this.elSerie = V(this.model.serieMarkup), this.elDataClipPath.id = "clip_" + this.cid, V(this.$(".data")[0]).attr("clip-path", "url(#" + this.elDataClipPath.id + ")"), V(this.elMarkings).attr("clip-path", "url(#" + this.elDataClipPath.id + ")")
        },
        update: function() {
            var a = this.filterSeries();
            this.calculateStats(a);
            var b = this.model.get("size"),
                c = b.width,
                d = b.height;
            this.canvas = _.extend({
                x: 0,
                y: 0,
                width: c,
                height: d
            }, this.model.get("canvas"));
            var e, f = {
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0
                },
                h = this.model.get("padding");
            e = _.isObject(h) ? _.extend({}, f, h) : _.isUndefined(h) ? f : {
                top: h,
                right: 2 * h,
                bottom: 2 * h,
                left: h
            }, this.canvas = g.rect(this.canvas).moveAndExpand(g.rect(e.left, e.top, -e.right, -e.bottom));
            var i = {
                x: 0,
                y: 0,
                width: c,
                height: d
            };
            V(this.elDataClipPathRect).attr(i), V(this.elBackgroundRect).attr(i), V(this.elForegroundRect).attr(i), this.updateAxis(), this.updateMarkings(), this.isEmpty() ? $(this.elBackgroundText).show() : $(this.elBackgroundText).hide(), this.updateSeries(a), this.updateLegend(), joint.dia.ElementView.prototype.update.apply(this, arguments)
        },
        calculateStats: function(a) {
            a = a || this.model.get("series");
            var b = [],
                c = [],
                d = {},
                e = {},
                f = {};
            _.each(a, function(a, g) {
                var h = f[a.name || g] || (f[a.name || g] = {});
                h.decreasingX = !0, h.decreasingY = !0, h.nonDecreasingX = !0, h.nonDecreasingY = !0;
                var i;
                _.each(a.data, function(f) {
                    h.minX = _.isUndefined(h.minX) ? f.x : Math.min(h.minX, f.x), h.maxX = _.isUndefined(h.maxX) ? f.x : Math.max(h.maxX, f.x), h.minY = _.isUndefined(h.minY) ? f.y : Math.min(h.minY, f.y), h.maxY = _.isUndefined(h.maxY) ? f.y : Math.max(h.maxY, f.y), i && (h.decreasingX = h.decreasingX && f.x < i.x, h.decreasingY = h.decreasingY && f.y < i.y, h.nonDecreasingX = h.nonDecreasingX && f.x >= i.x, h.nonDecreasingY = h.nonDecreasingY && f.y >= i.y), _.contains(b, f.x) || b.push(f.x), _.contains(c, f.y) || c.push(f.y), (d[f.x] || (d[f.x] = [])).push({
                        serie: a,
                        x: f.x,
                        y: f.y
                    }), (e[f.y] || (e[f.y] = [])).push({
                        serie: a,
                        x: f.x,
                        y: f.y
                    }), i = f
                })
            });
            var g = this.model.get("axis") || {},
                h = g["x-axis"] || {},
                i = g["y-axis"] || {};
            this.stats = {
                minX: _.isUndefined(h.min) ? _.min(b) : h.min,
                maxX: _.isUndefined(h.max) ? _.max(b) : h.max,
                minY: _.isUndefined(i.min) ? _.min(c) : i.min,
                maxY: _.isUndefined(i.max) ? _.max(c) : i.max,
                bySerie: f,
                xValues: b,
                yValues: c,
                xMap: d,
                yMap: e
            }
        },
        isEmpty: function() {
            return !this.stats.xValues.length
        },
        updateSeries: function(a) {
            if (a = a || this.model.get("series"), this.elDataSeries.textContent = "", !this.isEmpty()) {
                var b = [this.stats.minX, this.stats.maxX],
                    c = [this.stats.minY, this.stats.maxY],
                    d = [this.canvas.x, this.canvas.x + this.canvas.width],
                    e = [this.canvas.y + this.canvas.height, this.canvas.y],
                    f = this.model.get("attrs");
                _.each(a, function(a, h) {
                    var i = a.data,
                        j = [],
                        k = this.elSerie.clone().attr("class", a.name || "serie-" + h);
                    V(this.elDataSeries).append(k), _.each(i, function(h) {
                        var i = g.scale.linear(b, d, h.x),
                            k = g.scale.linear(c, e, h.y);
                        j.push({
                            x: i,
                            y: k
                        }), f[".point"] && "none" !== f[".point"].display && this.renderPoint(h, a), a.bars && this.renderBar(h, a)
                    }, this);
                    var l = k.findOne(".serie-clip"),
                        m = this.model.get("size"),
                        n = this.stats.bySerie[a.name || h],
                        o = g.scale.linear(b, d, n.minX),
                        p = g.scale.linear(b, d, n.maxX),
                        q = l.findOne("rect");
                    if (q.attr(g.rect(o, 0, p - o, m.height)), !a.bars) {
                        var r = k.findOne("path");
                        r.attr({
                            d: this.seriePathData(j, a, h),
                            "clip-path": "url(#" + l.node.id + ")"
                        })
                    }
                }, this)
            }
        },
        seriePathClipData: function(a, b) {
            var c = 10,
                d = this.model.get("size"),
                e = _.first(a),
                f = ["M", e.x, e.y, "V", d.height + c];
            return f.join(" ")
        },
        renderBar: function(a, b) {
            var c = [this.stats.minX, this.stats.maxX],
                d = [this.stats.minY, this.stats.maxY],
                e = [this.canvas.x, this.canvas.x + this.canvas.width],
                f = [this.canvas.y + this.canvas.height, this.canvas.y],
                h = g.scale.linear(c, e, a.x),
                i = g.scale.linear(d, f, a.y),
                j = b.bars.barWidth || .8,
                k = j > 1 ? j : this.canvas.width / (this.stats.maxX - this.stats.minX) * j,
                l = g.scale.linear(d, f, 0) - i,
                m = a["top-rx"] || b.bars["top-rx"],
                n = a["top-ry"] || b.bars["top-ry"],
                o = a["bottom-rx"] || b.bars["bottom-rx"],
                p = a["bottom-ry"] || b.bars["bottom-ry"],
                q = {
                    left: h,
                    middle: h - k / 2,
                    right: h - k
                }[b.bars.align || "middle"],
                r = this.elBar.clone();
            r.attr({
                "data-serie": b.name,
                "data-x": a.x,
                "data-y": a.y,
                d: V.rectToPath({
                    x: q,
                    y: i,
                    width: k,
                    height: l,
                    "top-rx": m,
                    "top-ry": n,
                    "bottom-rx": o,
                    "bottom-ry": p
                })
            });
            var s = b.name || "serie-" + this.model.get("series").indexOf(b);
            return V(this.elDataSeries).findOne("." + s + " .bars").append(r), r.node
        },
        renderPoint: function(a, b) {
            var c = [this.stats.minX, this.stats.maxX],
                d = [this.stats.minY, this.stats.maxY],
                e = [this.canvas.x, this.canvas.x + this.canvas.width],
                f = [this.canvas.y + this.canvas.height, this.canvas.y],
                h = g.scale.linear(c, e, a.x),
                i = g.scale.linear(d, f, a.y),
                j = this.elPoint.clone();
            j.attr({
                "data-serie": b.name,
                "data-x": a.x,
                "data-y": a.y
            }), j.findOne("circle").attr({
                cx: h,
                cy: i
            }), j.findOne("text").attr({
                x: h,
                dy: i
            }).text(this.pointLabel(a, b));
            var k = b.name || "serie-" + this.model.get("series").indexOf(b);
            return V(this.elDataSeries).findOne("." + k + " .points").append(j), j.node
        },
        seriePathData: function(a, b, c) {
            var d, e, f, h = _.isUndefined(b.interpolate) ? this.model.get("interpolate") : b.interpolate,
                i = a.length;
            switch (h) {
                case "bezier":
                    d = g.bezier.curveThroughPoints(a);
                    break;
                case "step":
                    for (f = a[0], d = ["M", f.x, f.y], e = 1; e < i; e++) d.push("H", (f.x + a[e].x) / 2, "V", a[e].y), f = a[e];
                    break;
                case "stepBefore":
                    for (d = ["M", a[0].x, a[0].y], e = 1; e < i; e++) d.push("V", a[e].y, "H", a[e].x);
                    break;
                case "stepAfter":
                    for (d = ["M", a[0].x, a[0].y], e = 1; e < i; e++) d.push("H", a[e].x, "V", a[e].y);
                    break;
                default:
                    for (d = ["M"], e = 0; e < i; e++) d.push(a[e].x, a[e].y)
            }
            return d = this.fixPathForFill(d, a, b, c), d.join(" ")
        },
        fixPathForFill: function(a, b, c, d) {
            if (0 === b.length) return a;
            var e = this.stats.bySerie[c.name || d];
            if (!e.nonDecreasingX) return a;
            var f = 10,
                g = this.model.get("size"),
                h = _.first(b),
                i = _.last(b),
                j = ["M", i.x, g.height + f, "H", h.x - f, "V", h.y];
            return a[0] = "L", j.concat(a)
        },
        updateAxis: function() {
            var a = this.model.get("size"),
                b = a.width,
                c = a.height,
                d = this.model.get("axis"),
                e = this.canvas.height / c;
            if (V(this.elYAxisPath).attr("d", ["M", 0, 0, "L", 0, c].join(" ")), V(this.elXAxisPath).attr("d", ["M", 0, c, "L", b, c].join(" ")), this.elXAxisTicks.textContent = "", this.elYAxisTicks.textContent = "", !this.isEmpty()) {
                var f = [this.stats.minX, this.stats.maxX],
                    h = [this.stats.minY, this.stats.maxY],
                    i = [this.canvas.x, this.canvas.x + this.canvas.width],
                    j = [0, this.canvas.height],
                    k = h[1] - h[0],
                    l = d && d["y-axis"] || {},
                    m = d && d["x-axis"] || {},
                    n = k > 0 ? l.ticks - 1 || 10 : 0,
                    o = k / n / e,
                    p = h[0];
                _.each(_.range(n + 1), function(a) {
                    var b = g.scale.linear(h, j, p),
                        c = this.elTick.clone();
                    c.translate(0, b), V(this.elYAxisTicks).append(c);
                    var d = h[1] - (p - h[0]);
                    d += g.scale.linear(j, h, this.canvas.y) - h[0], c.findOne("text").text(this.tickLabel(d, l)), p += o
                }, this), _.each(this.stats.xValues, function(a, d) {
                    if (d % (m.tickStep || 1) === 0) {
                        var e = g.scale.linear(f, i, a);
                        if (!(e > b)) {
                            var h = this.elTick.clone();
                            h.translate(e, c), V(this.elXAxisTicks).append(h), h.findOne("text").text(this.tickLabel(a, m))
                        }
                    }
                }, this)
            }
        },
        tickLabel: function(a, b) {
            if (_.isFunction(b.tickFormat)) return b.tickFormat(a);
            var c = b.tickFormat || ".1f",
                d = joint.util.format.number(c, a);
            return d + (_.isFunction(b.tickSuffix) ? b.tickSuffix(a) : b.tickSuffix || "")
        },
        pointLabel: function(a, b) {
            if (_.isFunction(b.pointFormat)) return b.pointFormat(a);
            var c = b.pointFormat || ".1f",
                d = joint.util.format.number(c, a.y);
            return d + (b.pointSuffix || "")
        },
        updateMarkings: function() {
            function a(a, b) {
                return _.isUndefined(a) ? b : a
            }
            this.elMarkings.textContent = "";
            var b = this.model.get("markings");
            if (b && 0 !== b.length) {
                var c = this.model.get("size"),
                    d = c.width,
                    e = c.height,
                    f = [this.stats.minX, this.stats.maxX],
                    h = [this.stats.minY, this.stats.maxY],
                    i = [this.canvas.x, this.canvas.x + this.canvas.width],
                    j = [this.canvas.y, this.canvas.y + this.canvas.height];
                _.each(b, function(b, c) {
                    var k = b.start || b.end,
                        l = b.end || b.start,
                        m = Math.min(a(k.x, this.stats.minX), a(l.x, this.stats.minX)),
                        n = Math.max(a(k.x, this.stats.maxX), a(l.x, this.stats.maxX)),
                        o = Math.min(a(k.y, this.stats.minY), a(l.y, this.stats.minY)),
                        p = Math.max(a(k.y, this.stats.maxY), a(l.y, this.stats.maxY)),
                        q = _.isUndefined(k.x) || _.isUndefined(l.x),
                        r = _.isUndefined(k.y) || _.isUndefined(l.y);
                    q && (i = [0, d]), r && (j = [0, e]);
                    var s = g.scale.linear(f, i, m),
                        t = g.scale.linear(f, i, n),
                        u = g.scale.linear(h, j, o),
                        v = g.scale.linear(h, j, p),
                        w = s,
                        x = j[1] - v + j[0],
                        y = t - s,
                        z = v - u;
                    y = Math.max(y, 1), z = Math.max(z, 1);
                    var A = this.elMarking.clone();
                    A.findOne("rect").attr({
                        x: w,
                        y: x,
                        width: y,
                        height: z
                    }), A.findOne("text").text(b.label || "").attr({
                        x: w + y,
                        y: x
                    });
                    var B = A.attr("class") + " " + (b.name || "marking-" + c);
                    A.attr(_.extend({
                        "class": B
                    }, b.attrs)), V(this.elMarkings).append(A)
                }, this)
            }
        },
        updateLegend: function() {
            var a = this.model.get("series");
            this.elLegendItems.textContent = "", _.each(a, function(a, b) {
                if ((!_.isFunction(a.showLegend) || a.showLegend(a, this.stats.bySerie[a.name || b])) && a.showLegend !== !1) {
                    var c = this.elLegendItem.clone();
                    _.contains(this._disabledSeries, a.name) && c.addClass("disabled"), c.attr("data-serie", a.name), c.findOne("circle").attr({
                        fill: this.getSerieColor(a.name)
                    }), c.findOne("text").text(a.label || a.name), c.translate(0, b * (a.legendLabelLineHeight || 16)), V(this.elLegendItems).append(c)
                }
            }, this)
        },
        getSerieColor: function(a) {
            var b = this.model.get("attrs"),
                c = _.find(b, function(b, c) {
                    if (_.contains(c, a)) return !0
                });
            return c ? c.stroke || c.fill : "black"
        },
        hideSerie: function(a) {
            _.contains(this._disabledSeries, a) || this._disabledSeries.push(a);
            var b = this.filterSeries();
            this.update(b)
        },
        showSerie: function(a) {
            this._disabledSeries = _.without(this._disabledSeries, a);
            var b = this.filterSeries();
            this.update(b)
        },
        filterSeries: function(a) {
            return a = a || this.model.get("series"), a = _.reject(a, function(a) {
                return _.contains(this._disabledSeries, a.name)
            }, this)
        },
        onPointerDown: function(a, b, c) {
            var d = $(a.target).closest(".legend-item")[0];
            d && (V(d).toggleClass("disabled"), V(d).hasClass("disabled") ? this.hideSerie(V(d).attr("data-serie")) : this.showSerie(V(d).attr("data-serie")))
        },
        onMouseMove: function(a) {
            this.showGuidelines(a.clientX, a.clientY, a)
        },
        onMouseOut: function(a) {
            this.hideGuidelines(), this.trigger("mouseout", a)
        },
        showGuidelines: function(a, b, c) {
            var d = this.model.get("angle"),
                e = this.model.getBBox(),
                f = g.point(V(this.paper.viewport).toLocalPoint(a, b)).rotate(e.center(), d);
            if (g.rect(e).containsPoint(f)) {
                var h = this.model.get("size"),
                    i = f.x - e.x,
                    j = f.y - e.y;
                V(this.elXGuideline).attr({
                    x1: i,
                    y1: 0,
                    x2: i,
                    y2: h.height,
                    visibility: "visible"
                }), V(this.elYGuideline).attr({
                    x1: 0,
                    y1: j,
                    x2: h.width,
                    y2: j,
                    visibility: "visible"
                });
                var k = g.scale.linear([this.canvas.x, this.canvas.x + this.canvas.width], [this.stats.minX, this.stats.maxX], i),
                    l = g.scale.linear([this.canvas.y, this.canvas.y + this.canvas.height], [this.stats.minY, this.stats.maxY], j),
                    m = {
                        x: k,
                        y: this.stats.minY + this.stats.maxY - l
                    },
                    n = {
                        x: a,
                        y: b
                    },
                    o = this.closestPoints(k);
                this.trigger("mouseover", m, n, o, c)
            }
        },
        closestPoints: function(a) {
            var b = _.sortedIndex(this.stats.xValues, a),
                c = this.stats.xValues[b],
                d = this.stats.xValues[b - 1],
                e = _.isUndefined(d) ? c : Math.abs(a - c) < Math.abs(a - d) ? c : d;
            return this.stats.xMap[e]
        },
        hideGuidelines: function() {
            V(this.elXGuideline).attr("visibility", "hidden"), V(this.elYGuideline).attr("visibility", "hidden")
        }
    }), joint.shapes.chart.Pie = joint.shapes.basic.Generic.extend({
        markup: ['<g class="rotatable">', '<g class="scalable"></g>', '<g class="background"><rect/><text/></g>', '<g class="data"></g>', '<g class="foreground">', '<rect/><text class="caption"/><text class="subcaption"/>', '<g class="legend"><g class="legend-items"></g></g>', "</g>", "</g>"].join(""),
        sliceMarkup: '<g class="slice"/>',
        sliceFillMarkup: '<path class="slice-fill"/>',
        sliceBorderMarkup: '<path class="slice-border"/>',
        sliceInnerLabelMarkup: '<text class="slice-inner-label"/>',
        legendSerieMarkup: '<g class="legend-serie"><text/></g>',
        legendSliceMarkup: '<g class="legend-slice"><circle/><text/></g>',
        defaults: joint.util.deepSupplement({
            type: "chart.Pie",
            size: {
                width: 200,
                height: 200
            },
            pieHole: 0,
            serieDefaults: {
                startAngle: 0,
                degree: 360,
                label: null,
                showLegend: !0,
                labelLineHeight: 6
            },
            sliceDefaults: {
                innerLabel: "{percentage:.0f}%",
                innerLabelMargin: 6,
                legendLabel: "{label}: {value}",
                legendLabelLineHeight: 6,
                legendLabelMargin: 14,
                offset: 0,
                onClickEffect: {
                    type: "offset",
                    offset: 20
                },
                onHoverEffect: null
            },
            series: [],
            attrs: {
                ".background > rect": {
                    opacity: 0
                },
                ".background > text": {
                    fill: "black",
                    text: "No data available.",
                    ref: ".background > rect",
                    "ref-x": .5,
                    "ref-y": .5,
                    "text-anchor": "middle",
                    "y-alignment": "middle",
                    display: "none"
                },
                ".foreground > rect": {
                    fill: "white",
                    stroke: "#e5e5e5",
                    opacity: 0,
                    "pointer-events": "none"
                },
                ".foreground .caption": {
                    fill: "black",
                    text: "",
                    ref: ".foreground > rect",
                    "ref-x": 2,
                    "ref-y": 6,
                    "text-anchor": "start",
                    "y-alignment": "middle",
                    "font-size": 14
                },
                ".foreground .subcaption": {
                    fill: "black",
                    text: "",
                    ref: ".foreground > rect",
                    "ref-x": 2,
                    "ref-y": 18,
                    "text-anchor": "start",
                    "y-alignment": "middle",
                    "font-size": 10
                },
                ".data": {
                    ref: ".background",
                    "ref-x": .5,
                    "ref-y": .5
                },
                ".slice": {
                    cursor: "pointer"
                },
                ".slice > .slice-fill": {
                    stroke: "#ffffff",
                    "stroke-width": 1,
                    "fill-opacity": 1
                },
                ".slice.hover > .slice-fill": {
                    "fill-opacity": .8
                },
                ".slice > .slice-border": {
                    "stroke-width": 6,
                    "stroke-opacity": .4,
                    "fill-opacity": 1,
                    fill: "none",
                    display: "none"
                },
                ".slice.hover > .slice-border": {
                    display: "block"
                },
                ".slice > .slice-inner-label": {
                    "text-anchor": "middle",
                    "font-size": "12",
                    stroke: "none",
                    "stroke-width": "0",
                    fill: "#ffffff"
                },
                ".slice > .slice-inner-label > tspan": {
                    dy: "-.5em"
                },
                ".legend": {
                    ref: ".background",
                    "ref-dx": 20,
                    "ref-y": 5
                },
                ".legend-serie text": {
                    fill: "grey",
                    transform: "translate(2, 0)",
                    "font-size": 13
                },
                ".legend-slice": {
                    cursor: "pointer"
                },
                ".legend-slice text": {
                    "font-weight": "normal",
                    fill: "black",
                    "font-size": 11
                },
                ".legend-slice.hover text": {
                    "font-weight": "bold"
                },
                ".legend-slice circle": {
                    r: 5,
                    transform: "translate(5,5)"
                }
            }
        }, joint.shapes.basic.Generic.prototype.defaults),
        addSlice: function(a, b, c) {
            c = c || {}, b = b || 0;
            var d = this.get("series");
            _.isUndefined(d[b]) && (d[b] = {
                data: []
            });
            var e = _.cloneDeep(d[b]);
            e.data.push(a), d = d.slice(), d[b] = e, c = e.data.length > 1 ? _.extend(c, {
                changedSerieIndex: b
            }) : c, this.set("series", d, c)
        },
        editSlice: function(a, b, c, d) {
            d = d || {}, c = c || 0;
            var e = this.get("series");
            if (_.isUndefined(e[c]) || _.isUndefined(e[c].data[b])) throw new Error("Slice " + b + " on serie " + c + " was not found.");
            var f = _.cloneDeep(e[c]);
            f.data[b] = _.extend(f.data[b], a), e = e.slice(), e[c] = f, this.set("series", e, _.extend(d, {
                changedSerieIndex: c
            }))
        }
    }), joint.shapes.chart.PieView = joint.dia.ElementView.extend({
        events: {
            "mouseover .slice": "onMouseOverSlice",
            "mouseout .slice": "onMouseOverSlice",
            "mousemove .slice": "onMouseMoveSlice",
            "mouseover .legend-slice": "onEventLegendItem",
            "mouseout .legend-slice": "onEventLegendItem"
        },
        initialize: function() {
            joint.dia.ElementView.prototype.initialize.apply(this, arguments), this.listenTo(this.model, "change:series change:serieDefaults change:sliceDefaults change:pieHole", function(a, b, c) {
                this.update(null, null, null, c.changedSerieIndex)
            }), this.on("cell:pointerclick", this.onClickSlice, this), this.on("cell:pointerclick", this.onEventLegendItem, this)
        },
        renderMarkup: function() {
            joint.dia.ElementView.prototype.renderMarkup.apply(this, arguments), this.elBackgroundRect = this.$(".background rect")[0], this.elBackgroundText = this.$(".background text")[0], this.elForegroundRect = this.$(".foreground rect")[0], this.elLegendItems = this.$(".legend-items")[0], this.elPie = this.$(".data")[0], this.elSlice = V(this.model.sliceMarkup), this.elSliceFill = V(this.model.sliceFillMarkup), this.elSliceBorder = V(this.model.sliceBorderMarkup), this.elSliceInnerLabel = V(this.model.sliceInnerLabelMarkup), this.elLegendSerie = V(this.model.legendSerieMarkup), this.elLegendSlice = V(this.model.legendSliceMarkup)
        },
        update: function(a, b, c, d) {
            var e = this.calculateSeries(d);
            d in e ? $(this.elPie).find(".serie-" + d).remove() : $(this.elPie).empty();
            var f = this.model.get("size");
            V(this.elBackgroundRect).attr(f), V(this.elForegroundRect).attr(f), e.length ? $(this.elBackgroundText).hide() : $(this.elBackgroundText).show(), _.each(e, function(a, b) {
                (_.isUndefined(d) || d === b) && _.each(a.data, function(a) {
                    this.updateSlice(a)
                }, this)
            }, this), this.updateLegend(), joint.dia.ElementView.prototype.update.apply(this, arguments)
        },
        calculateSeries: function(a) {
            var b = _.cloneDeep(this.model.get("series")),
                c = this.model.get("serieDefaults"),
                d = this.model.get("sliceDefaults"),
                e = this.model.get("size"),
                f = _.min([e.width, e.height]) / 2,
                h = this.model.get("pieHole");
            h = h > 1 ? h : f * h;
            var i = f,
                j = (f - h) / b.length;
            return this._series = _.map(b, function(b, e) {
                if (!_.isUndefined(a) && a !== e) return b;
                b = _.defaults(b, c);
                var f = b.startAngle,
                    h = _.reduce(b.data, function(a, b) {
                        return a + b.value
                    }, 0),
                    k = b.degree / h || 0,
                    l = 100 / h;
                return b.data = _.map(b.data, function(a, b) {
                    a = _.defaults(a, _.omit(d, "offset", "onClickEffect", "onHoverEffect")), a.outerRadius = i, a.innerRadius = i - j, e || (a = _.defaults(a, _.pick(d, "offset", "onClickEffect", "onHoverEffect")), a.isOuter = !0, a.offset = a.offset > 1 ? a.offset : a.offset * a.outerRadius, a.onClickEffect.offset = a.onClickEffect.offset > 1 ? a.onClickEffect.offset : a.onClickEffect.offset * a.outerRadius), a.serieIndex = e, a.sliceIndex = b, a.innerLabelMargin = a.innerLabelMargin < -1 || a.innerLabelMargin > 1 ? a.innerLabelMargin : a.innerLabelMargin * a.outerRadius, a.percentage = a.value * l;
                    var c = a.value * k;
                    return a.degree = {
                        angle: c,
                        start: f,
                        end: c + f
                    }, a.rad = {
                        angle: g.toRad(a.degree.angle, !0),
                        start: g.toRad(a.degree.start, !0),
                        end: g.toRad(a.degree.end, !0)
                    }, a.middleangle = (a.rad.start + a.rad.end) / 2, f = a.degree.end, a
                }), i -= j, b
            }), this._series
        },
        updateLegend: function() {
            var a = this._series;
            this.elLegendItems.textContent = "";
            var b = 0,
                c = parseInt(this.model.attr(".legend-serie text/font-size"), 10),
                d = parseInt(this.model.attr(".legend-slice text/font-size"), 10);
            _.each(a, function(a, e) {
                if (a.showLegend) {
                    if (a.label) {
                        var f = this.elLegendSerie.clone();
                        a.name && f.addClass(a.name), f.attr({
                            "data-serie": e
                        }), f.findOne("text").text(a.label), f.translate(0, b), V(this.elLegendItems).append(f), b += c + a.labelLineHeight
                    }
                    _.each(a.data, function(a, c) {
                        var f = this.elLegendSlice.clone(),
                            g = this.getSliceFillColor(c, e);
                        a.name && f.addClass(a.name), f.attr({
                            "data-serie": e,
                            "data-slice": c
                        }), f.findOne("circle").attr({
                            fill: g
                        }), f.findOne("text").text(joint.util.format.string(a.legendLabel, a)), f.findOne("text").translate(a.legendLabelMargin), f.translate(0, b), b += d + a.legendLabelLineHeight, V(this.elLegendItems).append(f), _.isObject(g) && this.applyGradient("#" + f.findOne("circle").attr("id"), "fill", g)
                    }, this)
                }
            }, this)
        },
        updateSlice: function(a) {
            var b = this.elSlice.clone();
            V(this.elPie).append(b);
            var c = this.elSliceFill.clone(),
                d = this.getSliceFillColor(a.sliceIndex, a.serieIndex);
            c.attr({
                fill: d,
                d: V.createSlicePathData(a.innerRadius, a.outerRadius, a.rad.start, a.rad.end)
            }), b.append(c), _.isObject(d) && this.applyGradient("#" + c.attr("id"), "fill", d);
            var e = this.elSliceBorder.clone(),
                f = parseInt(this.model.attr(".slice > .slice-border/stroke-width"), 10),
                h = g.point.fromPolar(a.outerRadius + f / 2, -a.rad.start, g.point(0, 0)),
                i = g.point.fromPolar(a.outerRadius + f / 2, -a.rad.end, g.point(0, 0));
            e.attr({
                stroke: d,
                d: this.drawArc(h, i, a.outerRadius + f / 2, a.rad.start, a.rad.end)
            }), b.append(e), _.isObject(d) && this.applyGradient("#" + e.attr("id"), "stroke", d);
            var j = this.elSliceInnerLabel.clone();
            j.text(joint.util.format.string(a.innerLabel, a)), b.append(j);
            var k = j.bbox(),
                l = a.outerRadius - k.width / 2 - a.innerLabelMargin;
            j.translate(l * Math.cos(-a.middleangle), -l * Math.sin(-a.middleangle)), b.attr({
                "data-serie": a.serieIndex,
                "data-slice": a.sliceIndex,
                "data-value": a.value
            });
            var m = this._series[a.serieIndex].name;
            return m && b.addClass(m), a.name && b.addClass(a.name), b.addClass("serie-" + a.serieIndex + " slice-" + a.sliceIndex), a.isOuter && (b.addClass("outer"), a.offset && (b.addClass("clicked"), this.effectOnSlice(b, a, {
                type: "offset",
                offset: a.offset
            }))), b
        },
        getSliceFillColor: function(a, b) {
            b = b || 0;
            var c = this.model.get("attrs"),
                d = _.find(c, function(c, d) {
                    return d.indexOf(".serie-" + b + ".slice-" + a + " > .slice-fill") > -1
                });
            return d ? d.fill : this._series[b].data[a].fill
        },
        onMouseMoveSlice: function(a) {
            var b = V(a.currentTarget),
                c = b.attr("data-serie"),
                d = b.attr("data-slice"),
                e = this._series[c].data[d];
            this.trigger(a.type, e, a)
        },
        mouseOverSlice: function(a, b) {
            b = b || 0;
            var c = V(this.$('.slice[data-serie="' + b + '"][data-slice="' + a + '"]')[0]),
                d = this._series[b].data[a];
            c.toggleClass("hover"), d.isOuter && !_.isEmpty(d.onHoverEffect) && this.effectOnSlice(c, d, d.onHoverEffect, !c.hasClass("hover"));
            var e = V(this.$('.legend-slice[data-serie="' + b + '"][data-slice="' + a + '"]')[0]);
            e && e.toggleClass("hover");
            var f = _.filter(_.keys(this.model.get("attrs")), function(a) {
                return a.indexOf(".slice") > -1 || a.indexOf(".legend-slice") > -1
            });
            joint.dia.ElementView.prototype.update.call(this, this.model, _.pick(this.model.get("attrs"), f))
        },
        onMouseOverSlice: function(a) {
            var b = V(a.currentTarget),
                c = b.attr("data-serie"),
                d = b.attr("data-slice");
            this.mouseOverSlice(d, c);
            var e = this._series[c].data[d];
            this.trigger(a.type, e, a)
        },
        clickSlice: function(a, b) {
            b = b || 0;
            var c = V(this.$('.slice[data-serie="' + b + '"][data-slice="' + a + '"]')[0]),
                d = this._series[b].data[a];
            d.isOuter && (c.hasClass("clicked") ? (c.removeClass("clicked"), this.model.get("series")[b].data[a].offset = 0, this.effectOnSlice(c, d, d.onClickEffect, !0)) : (c.addClass("clicked"), this.model.get("series")[b].data[a].offset = d.onClickEffect.offset, this.effectOnSlice(c, d, d.onClickEffect)))
        },
        onClickSlice: function(a) {
            var b = V($(a.target).closest(".slice.outer")[0]);
            if (b) {
                var c = b.attr("data-serie"),
                    d = b.attr("data-slice");
                this.clickSlice(d, c);
                var e = this._series[c].data[d];
                this.trigger(a.type, e, a)
            }
        },
        onEventLegendItem: function(a) {
            var b = V($(a.target).closest(".legend-slice")[0]);
            if (b) {
                var c = b.attr("data-serie"),
                    d = b.attr("data-slice");
                switch (a.type) {
                    case "click":
                        this.clickSlice(d, c);
                        break;
                    case "mouseover":
                    case "mouseout":
                        this.mouseOverSlice(d, c)
                }
            }
        },
        effectOnSlice: function(a, b, c, d) {
            switch (d = d || !1, c.type) {
                case "enlarge":
                    d ? a.scale(1) : a.scale(c.scale || 1.05);
                    break;
                case "offset":
                    d ? a.translate(0, 0, {
                        absolute: !0
                    }) : a.translate(c.offset * Math.cos(-b.middleangle), -c.offset * Math.sin(-b.middleangle))
            }
        },
        svgArcMax: 2 * Math.PI - 1e-6,
        drawArc: function(a, b, c, d, e) {
            var f = 0,
                g = 1,
                h = e - d;
            return h > Math.PI && (f = 1, h >= this.svgArcMax && (f = 0, g = 0)), "M" + a.x + "," + a.y + " A" + c + "," + c + " 0 " + f + "," + g + " " + b.x + "," + b.y
        }
    }), joint.shapes.chart.Knob = joint.shapes.chart.Pie.extend({
        defaults: joint.util.deepSupplement({
            type: "chart.Knob",
            sliceDefaults: {
                legendLabel: "{value:.0f}",
                outer: {
                    offsetOnClick: 0
                }
            },
            pieHole: .7,
            value: 0,
            attrs: {
                ".legend": {
                    "ref-x": .5,
                    "ref-y": .5,
                    "x-alignment": -.9,
                    "y-alignment": -.4
                },
                ".legend-slice text": {
                    "font-size": 30
                },
                ".legend-slice circle": {
                    display: "none"
                },
                ".slice-inner-label": {
                    display: "none"
                },
                ".slice-fill": {
                    stroke: "none"
                }
            }
        }, joint.shapes.chart.Pie.prototype.defaults),
        initialize: function() {
            this.set("series", this.getKnobSeries(), {
                silent: !0
            }), joint.shapes.chart.Pie.prototype.initialize.apply(this, arguments), this.on("change:value change:min change:max change:fill", this.updateKnob, this)
        },
        getKnobSeries: function() {
            var a = _.isArray(this.get("value")) ? this.get("value") : [this.get("value")],
                b = _.isArray(this.get("fill")) ? this.get("fill") : [this.get("fill")],
                c = _.isArray(this.get("min")) ? this.get("min") : [this.get("min")],
                d = _.isArray(this.get("max")) ? this.get("max") : [this.get("max")],
                e = _.map(a, function(a, e) {
                    var f = _.isUndefined(c[e]) ? c[0] : c[e],
                        h = _.isUndefined(d[e]) ? d[0] : d[e],
                        i = _.isUndefined(b[e]) ? b[0] : b[e];
                    return {
                        degree: g.scale.linear([f, h], [0, 360], a),
                        data: [{
                            value: a,
                            fill: i
                        }],
                        showLegend: !(e > 0)
                    }
                });
            return e
        },
        updateKnob: function() {
            this.set("series", this.getKnobSeries())
        }
    }), joint.shapes.chart.KnobView = joint.shapes.chart.PieView, joint.shapes.chart.Matrix = joint.shapes.basic.Generic.extend({
        markup: ['<g class="rotatable">', '<g class="scalable">', '<g class="background"><rect/></g>', '<g class="cells"/>', '<g class="foreground"/>', "</g>", '<g class="labels">', '<g class="rows"/>', '<g class="columns"/>', "</g>", "</g>"].join(""),
        cellMarkup: '<rect class="cell"/>',
        labelMarkup: '<text class="label"/>',
        gridLineMarkup: '<path class="grid-line"/>',
        defaults: joint.util.deepSupplement({
            type: "chart.Matrix",
            attrs: {
                ".background rect": {
                    fill: "#eeeeee"
                },
                ".grid-line": {
                    stroke: "white",
                    "stroke-width": 2
                },
                ".label": {
                    fill: "black",
                    "alignment-baseline": "middle"
                },
                ".labels .rows .label": {
                    "text-anchor": "end"
                },
                ".labels .columns .label": {
                    "text-anchor": "start"
                }
            }
        }, joint.shapes.basic.Generic.prototype.defaults)
    }), joint.shapes.chart.MatrixView = joint.dia.ElementView.extend({
        initialize: function() {
            joint.dia.ElementView.prototype.initialize.apply(this, arguments), this.listenTo(this.model, "change:size", function() {
                this.renderLabels(), this.update()
            }), this.listenTo(this.model, "change:cells", function() {
                this.renderMarkup(), this.update()
            })
        },
        renderMarkup: function() {
            joint.dia.ElementView.prototype.renderMarkup.apply(this, arguments), this.elCells = this.$(".cells")[0], this.elRowLabels = this.$(".labels .rows")[0], this.elColumnLabels = this.$(".labels .columns")[0], this.elForeground = this.$(".foreground")[0], this.elCell = V(this.model.cellMarkup), this.elGridLine = V(this.model.gridLineMarkup);
            var a = this.model.get("cells") || [],
                b = this.model.get("size");
            this.elBackgroundRect = this.$(".background rect")[0], V(this.elBackgroundRect).attr(b);
            var c = b.height / a.length,
                d = b.width / a.length,
                e = document.createDocumentFragment();
            this.elCells.textContent = "", this.elForeground.textContent = "";
            for (var f, g, h, i, j, k = document.createDocumentFragment(), l = 0; l < a.length; l++)
                for (h = this.elGridLine.clone(), h.addClass("horizontal"), h.attr("d", "M 0 " + l * c + " " + b.width + " " + l * c), k.appendChild(h.node), f = a[l], g = 0; g < f.length; g++) 0 === l && (h = this.elGridLine.clone(), h.addClass("vertical"), h.attr("d", "M " + g * d + " 0 " + g * d + " " + b.height), k.appendChild(h.node)), i = f[g], i && (j = this.elCell.clone(), j.attr(_.extend({
                    x: g * d,
                    y: l * c,
                    width: d,
                    height: c
                }, i)), e.appendChild(j.node));
            this.elForeground.appendChild(k), this.elCells.appendChild(e), this.renderLabels()
        },
        renderLabels: function() {
            this.elLabel = V(this.model.labelMarkup);
            var a, b, c = this.model.get("cells") || [],
                d = this.model.get("labels") || {},
                e = d.rows || [],
                f = d.columns || [],
                g = this.model.get("size"),
                h = g.height / c.length,
                i = g.width / c.length;
            this.elRowLabels.textContent = "", this.elColumnLabels.textContent = "";
            for (var j = document.createDocumentFragment(), k = 0; k < e.length; k++) a = d.rows[k],
                b = this.elLabel.clone(), b.text(a.text), b.attr(_.extend({
                    x: -(d.padding || 5),
                    y: k * h + h / 2,
                    "text-anchor": "end",
                    "alignment-baseline": "middle",
                    "font-size": h,
                    "data-row": k
                }, _.omit(a, "text"))), j.appendChild(b.node);
            this.elRowLabels.appendChild(j);
            for (var l, m, n = document.createDocumentFragment(), o = 0; o < f.length; o++) a = d.columns[o], b = this.elLabel.clone(), b.text(a.text), l = o * i + i / 2, m = -(d.padding || 5), b.attr(_.extend({
                x: l,
                y: m,
                "text-anchor": "start",
                "alignment-baseline": "middle",
                "font-size": i,
                "data-column": o
            }, _.omit(a, "text"))), b.rotate(-90, l, m), n.appendChild(b.node);
            this.elColumnLabels.appendChild(n)
        }
    });
    joint.shapes.bpmn = {}, joint.shapes.bpmn.icons = {
        none: "",
        message: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/PjwhRE9DVFlQRSBzdmcgIFBVQkxJQyAnLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4nICAnaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkJz48c3ZnIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDUxMiA1MTIiIGhlaWdodD0iNTEycHgiIGlkPSJMYXllcl8xIiB2ZXJzaW9uPSIxLjEiIHZpZXdCb3g9IjAgMCA1MTIgNTEyIiB3aWR0aD0iNTEycHgiIHhtbDpzcGFjZT0icHJlc2VydmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiPjxwYXRoIGQ9Ik00NzkuOTk4LDY0SDMyQzE0LjMyOSw2NCwwLDc4LjMxMiwwLDk2djMyMGMwLDE3LjY4OCwxNC4zMjksMzIsMzIsMzJoNDQ3Ljk5OEM0OTcuNjcxLDQ0OCw1MTIsNDMzLjY4OCw1MTIsNDE2Vjk2ICBDNTEyLDc4LjMxMiw0OTcuNjcxLDY0LDQ3OS45OTgsNjR6IE00MTYsMTI4TDI1NiwyNTZMOTYsMTI4SDQxNnogTTQ0OCwzODRINjRWMTYwbDE5MiwxNjBsMTkyLTE2MFYzODR6Ii8+PC9zdmc+",
        plus: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/PjwhRE9DVFlQRSBzdmcgIFBVQkxJQyAnLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4nICAnaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkJz48c3ZnIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDI0IDI0IiBoZWlnaHQ9IjI0cHgiIGlkPSJMYXllcl8xIiB2ZXJzaW9uPSIxLjEiIHZpZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjI0cHgiIHhtbDpzcGFjZT0icHJlc2VydmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiPjxwYXRoIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTIyLjUsMTRIMTR2OC41YzAsMC4yNzYtMC4yMjQsMC41LTAuNSwwLjVoLTRDOS4yMjQsMjMsOSwyMi43NzYsOSwyMi41VjE0SDAuNSAgQzAuMjI0LDE0LDAsMTMuNzc2LDAsMTMuNXYtNEMwLDkuMjI0LDAuMjI0LDksMC41LDlIOVYwLjVDOSwwLjIyNCw5LjIyNCwwLDkuNSwwaDRDMTMuNzc2LDAsMTQsMC4yMjQsMTQsMC41VjloOC41ICBDMjIuNzc2LDksMjMsOS4yMjQsMjMsOS41djRDMjMsMTMuNzc2LDIyLjc3NiwxNCwyMi41LDE0eiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PC9zdmc+",
        cross: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/PjwhRE9DVFlQRSBzdmcgIFBVQkxJQyAnLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4nICAnaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkJz48c3ZnIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDI0IDI0IiBoZWlnaHQ9IjI0cHgiIGlkPSJMYXllcl8xIiB2ZXJzaW9uPSIxLjEiIHZpZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjI0cHgiIHhtbDpzcGFjZT0icHJlc2VydmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiPjxwYXRoIGQ9Ik0yMi4yNDUsNC4wMTVjMC4zMTMsMC4zMTMsMC4zMTMsMC44MjYsMCwxLjEzOWwtNi4yNzYsNi4yN2MtMC4zMTMsMC4zMTItMC4zMTMsMC44MjYsMCwxLjE0bDYuMjczLDYuMjcyICBjMC4zMTMsMC4zMTMsMC4zMTMsMC44MjYsMCwxLjE0bC0yLjI4NSwyLjI3N2MtMC4zMTQsMC4zMTItMC44MjgsMC4zMTItMS4xNDIsMGwtNi4yNzEtNi4yNzFjLTAuMzEzLTAuMzEzLTAuODI4LTAuMzEzLTEuMTQxLDAgIGwtNi4yNzYsNi4yNjdjLTAuMzEzLDAuMzEzLTAuODI4LDAuMzEzLTEuMTQxLDBsLTIuMjgyLTIuMjhjLTAuMzEzLTAuMzEzLTAuMzEzLTAuODI2LDAtMS4xNGw2LjI3OC02LjI2OSAgYzAuMzEzLTAuMzEyLDAuMzEzLTAuODI2LDAtMS4xNEwxLjcwOSw1LjE0N2MtMC4zMTQtMC4zMTMtMC4zMTQtMC44MjcsMC0xLjE0bDIuMjg0LTIuMjc4QzQuMzA4LDEuNDE3LDQuODIxLDEuNDE3LDUuMTM1LDEuNzMgIEwxMS40MDUsOGMwLjMxNCwwLjMxNCwwLjgyOCwwLjMxNCwxLjE0MSwwLjAwMWw2LjI3Ni02LjI2N2MwLjMxMi0wLjMxMiwwLjgyNi0wLjMxMiwxLjE0MSwwTDIyLjI0NSw0LjAxNXoiLz48L3N2Zz4=",
        user: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/PjwhRE9DVFlQRSBzdmcgIFBVQkxJQyAnLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4nICAnaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkJz48c3ZnIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDI0IDI0IiBoZWlnaHQ9IjI0cHgiIGlkPSJMYXllcl8xIiB2ZXJzaW9uPSIxLjEiIHZpZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjI0cHgiIHhtbDpzcGFjZT0icHJlc2VydmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiPjxwYXRoIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTIyLDIwLjk5OGgtMWMwLDAtMSwwLTEtMVYxNy41YzAtMC4yNzctMC4yMjQtMC41LTAuNS0wLjVTMTksMTcuMjIzLDE5LDE3LjUgIGwtMC4wMDgsNC4yOTVjMCwwLjYwOS0yLjAxLDIuMjA1LTYuNDkyLDIuMjA1cy02LjQ5Mi0xLjU5Ni02LjQ5Mi0yLjIwNUw2LDE3LjVDNiwxNy4yMjMsNS43NzYsMTcsNS41LDE3UzUsMTcuMjIzLDUsMTcuNXYyLjQ5OCAgYzAsMS0xLDEtMSwxSDNjMCwwLTEsMC0xLTFWMTUuNzVjMC0yLjkyMiwyLjg5Mi01LjQwMSw2LjkzLTYuMzQxYzAsMCwxLjIzNCwxLjEwNywzLjU3LDEuMTA3czMuNTctMS4xMDcsMy41Ny0xLjEwNyAgYzQuMDM4LDAuOTQsNi45MywzLjQxOSw2LjkzLDYuMzQxdjQuMjQ4QzIzLDIwLjk5OCwyMiwyMC45OTgsMjIsMjAuOTk4eiBNMTIuNDc3LDljLTIuNDg1LDAtNC41LTIuMDE1LTQuNS00LjVTOS45OTEsMCwxMi40NzcsMCAgczQuNSwyLjAxNSw0LjUsNC41UzE0Ljk2Miw5LDEyLjQ3Nyw5eiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PC9zdmc+",
        circle: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3gULEBE3DEP64QAAAwlJREFUaN7dmktrU0EUx38ZmmBbfEIL2hSjkYKC1EW6EDFudC+404/gE6WKSvGxERQfIH4AX1T9EOKrCrYurVrbgsZWoaBVixDbpC6ci+Fyz9ybZG478cBs7syc+Z+5c86c+c8ksCPrgW1ADtgEbARafG1+AW+AYWAIGADGWUTZAJwHxoD5GssocA7ILiTwLcADoFQHcH8pAfeB7jiBtwO3gLJF4P5S1mO02wa/C5iMEbi/TAI7bYE/Y3m5VLOs+sLAJULqrgKHIxhZBp4DT4FX2jkLGoinq1M7fg7YDmwFVATd14CjFboiy5UIs/QBOAmka/izaeCU1hE2zuVqlZ8IUfgVOAA0WViiTcBBrdM0Zm9UhTuAOYOiRzXOeJh0Ak8M484B+TAlK4BPBiU3gWSMoTqpw6g0fgFYblJww9D5dojT25IEcMeA47rUsdsQLp9FmPmURSNSOqpJS2lzUKd+ocN3IBNx5mz+oXXADwHTXX/jjMFxjy1iwtgrYJoF1lY27BMafozZaaMspYKA7XRlw7f1xt4Y5biA7bXXIGv4TW0OGNCmsQRhzCidlwTJADDlgAFTwAuhLq+AHqHyMe6IhKVHAV1C5ZBDBkhYupThPPreIQNGJTJBGXKLLw4Z8NmQu/Fb8PCkQwakBIxFRWPLvAJmhMpWh4AuFb7PKGBaqFzjkAGrhe/TSjNrQZJ1yAAJy5gCRoTKnEMGSFhGFDBoOBu7IhKWQe8wLRFLHQ6A7zCcFNNK59vvAjoqYK8DBuwTCLBhTUD8Hweahj9S2jjU297VqzrU26BVmi2yEjXRKg1PbHnpqYla7AeWxAi+GbhHHdSit2mYyN2XQQ5kQTJ6Y6qL3PUkCr2+H7v0+jcs0eueRLngGNeKa9mxY73g8JzpEtHusorAQ/7e+e7WUWIl//jSVTrK7QEu6KgW9d7tYr3B44iBWPJfkZZ8pZ4r2VngkC0HywMTLNwN5YSBcKtZWoGzernEBbyox2iJc6Np2KcGfnHisYet1CDouc2yCjbhp07MrD+3+QNxi4JkAscRswAAAABJRU5ErkJggg==",
        service: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAB1RJREFUeNrMWltMVFcUHZAIRSAkSFACITRAVbQ/DVhHiRZC2y9jotFgqgmxKqShKdFCggZbEpP2h1Q/oLUg8GH0xy/LKwpDEEFsjKCM8kYkgAhTpggDMzCc7kX2mGF677w80J5khbnnntc+Zz/W2ReNxvsSQLhPWCBYGPhdTdjg7aBCCI/gVSfu+CHBfPz48ba7d+82AocOHfqT6mYIEV6Oua4CfE6YHxsbeyS49Pf3P6C6RYJ2vQTwVTtKHx+fXYRzhM0qTbYR/g4JCQmyVYSFhQXTHyMhUWXMzTzmTo3MorATHxH0eEXAriYrtCmNiop6tby8bLCdgNVqfR0ZGTlC735RaJ/EY+HhGSFhTVSIyg7CIO3mRHNzs44WOYydJuQQ/AjxhJ9hsFqt9qlwKElJSRB8nvAjIYYN+hucDMbCmMHBwZP03E/YLlUAKh8TnoSHh49NT0+vLG5paWk0JyfnPu9cJ8EUGho6cfTo0fbBwcFWRwH6+vpaYcy0yCk26Hb0zc7ObsFYaIOxaY5xqn9M2ClTgGw8wqM4LuzevXu6xMTEnitXrjTOz8/3Chfl7du3Ly5fvtyUkJDQrzRedXV1I2/KWZkCwCDrsMMWi+WV46Sk42+EhwV24VhnNpuHaY43NFct5pRtA7tw9BkZGQ/peVHIL+bDhw8/YrtKXJM4QOVrVNfV1TXKXr2d6mTK8EI+tk4KPrszNjY2mIJTiK+vb5iK+zX29vbqW1paLNRe7N271590PpF+hyq1hzpt3bpVTE5ODlDfFIU5FdfiTRxAkDKVlpY2QI2VVNvOHUIVXjJmUEcC6Rz7keGLffv2CdoMK5/AogzupCZA8aZNmwxkbEMKi18sKSmxqcF1QjohmgF6UYl3LPw7GxoYGBAbN24U+fn5puLi4qWqqqoBGdwJxZ+J2ZeEXF6U9dixYw+VdLi1tbWJF3/aycBn0aa9vb3J1q++vl4EBARAfYRM7oTSwpFzjjAeExMznJ6e/mRkZORfAoA20Mn8Re3KFAaD9zpH2MzP13GK1GcafSl+iIiICGEymd6Nh4BG7SbVNgNj8Zg7nQmwdPLkybahoaG22dnZbntu41i6u7sh7CzhM1fciZCKTUEf9M3KyhLJycnYBCGTO6FYmpqa3HKX5eXlDWysUW5wp0K0LSoqasvLyxP+/v7ixIkTQjZ3WhFAR8UbAdzgTmY/Pz9rfHy8KCgoEKOjo0I2d1pxzxhAr9e3GI3GZ87ogp0KpbriTrdv3+6ghS9XVlYaFxYWxFpxJ5QaltxMeAOOf+DAgQ4VI55mIy53hzuRx7GuNXfSsM5FwJURzhBK3HSjZ/8P3MmrQIYgxUJUcvDKx/OtW7c61ps7ObtSziHiqlEJ0AU+VqgfPI8lOjraajAYVNUGKgg7Kisra4RDwG9bnFAqZMTjcBBI3ziLA0ovQPL0cXFxg6STU84W1NPT8+DSpUtt8DY3btwwqqm2p9zJ1q+wsBAqC7uL9EQA3H+Fu+41NzdXkPELMmQhizvZeSc9bQ5OucAtATiKLsAPK+0KXCKIWW1trSBSJjIzM8EwxYULF4RM7mRf0tLSnrCX/JXwLW9CLPO4VVfKcHAj4kMvldwZ6ojzr5CywMBAsWXLFrFnz54VmjAxMSE84U4KQqziTvYFapqSktIJnkbtXjNvW+DU5ioB8vDIOrlq7Xfu3GmgINNHl47lixcvIiO3QszsuY273ElFgFXcSSVGTBFfew7eBv4GHucoAHz6Y+I1r23UgFRmED6e1QD8XZBOW7zlTk4EgE28rKioaHBnbNgnPJ+vw8UGrO8rcoVzdJ2MqKmp0ZEbC7l58yaSWacJn0LqoKCgcc1/XOg0nHqhBDt6XI+TsXvnNXdycQJpUCHouzOagTkxN9/mrKqZAE7QgloEOtR7zZ1cCFABRqpkxNgIMuKnmIsvQGaOJ9UepzLelzupjJnlzI2mpqZ28KKvcspHy2vY4I0AMrhTDOMLQhXeXbt2zftAJikd7yl3AmZAxXFK3lIJH08lUUo++aBSo+ki7vQBGaHTRBjdwJ7TghGENFqtNoAuPTvUEmFkDxN0Z7ZSkBymvlqltUj5DOQpd/Kk4HbG6pct5fuYp9xJQlk8depUK1/8P5EqgDvcydPV4g6gVMcutNmWd5IlgEvuhA8ixJl63LjU64uKinS4g+AW5niauE+wKn0vUwB3uNMcvM+RI0faQcKU0ioHDx60pVWMtmQWvj9jLFtaBXNwWmWXbBvYThiAO8TO8UIMHHAQaOIIPyEQ7d+/v9NRgN27d3exfv/AhG4D9zVgLIzJ7heJrW3SjdgVd7Jr8zsybfZUATyKU4tXVXKt9Txml2pqUdbXdDXuZPf+OySPkX+1CQBixtzmjEqfQL6tJaqtxU/ix3I9n4JaeUEInZmZGSHasVIxNTU1wx9TulTGNNGf35zN67eOFL6X4Hv+/Hkr3aN14PNEPYL5atgvjde4+1HBy3/PaXb49xwwzD/eZyP/EWAAQ3AUnjpOYHIAAAAASUVORK5CYII="
    }, joint.shapes.bpmn.IconInterface = {
        initialize: function() {
            this._parent = (this._parent || this).constructor.__super__, this._parent.initialize.apply(this, arguments), this.listenTo(this, "change:icon", this._onIconChange), this._onIconChange(this, this.get("icon") || "none")
        },
        _onIconChange: function(a, b) {
            var c = joint.shapes.bpmn.icons;
            if (!_.has(c, b)) throw "BPMN: Unknown icon: " + b;
            a.attr("image/xlink:href", c[b])
        }
    }, joint.shapes.bpmn.SubProcessInterface = {
        initialize: function() {
            this._parent = (this._parent || this).constructor.__super__, this._parent.initialize.apply(this, arguments), this.listenTo(this, "change:subProcess", this._onSubProcessChange), this._onSubProcessChange(this, this.get("subProcess") || null)
        },
        _onSubProcessChange: function(a, b) {
            a.attr({
                ".sub-process": {
                    visibility: b ? "visible" : "hidden",
                    "data-sub-process": b || ""
                }
            })
        }
    }, joint.shapes.bpmn.ActivityView = joint.shapes.basic.TextBlockView, joint.shapes.bpmn.Activity = joint.shapes.basic.TextBlock.extend({
        markup: ['<g class="rotatable">', '<g class="scalable"><rect class="body outer"/><rect class="body inner"/></g>', joint.env.test("svgforeignobject") ? '<foreignObject class="fobj"><body xmlns="http://www.w3.org/1999/xhtml"><div class="content"/></body></foreignObject>' : '<text class="content"/>', '<path class="sub-process"/><image class="icon"/></g>'].join(""),
        defaults: joint.util.deepSupplement({
            size: {
                width: 100,
                height: 100
            },
            type: "bpmn.Activity",
            attrs: {
                rect: {
                    rx: 8,
                    ry: 8,
                    width: 100,
                    height: 100
                },
                ".body": {
                    fill: "#ffffff",
                    stroke: "#000000"
                },
                ".inner": {
                    transform: "scale(0.9,0.9) translate(5,5)"
                },
                path: {
                    d: "M 0 0 L 30 0 30 30 0 30 z M 15 4 L 15 26 M 4 15 L 26 15",
                    ref: ".inner",
                    "ref-x": .5,
                    "ref-dy": -30,
                    "x-alignment": "middle",
                    stroke: "#000000",
                    fill: "transparent"
                },
                image: {
                    ref: ".inner",
                    "ref-x": 5,
                    width: 20,
                    height: 20
                }
            },
            activityType: "task",
            subProcess: null
        }, joint.shapes.basic.TextBlock.prototype.defaults),
        initialize: function() {
            joint.shapes.basic.TextBlock.prototype.initialize.apply(this, arguments), this.listenTo(this, "change:activityType", this.onActivityTypeChange), this.listenTo(this, "change:subProcess", this.onSubProcessChange), this.onSubProcessChange(this, this.get("subProcess")), this.onActivityTypeChange(this, this.get("activityType"))
        },
        onActivityTypeChange: function(a, b) {
            switch (b) {
                case "task":
                    a.attr({
                        ".inner": {
                            visibility: "hidden"
                        },
                        ".outer": {
                            "stroke-width": 1,
                            "stroke-dasharray": "none"
                        },
                        path: {
                            ref: ".outer"
                        },
                        image: {
                            ref: ".outer"
                        }
                    });
                    break;
                case "transaction":
                    a.attr({
                        ".inner": {
                            visibility: "visible"
                        },
                        ".outer": {
                            "stroke-width": 1,
                            "stroke-dasharray": "none"
                        },
                        path: {
                            ref: ".inner"
                        },
                        image: {
                            ref: ".inner"
                        }
                    });
                    break;
                case "event-sub-process":
                    a.attr({
                        ".inner": {
                            visibility: "hidden"
                        },
                        ".outer": {
                            "stroke-width": 1,
                            "stroke-dasharray": "1,2"
                        },
                        path: {
                            ref: ".outer"
                        },
                        image: {
                            ref: ".outer"
                        }
                    });
                    break;
                case "call-activity":
                    a.attr({
                        ".inner": {
                            visibility: "hidden"
                        },
                        ".outer": {
                            "stroke-width": 5,
                            "stroke-dasharray": "none"
                        },
                        path: {
                            ref: ".outer"
                        },
                        image: {
                            ref: ".outer"
                        }
                    });
                    break;
                default:
                    throw "BPMN: Unknown Activity Type: " + b
            }
        },
        onSubProcessChange: function(a, b) {
            b ? a.attr({
                ".fobj div": {
                    style: {
                        verticalAlign: "baseline",
                        paddingTop: 10
                    }
                },
                image: {
                    "ref-dy": -25,
                    "ref-y": ""
                },
                text: {
                    "ref-y": 25
                }
            }) : a.attr({
                ".fobj div": {
                    style: {
                        verticalAlign: "middle",
                        paddingTop: 0
                    }
                },
                image: {
                    "ref-dy": "",
                    "ref-y": 5
                },
                text: {
                    "ref-y": .5
                }
            })
        }
    }).extend(joint.shapes.bpmn.IconInterface).extend(joint.shapes.bpmn.SubProcessInterface), joint.shapes.bpmn.AnnotationView = joint.shapes.basic.TextBlockView, joint.shapes.bpmn.Annotation = joint.shapes.basic.TextBlock.extend({
        markup: ['<g class="rotatable">', '<g class="scalable"><rect class="body"/></g>', joint.env.test("svgforeignobject") ? '<foreignObject class="fobj"><body xmlns="http://www.w3.org/1999/xhtml"><div class="content"/></body></foreignObject>' : '<text class="content"/>', '<path class="stroke"/></g>'].join(""),
        defaults: joint.util.deepSupplement({
            size: {
                width: 100,
                height: 100
            },
            type: "bpmn.Annotation",
            attrs: {
                rect: {
                    width: 100,
                    height: 100
                },
                ".body": {
                    "fill-opacity": .1,
                    fill: "#ffffff",
                    stroke: "none"
                },
                ".fobj div": {
                    style: {
                        textAlign: "left",
                        paddingLeft: 10
                    }
                },
                ".stroke": {
                    stroke: "#000000",
                    fill: "none",
                    "stroke-width": 3
                }
            },
            wingLength: 20
        }, joint.shapes.basic.TextBlock.prototype.defaults),
        initialize: function() {
            joint.shapes.basic.TextBlock.prototype.initialize.apply(this, arguments), this.listenTo(this, "change:size", this.onSizeChange), this.onSizeChange(this, this.get("size"))
        },
        onSizeChange: function(a, b) {
            a.attr(".stroke", {
                d: a.getStrokePathData(b.width, b.height, a.get("wingLength"))
            })
        },
        getStrokePathData: function(a, b, c) {
            return c = Math.min(c, a), ["M", c, "0 L 0 0 0", b, c, b].join(" ")
        }
    }), joint.shapes.bpmn.Gateway = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><polygon class="body"/><image/></g></g><text class="label"/>',
        defaults: joint.util.deepSupplement({
            type: "bpmn.Gateway",
            size: {
                width: 80,
                height: 80
            },
            attrs: {
                ".body": {
                    points: "40,0 80,40 40,80 0,40",
                    fill: "#ffffff",
                    stroke: "#000000"
                },
                ".label": {
                    text: "",
                    ref: ".body",
                    "ref-x": .5,
                    "ref-dy": 20,
                    "y-alignment": "middle",
                    "x-alignment": "middle",
                    "font-size": 14,
                    "font-family": "Arial, helvetica, sans-serif",
                    fill: "#000000"
                },
                image: {
                    width: 40,
                    height: 40,
                    "xlink:href": "",
                    transform: "translate(20,20)"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }).extend(joint.shapes.bpmn.IconInterface), joint.shapes.bpmn.Event = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><circle class="body outer"/><circle class="body inner"/><image/></g><text class="label"/></g>',
        defaults: joint.util.deepSupplement({
            type: "bpmn.Event",
            size: {
                width: 60,
                height: 60
            },
            attrs: {
                ".body": {
                    fill: "#ffffff",
                    stroke: "#000000"
                },
                ".outer": {
                    "stroke-width": 1,
                    r: 30,
                    transform: "translate(30,30)"
                },
                ".inner": {
                    "stroke-width": 1,
                    r: 26,
                    transform: "translate(30,30)"
                },
                image: {
                    width: 40,
                    height: 40,
                    "xlink:href": "",
                    transform: "translate(10,10)"
                },
                ".label": {
                    text: "",
                    fill: "#000000",
                    "font-family": "Arial",
                    "font-size": 14,
                    ref: ".outer",
                    "ref-x": .5,
                    "ref-dy": 20,
                    "x-alignment": "middle",
                    "y-alignment": "middle"
                }
            },
            eventType: "start"
        }, joint.dia.Element.prototype.defaults),
        initialize: function() {
            joint.dia.Element.prototype.initialize.apply(this, arguments), this.listenTo(this, "change:eventType", this.onEventTypeChange), this.onEventTypeChange(this, this.get("eventType"))
        },
        onEventTypeChange: function(a, b) {
            switch (b) {
                case "start":
                    a.attr({
                        ".inner": {
                            visibility: "hidden"
                        },
                        ".outer": {
                            "stroke-width": 1
                        }
                    });
                    break;
                case "end":
                    a.attr({
                        ".inner": {
                            visibility: "hidden"
                        },
                        ".outer": {
                            "stroke-width": 5
                        }
                    });
                    break;
                case "intermediate":
                    a.attr({
                        ".inner": {
                            visibility: "visible"
                        },
                        ".outer": {
                            "stroke-width": 1
                        }
                    });
                    break;
                default:
                    throw "BPMN: Unknown Event Type: " + b
            }
        }
    }).extend(joint.shapes.bpmn.IconInterface), joint.shapes.bpmn.Pool = joint.dia.Element.extend({
        markup: ['<g class="rotatable">', '<g class="scalable"><rect class="body"/></g>', '<svg overflow="hidden" class="blackbox-wrap"><text class="blackbox-label"/></svg>', '<rect class="header"/><text class="label"/>', '<g class="lanes"/>', "</g>"].join(""),
        laneMarkup: '<g class="lane"><rect class="lane-body"/><rect class="lane-header"/><text class="lane-label"/></g>',
        defaults: joint.util.deepSupplement({
            type: "bpmn.Pool",
            size: {
                width: 600,
                height: 300
            },
            attrs: {
                ".body": {
                    fill: "#ffffff",
                    stroke: "#000000",
                    width: 500,
                    height: 200,
                    "pointer-events": "stroke"
                },
                ".header": {
                    fill: "#ffffff",
                    stroke: "#000000",
                    width: 20,
                    ref: ".body",
                    "ref-height": 1,
                    "pointer-events": "visiblePainted"
                },
                ".label": {
                    fill: "#000000",
                    transform: "rotate(-90)",
                    ref: ".header",
                    "ref-x": 10,
                    "ref-y": .5,
                    "font-family": "Arial",
                    "font-size": 14,
                    "x-alignment": "middle",
                    "text-anchor": "middle"
                },
                ".lane-body": {
                    fill: "#ffffff",
                    stroke: "#000000",
                    "pointer-events": "stroke"
                },
                ".lane-header": {
                    fill: "#ffffff",
                    stroke: "#000000",
                    "pointer-events": "visiblePainted"
                },
                ".lane-label": {
                    fill: "#000000",
                    transform: "rotate(-90)",
                    "text-anchor": "middle",
                    "font-family": "Arial",
                    "font-size": 13
                },
                ".blackbox-wrap": {
                    ref: ".body",
                    "ref-width": 1,
                    "ref-height": 1
                },
                ".blackbox-label": {
                    text: "Black Box",
                    "text-anchor": "middle",
                    transform: "translate(0,-7)"
                },
                ".blackbox-label > tspan": {
                    dx: "50%",
                    dy: "50%"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.bpmn.PoolView = joint.dia.ElementView.extend({
        options: {
            headerWidth: 20
        },
        initialize: function() {
            this.listenTo(this.model, "change:lanes", function(a, b) {
                this.renderLanes(b)
            }), joint.dia.ElementView.prototype.initialize.apply(this, arguments)
        },
        update: function() {
            return _.isUndefined(this.lanesAttrs) ? this.renderLanes(this.model.get("lanes")) : joint.dia.ElementView.prototype.update.call(this, this.model, _.merge({}, this.model.get("attrs"), this.lanesAttrs || {}))
        },
        renderMarkup: function() {
            joint.dia.ElementView.prototype.renderMarkup.apply(this, arguments), this.$lanes = this.$(".lanes"), this.laneMarkup = V(this.model.laneMarkup)
        },
        renderLanes: function(a) {
            a = a || {}, this.index = 0;
            var b = _.isUndefined(a.headerWidth) ? this.options.headerWidth : a.headerWidth;
            this.lanesAttrs = {
                ".header": {
                    width: b
                },
                ".label": {
                    text: a.label || ""
                }
            }, this.$lanes.empty(), a.sublanes && this.renderSublanes(a.sublanes, b, 0, 1, "lanes"), this.update(this.model, _.merge({}, this.model.get("attrs"), this.lanesAttrs))
        },
        renderSublanes: function(a, b, c, d, e) {
            var f = this.options.headerWidth,
                g = e + "/sublanes/",
                h = 1 / a.length * d;
            _.each(a, function(a, d) {
                var e = "lane" + this.index,
                    i = "." + e + " .lane-body",
                    j = "." + e + " .lane-header",
                    k = "." + e + " .lane-label";
                a.name && (e += " " + a.name);
                var l = g + d,
                    m = this.laneMarkup.clone().addClass(e).attr({
                        "data-lane-path": l,
                        "data-lane-index": this.index
                    });
                this.$lanes.append(m.node);
                var n = _.isUndefined(a.headerWidth) ? f : a.headerWidth,
                    o = c + h * d;
                this.lanesAttrs[i] = {
                    ref: ".body",
                    "ref-height": h,
                    "ref-width": -b,
                    "ref-x": b,
                    "ref-y": o
                }, this.lanesAttrs[j] = {
                    width: n,
                    ref: ".body",
                    "ref-height": h,
                    "ref-x": b,
                    "ref-y": o
                }, this.lanesAttrs[k] = {
                    text: a.label,
                    ref: j,
                    "ref-x": 10,
                    "ref-y": .5,
                    "x-alignment": "middle"
                }, this.index++, a.sublanes && this.renderSublanes(a.sublanes, b + n, o, h, l)
            }, this)
        }
    }), joint.shapes.bpmn.Group = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><rect class="body"/></g><rect class="label-rect"/><g class="label-group"><svg overflow="hidden" class="label-wrap"><text class="label"/></svg></g></g>',
        defaults: joint.util.deepSupplement({
            type: "bpmn.Group",
            size: {
                width: 200,
                height: 200
            },
            attrs: {
                ".body": {
                    width: 200,
                    height: 200,
                    stroke: "#000000",
                    "stroke-dasharray": "6,6",
                    "stroke-width": 2,
                    fill: "transparent",
                    rx: 15,
                    ry: 15,
                    "pointer-events": "stroke"
                },
                ".label-rect": {
                    ref: ".body",
                    "ref-width": .6,
                    "ref-x": .4,
                    "ref-y": -30,
                    height: 25,
                    fill: "#ffffff",
                    stroke: "#000000"
                },
                ".label-group": {
                    ref: ".label-rect",
                    "ref-x": 0,
                    "ref-y": 0
                },
                ".label-wrap": {
                    ref: ".label-rect",
                    "ref-width": 1,
                    "ref-height": 1
                },
                ".label": {
                    text: "",
                    x: "50%",
                    y: "1.3em",
                    "text-anchor": "middle",
                    "font-family": "Arial",
                    "font-size": 14,
                    fill: "#000000"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.bpmn.DataObject = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><polygon class="body"/></g><text class="label"/></g>',
        defaults: joint.util.deepSupplement({
            type: "bpmn.DataObject",
            size: {
                width: 60,
                height: 80
            },
            attrs: {
                ".body": {
                    points: "20,0 60,0 60,80 0,80 0,20 20,0 20,20 0,20",
                    stroke: "#000000",
                    fill: "#ffffff"
                },
                ".label": {
                    ref: ".body",
                    "ref-x": .5,
                    "ref-dy": 5,
                    text: "",
                    "text-anchor": "middle"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.bpmn.Conversation = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><polygon class="body"/></g><text class="label"/><path class="sub-process"/></g>',
        defaults: joint.util.deepSupplement({
            type: "bpmn.Conversation",
            size: {
                width: 100,
                height: 100
            },
            attrs: {
                ".body": {
                    points: "25,0 75,0 100,50 75,100 25,100 0,50",
                    stroke: "#000000",
                    fill: "#ffffff"
                },
                ".label": {
                    text: "",
                    ref: ".body",
                    "ref-x": .5,
                    "ref-dy": 5,
                    "text-anchor": "middle"
                },
                path: {
                    d: "M 0 0 L 30 0 30 30 0 30 z M 15 4 L 15 26 M 4 15 L 26 15",
                    ref: ".body",
                    "ref-x": .5,
                    "ref-dy": -30,
                    "x-alignment": "middle",
                    fill: "#ffffff",
                    stroke: "#000000",
                    "fill-opacity": 0
                }
            },
            conversationType: "conversation"
        }, joint.dia.Element.prototype.defaults),
        initialize: function() {
            joint.dia.Element.prototype.initialize.apply(this, arguments), this.listenTo(this, "change:conversationType", this.onConversationTypeChange), this.onConversationTypeChange(this, this.get("conversationType"))
        },
        onConversationTypeChange: function(a, b) {
            switch (b) {
                case "conversation":
                    a.attr("polygon/stroke-width", 1);
                    break;
                case "call-conversation":
                    a.attr("polygon/stroke-width", 4);
                    break;
                default:
                    throw "BPMN: Unknown Conversation Type: " + b
            }
        }
    }).extend(joint.shapes.bpmn.SubProcessInterface), 
    joint.shapes.bpmn.Choreography = joint.shapes.basic.TextBlock.extend({
        markup: [
                 '<g class="rotatable">', 
                 '<g class="scalable"><rect class="body"/></g>', 
                 joint.env.test("svgforeignobject") ? '<foreignObject class="fobj"><body xmlns="http://www.w3.org/1999/xhtml"><div class="content"/></body></foreignObject>' : '<text class="content"/>', '<text class="label"/><path class="sub-process"/><g class="participants"/>', 
                 "</g>"
        ].join(""),
        participantMarkup: '<g class="participant"><rect class="participant-rect"/><text class="participant-label"/></g>',
        defaults: joint.util.deepSupplement({
            type: "bpmn.Choreography",
            size: {
                width: 60,
                height: 80
            },
            attrs: {
                rect: {},
                ".body": {
                    width: 60,
                    height: 80,
                    stroke: "#000000",
                    fill: "#ffffff"
                },
                ".label": {
                    ref: ".body",
                    "ref-x": .5,
                    "ref-dy": 5,
                    text: "",
                    "text-anchor": "middle"
                },
                ".participant-rect": {
                    stroke: "#000000",
                    fill: "#aaaaaa",
                    ref: ".body",
                    "ref-width": 1
                },
                ".participant-label": {
                    "text-anchor": "middle",
                    ref: ".participant_0 .participant-rect",
                    "ref-x": .5,
                    "ref-y": .5,
                    "y-alignment": "middle"
                },
                ".sub-process": {
                    d: "M 0 0 L 30 0 30 30 0 30 z M 15 4 L 15 26 M 4 15 L 26 15",
                    ref: ".body",
                    "ref-x": .5,
                    "ref-dy": -30,
                    "x-alignment": "middle",
                    fill: "transparent",
                    stroke: "#000000"
                }
            },
            participants: [],
            initiatingParticipant: 0
        }, joint.shapes.basic.TextBlock.prototype.defaults)
    }).extend(joint.shapes.bpmn.SubProcessInterface), 
    joint.shapes.bpmn.ChoreographyView = joint.shapes.basic.TextBlockView.extend({
        options: {
            participantHeight: 20
        },
        initialize: function() {
            this.listenTo(this.model, "change:participants", function(a, b) {
                this.renderParticipants(b)
            }), this.listenTo(this.model, "change:initiatingParticipant", this.layoutAndUpdate), joint.shapes.basic.TextBlockView.prototype.initialize.apply(this, arguments), joint.env.test("svgforeignobject") || this.stopListening(this.model, "change:content").listenTo(this.model, "change:content", function(a) {
                this.updateContent(a, this.participantsAttrs)
            })
        },
        update: function() {
            return _.isUndefined(this.participantsAttrs) ? this.renderParticipants(this.model.get("participants")) : (this.layoutAndUpdate(), this)
        },
        renderMarkup: function() {
            joint.dia.ElementView.prototype.renderMarkup.apply(this, arguments), this.$participants = this.$(".participants"), this.participantMarkup = V(this.model.participantMarkup)
        },
        renderParticipants: function(a) {
            this.$participants.empty(), this.participantsAttrs = {}, _.each(a, function(a, b) {
                var c = "participant_" + b,
                    d = "." + c;
                this.participantsAttrs[d + " .participant-rect"] = {
                    height: this.options.participantHeight
                }, this.participantsAttrs[d + " .participant-label"] = {
                    text: a
                }, this.$participants.append(this.participantMarkup.clone().addClass(c).node)
            }, this), this.layoutAndUpdate()
        },
        layoutAndUpdate: function() {
            var a = this.model.get("participants") || [],
                b = a.length,
                c = this.options.participantHeight,
                d = this.model.get("size").height,
                e = Math.max(0, d - c * b),
                f = 0,
                g = this.model.get("initiatingParticipant"),
                h = Math.max(_.isNumber(g) ? Math.abs(g) : a.indexOf(g), 0),
                i = Math.min(h, b - 2);
            _.each(a, function(a, b) {
                var d = ".participant_" + b;
                this.participantsAttrs[d] = {
                    transform: "translate(0," + f + ")"
                }, this.participantsAttrs[d + " .participant-rect"].fill = h == b ? this.model.attr(".body/fill") : this.model.attr(".participant-rect/fill"), this.participantsAttrs[d + " .participant-rect"].stroke = h == b ? this.model.attr(".body/stroke") : this.model.attr(".participant-rect/stroke"), f += c + (i == b ? e : 0)
            }, this);
            var j = b < 2 ? 0 : i - b + 1;
            this.participantsAttrs[".sub-process"] = {
                "ref-dy": Math.max(-d, j * c - 30)
            };
            var k = b < 2 ? 0 : i + 1;
            this.participantsAttrs[".fobj div"] = {
                style: {
                    height: e,
                    paddingTop: c * k
                }
            }, this.participantsAttrs[".content"] = {
                "ref-y": c * k + e / 2
            };
            var l = _.merge({}, this.model.get("attrs"), this.participantsAttrs || {});
            joint.shapes.basic.TextBlockView.prototype.update.call(this, this.model, l)
        }
    }), 
    joint.shapes.bpmn.Message = joint.dia.Element.extend({
        markup: '<g class="rotatable"><g class="scalable"><polygon class="body"/></g><text class="label"/></g>',
        defaults: joint.util.deepSupplement({
            type: "bpmn.Message",
            size: {
                width: 60,
                height: 40
            },
            attrs: {
                ".body": {
                    points: "0,0 60,0 60,40 0,40 0,0 60,0 30,20 0,0",
                    stroke: "#000000",
                    fill: "#ffffff"
                },
                ".label": {
                    ref: ".body",
                    "ref-x": .5,
                    "ref-dy": 5,
                    text: "",
                    "text-anchor": "middle"
                }
            }
        }, joint.dia.Element.prototype.defaults)
    }), joint.shapes.bpmn.Flow = joint.dia.Link.extend({
        defaults: {
            type: "bpmn.Flow",
            attrs: {
                ".marker-source": {
                    d: "M 0 0"
                },
                ".marker-target": {
                    d: "M 10 0 L 0 5 L 10 10 z",
                    fill: "#000000"
                },
                ".connection": {
                    "stroke-dasharray": " ",
                    "stroke-width": 1
                },
                ".connection-wrap": {
                    style: "",
                    onMouseOver: "",
                    onMouseOut: ""
                }
            },
            flowType: "normal"
        },
        initialize: function() {
            joint.dia.Link.prototype.initialize.apply(this, arguments), this.listenTo(this, "change:flowType", this.onFlowTypeChange), this.onFlowTypeChange(this, this.get("flowType"))
        },
        onFlowTypeChange: function(a, b) {
            var c;
            switch (b) {
                case "default":
                    c = {
                        ".marker-source": {
                            d: "M 0 5 L 20 5 M 20 0 L 10 10",
                            fill: "none"
                        }
                    };
                    break;
                case "conditional":
                    c = {
                        ".marker-source": {
                            d: "M 20 8 L 10 0 L 0 8 L 10 16 z",
                            fill: "#FFF"
                        }
                    };
                    break;
                case "normal":
                    c = {};
                    break;
                case "message":
                    c = {
                        ".marker-target": {
                            fill: "#FFF"
                        },
                        ".connection": {
                            "stroke-dasharray": "4,4"
                        }
                    };
                    break;
                case "association":
                    c = {
                        ".marker-target": {
                            d: "M 0 0"
                        },
                        ".connection": {
                            "stroke-dasharray": "4,4"
                        }
                    };
                    break;
                case "conversation":
                    c = {
                        ".marker-target": {
                            d: "M 0 0"
                        },
                        ".connection": {
                            "stroke-width": "7px"
                        },
                        ".connection-wrap": {
                            style: "stroke: #fff; stroke-width: 5px; opacity: 1;",
                            onMouseOver: "var s=this.style;s.stroke='#000';s.strokeWidth=15;s.opacity=.4",
                            onMouseOut: "var s=this.style;s.stroke='#fff';s.strokeWidth=5;s.opacity=1"
                        }
                    };
                    break;
                default:
                    throw "BPMN: Unknown Flow Type: " + b
            }
            a.attr(_.merge({}, this.defaults.attrs, c))
        }
    });
    joint.dia.CommandManager = Backbone.Model.extend({
        defaults: {
            cmdBeforeAdd: null,
            cmdNameRegex: /^(?:add|remove|change:\w+)$/,
            applyOptionsList: ["propertyPath"],
            revertOptionsList: ["propertyPath"]
        },
        PREFIX_LENGTH: 7,
        initialize: function(a) {
            _.bindAll(this, "initBatchCommand", "storeBatchCommand"), this.graph = a.graph, this.reset(), this.listen()
        },
        listen: function() {
            this.listenTo(this.graph, "all", this.addCommand, this), this.listenTo(this.graph, "batch:start", this.initBatchCommand, this), this.listenTo(this.graph, "batch:stop", this.storeBatchCommand, this)
        },
        createCommand: function(a) {
            var b = {
                action: void 0,
                data: {
                    id: void 0,
                    type: void 0,
                    previous: {},
                    next: {}
                },
                batch: a && a.batch
            };
            return b
        },
        push: function(a) {
            this.redoStack = [], a.batch ? (this.lastCmdIndex = Math.max(this.lastCmdIndex, 0), this.trigger("batch", a)) : (this.undoStack.push(a), this.trigger("add", a))
        },
        addCommand: function(a, b, c, d) {
            if ((!d || !d.dry) && this.get("cmdNameRegex").test(a) && ("function" != typeof this.get("cmdBeforeAdd") || this.get("cmdBeforeAdd").apply(this, arguments))) {
                var e = void 0,
                    f = b instanceof joint.dia.Graph;
                if (this.batchCommand) {
                    e = this.batchCommand[Math.max(this.lastCmdIndex, 0)];
                    var g = f && !e.graphChange || e.data.id !== b.id,
                        h = e.action !== a;
                    if (this.lastCmdIndex >= 0 && (g || h)) {
                        var i = _.findIndex(this.batchCommand, function(c, d) {
                            return (f && c.graphChange || c.data.id === b.id) && c.action === a
                        });
                        i < 0 || "add" === a || "remove" === a ? e = this.createCommand({
                            batch: !0
                        }) : (e = this.batchCommand[i], this.batchCommand.splice(i, 1)), this.lastCmdIndex = this.batchCommand.push(e) - 1
                    }
                } else e = this.createCommand({
                    batch: !1
                });
                if ("add" === a || "remove" === a) return e.action = a, e.data.id = b.id, e.data.type = b.attributes.type, e.data.attributes = _.merge({}, b.toJSON()), e.options = d || {}, void this.push(e);
                var j = a.substr(this.PREFIX_LENGTH);
                e.batch && e.action || (e.action = a, e.data.previous[j] = _.clone(b.previous(j)), e.options = d || {}, f ? e.graphChange = !0 : (e.data.id = b.id, e.data.type = b.attributes.type)), e.data.next[j] = _.clone(b.get(j)), this.push(e)
            }
        },
        initBatchCommand: function() {
            this.batchCommand ? this.batchLevel++ : (this.batchCommand = [this.createCommand({
                batch: !0
            })], this.lastCmdIndex = -1, this.batchLevel = 0)
        },
        storeBatchCommand: function() {
            if (this.batchCommand && this.batchLevel <= 0) {
                var a = this.filterBatchCommand(this.batchCommand);
                a.length > 0 && (this.redoStack = [], this.undoStack.push(a), this.trigger("add", a)), this.batchCommand = null, this.lastCmdIndex = null, this.batchLevel = null
            } else this.batchCommand && this.batchLevel > 0 && this.batchLevel--
        },
        filterBatchCommand: function(a) {
            for (var b = a.slice(), c = []; b.length > 0;) {
                var d = b.shift(),
                    e = d.data.id;
                if (null != d.action && (null != e || d.graphChange)) {
                    if ("add" === d.action) {
                        var f = _.findIndex(b, {
                            action: "remove",
                            data: {
                                id: e
                            }
                        });
                        if (f >= 0) {
                            b = _.reject(b, function(a, b) {
                                return b <= f && a.data.id === e
                            });
                            continue
                        }
                    } else if ("remove" === d.action) {
                        var g = _.findIndex(b, {
                            action: "add",
                            data: {
                                id: e
                            }
                        });
                        if (g >= 0) {
                            b.splice(g, 1);
                            continue
                        }
                    } else if (0 === d.action.indexOf("change") && _.isEqual(d.data.previous, d.data.next)) continue;
                    c.push(d)
                }
            }
            return c
        },
        revertCommand: function(a, b) {
            this.stopListening();
            var c;
            c = _.isArray(a) ? _.sortBy(a, this.constructor.batchCommandComparator) : [a];
            for (var d = this.graph, e = c.length - 1; e >= 0; e--) {
                var f = c[e],
                    g = f.graphChange ? d : d.getCell(f.data.id),
                    h = _.extend({
                        commandManager: this.id || this.cid
                    }, b, _.pick(f.options, this.get("revertOptionsList")));
                switch (f.action) {
                    case "add":
                        g.remove(h);
                        break;
                    case "remove":
                        d.addCell(f.data.attributes, h);
                        break;
                    default:
                        var i = f.action.substr(this.PREFIX_LENGTH);
                        g.set(i, f.data.previous[i], h)
                }
            }
            this.listen()
        },
        applyCommand: function(a, b) {
            this.stopListening();
            var c;
            c = _.isArray(a) ? _.sortBy(a, this.constructor.batchCommandComparator) : [a];
            for (var d = this.graph, e = 0; e < c.length; e++) {
                var f = c[e],
                    g = f.graphChange ? d : d.getCell(f.data.id),
                    h = _.extend({
                        commandManager: this.id || this.cid
                    }, b, _.pick(f.options, this.get("applyOptionsList")));
                switch (f.action) {
                    case "add":
                        d.addCell(f.data.attributes, h);
                        break;
                    case "remove":
                        g.remove(h);
                        break;
                    default:
                        var i = f.action.substr(this.PREFIX_LENGTH);
                        g.set(i, f.data.next[i], h)
                }
            }
            this.listen()
        },
        undo: function(a) {
            var b = this.undoStack.pop();
            b && (this.revertCommand(b, a), this.redoStack.push(b))
        },
        redo: function(a) {
            var b = this.redoStack.pop();
            b && (this.applyCommand(b, a), this.undoStack.push(b))
        },
        cancel: function(a) {
            this.hasUndo() && (this.revertCommand(this.undoStack.pop(), a), this.redoStack = [])
        },
        reset: function() {
            this.undoStack = [], this.redoStack = []
        },
        hasUndo: function() {
            return this.undoStack.length > 0
        },
        hasRedo: function() {
            return this.redoStack.length > 0
        }
    }, {
        batchCommandComparator: function(a, b, c) {
            if ("add" === a.action)
                for (var d = a.data.id, e = 0; e < b; e++)
                    if (c[e].data.id === d) return e - 1;
            return b
        }
    });
    joint.dia.Validator = Backbone.Model.extend({
        initialize: function(a) {
            this._map = {}, this._commandManager = a.commandManager, this.listenTo(this._commandManager, "add", this._onCommand)
        },
        defaults: {
            cancelInvalid: !0
        },
        _onCommand: function(a) {
            return _.isArray(a) ? _.find(a, function(a) {
                return !this._validateCommand(a)
            }, this) : this._validateCommand(a)
        },
        _validateCommand: function(a) {
            if (a.options && a.options.validation === !1) return !0;
            var b;
            return _.each(this._map[a.action], function(c) {
                function d(f) {
                    var g = c[e++];
                    try {
                        if (!g) return void(b = f);
                        g(f, a, d)
                    } catch (f) {
                        d(f)
                    }
                }
                var e = 0;
                d(b)
            }), !b || (this.get("cancelInvalid") && this._commandManager.cancel(), this.trigger("invalid", b), !1)
        },
        validate: function(a) {
            var b = Array.prototype.slice.call(arguments, 1);
            return _.each(b, function(b) {
                if (!_.isFunction(b)) throw new Error(a + " requires callback functions.")
            }), _.each(a.split(" "), function(a) {
                (this._map[a] = this._map[a] || []).push(b)
            }, this), this
        }
    });
    joint.dia.Graph.prototype.constructTree = function(a, b, c, d) {
        d = d || [];
        var e = _.isFunction(b.children) ? b.children(a) : a[b.children || "children"];
        return c || (c = b.makeElement(a), d.push(c)), _.each(e, function(a) {
            var e = b.makeElement(a),
                f = b.makeLink(c, e);
            d.push(e, f), this.constructTree(a, b, e, d)
        }, this), d
    }, joint.dia.Graph.prototype.shortestPath = function(a, b, c) {
        c = c || {};
        var d = {};
        _.each(this.getLinks(), function(a) {
            var b = a.get("source").id,
                e = a.get("target").id;
            d[b] || (d[b] = []), d[e] || (d[e] = []), d[b].push(e), c.directed || d[e].push(b)
        });
        var e = joint.alg.Dijkstra(d, a.id || a, c.weight),
            f = [],
            g = b.id || b;
        for (e[g] && f.push(g); g = e[g];) f.unshift(g);
        return f
    };
    joint.ui.PaperScroller = joint.mvc.View.extend({
        className: "paper-scroller",
        options: {
            paper: void 0,
            padding: function() {
                var a = Math.max(this.options.minVisiblePaperSize, 1) || 1,
                    b = {};
                return b.left = b.right = Math.max(this.el.clientWidth - a, 0), b.top = b.bottom = Math.max(this.el.clientHeight - a, 0), b
            },
            minVisiblePaperSize: 50,
            autoResizePaper: !1,
            baseWidth: void 0,
            baseHeight: void 0,
            contentOptions: void 0,
            cursor: "default"
        },
        _padding: {
            paddingLeft: 0,
            paddingTop: 0
        },
        init: function() {
            _.bindAll(this, "startPanning", "stopPanning", "pan", "onBackgroundEvent");
            var a = this.options.paper,
                b = V(a.viewport).scale();
            this._sx = b.sx, this._sy = b.sy, _.isUndefined(this.options.baseWidth) && (this.options.baseWidth = a.options.width), _.isUndefined(this.options.baseHeight) && (this.options.baseHeight = a.options.height), this.$background = $("<div/>").addClass("paper-scroller-background").css({
                width: a.options.width,
                height: a.options.height
            }).append(a.el).appendTo(this.el), this.listenTo(a, "scale", this.onScale), this.listenTo(a, "resize", this.onResize), this.listenTo(a, "beforeprint beforeexport", this.storeScrollPosition), this.listenTo(a, "afterprint afterexport", this.restoreScrollPosition), this.options.autoResizePaper && this.listenTo(a.model, "change add remove reset", this.adjustPaper), this.delegateBackgroundEvents(), this.setCursor(this.options.cursor)
        },
        setCursor: function(a) {
            switch (a) {
                case "grab":
                    this.$el.css("cursor", "");
                    break;
                default:
                    this.$el.css("cursor", a)
            }
            return this.$el.attr("data-cursor", a), this.options.cursor = a, this
        },
        delegateBackgroundEvents: function(a) {
            function b(a, b, c) {
                return c.indexOf(" ") === -1 && (a[c] = _.isFunction(b) ? b : this.options.paper[b]), a
            }

            function c(a, b) {
                this.delegate(b, {
                    guarded: !1
                }, this.onBackgroundEvent)
            }
            a || (a = _.result(this.options.paper, "events"));
            var d = this.paperEvents = _.reduce(a, _.bind(b, this), {});
            return _.each(d, _.bind(c, this)), this
        },
        onBackgroundEvent: function(a) {
            if (this.$background.is(a.target)) {
                var b = this.paperEvents[a.type];
                _.isFunction(b) && b.apply(this.options.paper, arguments)
            }
        },
        onResize: function() {
            this._center && this.center(this._center.x, this._center.y)
        },
        onScale: function(a, b, c, d) {
            this.adjustScale(a, b), this._sx = a, this._sy = b, (c || d) && this.center(c, d)
        },
        storeScrollPosition: function() {
            this._scrollLeftBeforePrint = this.el.scrollLeft, this._scrollTopBeforePrint = this.el.scrollTop
        },
        restoreScrollPosition: function() {
            this.el.scrollLeft = this._scrollLeftBeforePrint, this.el.scrollTop = this._scrollTopBeforePrint, this._scrollLeftBeforePrint = null, this._scrollTopBeforePrint = null
        },
        beforePaperManipulation: function() {
            this.$el.css("visibility", "hidden")
        },
        afterPaperManipulation: function() {
            this.$el.css("visibility", "visible")
        },
        toLocalPoint: function(a, b) {
            var c = this.options.paper.viewport.getCTM();
            return a += this.el.scrollLeft - this._padding.left - c.e, a /= c.a, b += this.el.scrollTop - this._padding.top - c.f, b /= c.d, g.point(a, b)
        },
        adjustPaper: function() {
            this._center = this.toLocalPoint(this.el.clientWidth / 2, this.el.clientHeight / 2);
            var a = _.extend({
                gridWidth: this.options.baseWidth,
                gridHeight: this.options.baseHeight,
                allowNewOrigin: "negative"
            }, this.options.contentOptions);
            return this.options.paper.fitToContent(this.transformContentOptions(a)), this
        },
        adjustScale: function(a, b) {
            var c = this.options.paper.options,
                d = a / this._sx,
                e = b / this._sy;
            this.options.paper.setOrigin(c.origin.x * d, c.origin.y * e), this.options.paper.setDimensions(c.width * d, c.height * e)
        },
        transformContentOptions: function(a) {
            var b = this._sx,
                c = this._sy;
            return a.gridWidth && (a.gridWidth *= b), a.gridHeight && (a.gridHeight *= c), a.minWidth && (a.minWidth *= b), a.minHeight && (a.minHeight *= c), _.isObject(a.padding) ? a.padding = {
                left: (a.padding.left || 0) * b,
                right: (a.padding.right || 0) * b,
                top: (a.padding.top || 0) * c,
                bottom: (a.padding.bottom || 0) * c
            } : _.isNumber(a.padding) && (a.padding = a.padding * b), a
        },
        center: function(a, b, c) {
            var d = this.options.paper.viewport.getCTM(),
                e = -d.e,
                f = -d.f,
                g = e + this.options.paper.options.width,
                h = f + this.options.paper.options.height;
            _.isUndefined(a) || _.isUndefined(b) ? (a = (e + g) / 2, b = (f + h) / 2) : (a *= d.a, b *= d.d);
            var i = this.getPadding(),
                j = this.el.clientWidth / 2,
                k = this.el.clientHeight / 2,
                l = j - i.left - a + e,
                m = j - i.right + a - g,
                n = k - i.top - b + f,
                o = k - i.bottom + b - h;
            return this.addPadding(Math.max(l, 0), Math.max(m, 0), Math.max(n, 0), Math.max(o, 0)), this.scroll(a, b, _.isUndefined(c) ? a || null : c), this
        },
        centerContent: function(a) {
            var b = V(this.options.paper.viewport).bbox(!0, this.options.paper.svg);
            return this.center(b.x + b.width / 2, b.y + b.height / 2, a), this
        },
        centerElement: function(a) {
            this.checkElement(a, "centerElement");
            var b = a.getBBox().center();
            return this.center(b.x, b.y)
        },
        scroll: function(a, b, c) {
            var d = this.options.paper.viewport.getCTM(),
                e = {};
            if (_.isNumber(a)) {
                var f = this.el.clientWidth / 2;
                e.scrollLeft = a - f + d.e + this._padding.left
            }
            if (_.isNumber(b)) {
                var g = this.el.clientHeight / 2;
                e.scrollTop = b - g + d.f + this._padding.top
            }
            c && c.animation ? this.$el.animate(e, c.animation) : this.$el.prop(e)
        },
        scrollToElement: function(a, b) {
            this.checkElement(a, "scrollToElement");
            var c = a.getBBox().center(),
                d = this._sx,
                e = this._sy;
            return c.x *= d, c.y *= e, this.scroll(c.x, c.y, b)
        },
        addPadding: function(a, b, c, d) {
            var e = this.getPadding(),
                f = this._padding = {
                    left: Math.round(e.left + (a || 0)),
                    top: Math.round(e.top + (c || 0)),
                    bottom: Math.round(e.bottom + (d || 0)),
                    right: Math.round(e.right + (b || 0))
                };
            return this.$background.css({
                width: f.left + this.options.paper.options.width + f.right,
                height: f.top + this.options.paper.options.height + f.bottom
            }), this.options.paper.$el.css({
                left: f.left,
                top: f.top
            }), this
        },
        zoom: function(a, b) {
            b = b || {};
            var c, d, e = this.toLocalPoint(this.el.clientWidth / 2, this.el.clientHeight / 2),
                f = a,
                g = a;
            if (b.absolute || (f += this._sx, g += this._sy), b.grid && (f = Math.round(f / b.grid) * b.grid, g = Math.round(g / b.grid) * b.grid), b.max && (f = Math.min(b.max, f), g = Math.min(b.max, g)), b.min && (f = Math.max(b.min, f), g = Math.max(b.min, g)), _.isUndefined(b.ox) || _.isUndefined(b.oy)) c = e.x, d = e.y;
            else {
                var h = f / this._sx,
                    i = g / this._sy;
                c = b.ox - (b.ox - e.x) / h, d = b.oy - (b.oy - e.y) / i
            }
            return this.beforePaperManipulation(), this.options.paper.scale(f, g), this.center(c, d), this.afterPaperManipulation(), this
        },
        zoomToFit: function(a) {
            a = a || {};
            var b = this.options.paper,
                c = _.clone(b.options.origin);
            return a.fittingBBox = a.fittingBBox || _.extend({}, g.point(c), {
                width: this.$el.width(),
                height: this.$el.height()
            }), this.beforePaperManipulation(), b.scaleContentToFit(a), b.setOrigin(c.x, c.y), this.adjustPaper().centerContent(), this.afterPaperManipulation(), this
        },
        startPanning: function(a) {
            a = joint.util.normalizeEvent(a), this._clientX = a.clientX, this._clientY = a.clientY, this.$el.addClass("is-panning"), this.trigger("pan:start", a), $(document.body).on({
                "mousemove.panning touchmove.panning": this.pan,
                "mouseup.panning touchend.panning": this.stopPanning
            }), $(window).on("mouseup.panning", this.stopPanning)
        },
        pan: function(a) {
            a = joint.util.normalizeEvent(a);
            var b = a.clientX - this._clientX,
                c = a.clientY - this._clientY;
            this.el.scrollTop -= c, this.el.scrollLeft -= b, this._clientX = a.clientX, this._clientY = a.clientY
        },
        stopPanning: function(a) {
            $(document.body).off(".panning"), $(window).off(".panning"), this.$el.removeClass("is-panning"), this.trigger("pan:stop", a)
        },
        getPadding: function() {
            var a = this.options.padding;
            return _.isFunction(a) && (a = a.call(this)), joint.util.normalizeSides(a)
        },
        getVisibleArea: function() {
            var a = this.options.paper.viewport.getCTM(),
                b = {
                    x: this.el.scrollLeft || 0,
                    y: this.el.scrollTop || 0,
                    width: this.el.clientWidth,
                    height: this.el.clientHeight
                },
                c = V.transformRect(b, a.inverse());
            return c.x -= (this._padding.left || 0) / this._sx, c.y -= (this._padding.top || 0) / this._sy, g.rect(c)
        },
        isElementVisible: function(a, b) {
            this.checkElement(a, "isElementVisible"), b = b || {};
            var c = b.strict ? "containsRect" : "intersect";
            return !!this.getVisibleArea()[c](a.getBBox())
        },
        isPointVisible: function(a) {
            return this.getVisibleArea().containsPoint(a)
        },
        checkElement: function(a, b) {
            if (!(a && a instanceof joint.dia.Element)) throw new TypeError("ui.PaperScroller." + b + "() accepts instance of joint.dia.Element only")
        },
        onRemove: function() {
            this.stopPanning()
        }
    });
    joint.ui.Selection = joint.mvc.View.extend({
        options: {
            paper: void 0,
            graph: void 0,
            boxContent: function(a) {
                return joint.util.template("<%= length %> elements selected.")({
                    length: this.model.length
                })
            },
            handles: [{
                name: "remove",
                position: "nw",
                events: {
                    pointerdown: "removeElements"
                }
            }, {
                name: "rotate",
                position: "sw",
                events: {
                    pointerdown: "startRotating",
                    pointermove: "doRotate",
                    pointerup: "stopBatch"
                }
            }, {
                name: "resize",
                position: "se",
                events: {
                    pointerdown: "startResizing",
                    pointermove: "doResize",
                    pointerup: "stopBatch"
                }
            }],
            useModelGeometry: !1,
            strictSelection: !1,
            rotateAngleGrid: 15,
            allowTranslate: !0
        },
        className: "selection",
        events: {
            "mousedown .selection-box": "onSelectionBoxPointerDown",
            "touchstart .selection-box": "onSelectionBoxPointerDown",
            "mousedown .handle": "onHandlePointerDown",
            "touchstart .handle": "onHandlePointerDown"
        },
        init: function() {
            this.options.model && (this.options.collection = this.options.model);
            var a = this.collection = this.options.collection || this.collection || new Backbone.Collection;
            if (a.comparator || (a.comparator = this.constructor.depthComparator, a.sort()), this.model = a, !this.options.paper) throw new Error("Selection: paper required");
            _.defaults(this.options, {
                graph: this.options.paper.model
            }), _.bindAll(this, "startSelecting", "stopSelecting", "adjustSelection", "pointerup"), $(document.body).on("mousemove.selection touchmove.selection", this.adjustSelection), $(document).on("mouseup.selection touchend.selection", this.pointerup);
            var b = this.options.paper,
                c = this.options.graph;
            this.listenTo(c, "reset", this.cancelSelection), this.listenTo(b, "scale translate", this.updateSelectionBoxes), this.listenTo(c, "remove change", function(a, b) {
                b.selection !== this.cid && this.updateSelectionBoxes()
            }), this.listenTo(a, "remove", this.onRemoveElement), this.listenTo(a, "reset", this.onResetElements), this.listenTo(a, "add", this.onAddElement), b.$el.append(this.$el), this._boxCount = 0, this.$selectionWrapper = this.createSelectionWrapper(), this.handles = [], _.each(this.options.handles, this.addHandle, this)
        },
        cancelSelection: function() {
            this.model.reset([], {
                ui: !0
            })
        },
        addHandle: function(a) {
            this.handles.push(a);
            var b = $("<div/>", {
                "class": "handle " + (a.position || "") + " " + (a.name || ""),
                "data-action": a.name
            });
            return a.icon && b.css("background-image", "url(" + a.icon + ")"), b.html(a.content || ""), joint.util.setAttributesBySelector(b, a.attrs), this.$selectionWrapper.append(b), _.each(a.events, function(b, c) {
                _.isString(b) ? this.on("action:" + a.name + ":" + c, this[b], this) : this.on("action:" + a.name + ":" + c, b)
            }, this), this
        },
        stopSelecting: function(a) {
            switch (this._action) {
                case "selecting":
                    var b = this.$el.offset(),
                        c = this.$el.width(),
                        d = this.$el.height(),
                        e = this.options.paper,
                        f = V(e.viewport).toLocalPoint(b.left, b.top);
                    f.x -= window.pageXOffset, f.y -= window.pageYOffset;
                    var h = V(e.viewport).scale();
                    c /= h.sx, d /= h.sy;
                    var i = g.rect(f.x, f.y, c, d),
                        j = this.getElementsInSelectedArea(i),
                        k = this.options.filter;
                    _.isArray(k) ? j = _.reject(j, function(a) {
                        return _.contains(k, a.model) || _.contains(k, a.model.get("type"))
                    }) : _.isFunction(k) && (j = _.reject(j, function(a) {
                        return k(a.model)
                    })), this.model.reset(_.pluck(j, "model"), {
                        ui: !0
                    });
                    break;
                case "translating":
                    this.options.graph.stopBatch("selection-translate"), this.notify("selection-box:pointerup", a);
                    break;
                default:
                    this._action || this.cancelSelection()
            }
            this._action = null
        },
        removeHandle: function(a) {
            var b = _.findIndex(this.handles, {
                    name: a
                }),
                c = this.handles[b];
            return c && (_.each(c.events, function(b, c) {
                this.off("action:" + a + ":" + c)
            }, this), this.$(".handle." + a).remove(), this.handles.splice(b, 1)), this
        },
        startSelecting: function(a) {
            a = joint.util.normalizeEvent(a), this.cancelSelection();
            var b, c, d = this.options.paper.el;
            if (null != a.offsetX && null != a.offsetY && $.contains(d, a.target)) b = a.offsetX, c = a.offsetY;
            else {
                var e = $(d).offset(),
                    f = d.scrollLeft,
                    g = d.scrollTop;
                b = a.clientX - e.left + window.pageXOffset + f, c = a.clientY - e.top + window.pageYOffset + g
            }
            this.$el.css({
                width: 1,
                height: 1,
                left: b,
                top: c
            }), this.showLasso(), this._action = "selecting", this._clientX = a.clientX, this._clientY = a.clientY, this._offsetX = b, this._offsetY = c
        },
        changeHandle: function(a, b) {
            var c = _.findWhere(this.handles, {
                name: a
            });
            return c && (this.removeHandle(a), this.addHandle(_.merge({
                name: a
            }, c, b))), this
        },
        onSelectionBoxPointerDown: function(a) {
            a.stopPropagation(), a = joint.util.normalizeEvent(a), this.options.allowTranslate && this.startTranslatingSelection(a), this._activeElementView = this.getCellView(a.target), this.notify("selection-box:pointerdown", a)
        },
        startTranslatingSelection: function(a) {
            this._action = "translating", this.options.graph.startBatch("selection-translate");
            var b = this.options.paper.snapToGrid({
                x: a.clientX,
                y: a.clientY
            });
            this._snappedClientX = b.x, this._snappedClientY = b.y
        },
        adjustSelection: function(a) {
            a = joint.util.normalizeEvent(a);
            var b, c;
            switch (this._action) {
                case "selecting":
                    b = a.clientX - this._clientX, c = a.clientY - this._clientY;
                    var d = parseInt(this.$el.css("left"), 10),
                        e = parseInt(this.$el.css("top"), 10);
                    this.$el.css({
                        left: b < 0 ? this._offsetX + b : d,
                        top: c < 0 ? this._offsetY + c : e,
                        width: Math.abs(b),
                        height: Math.abs(c)
                    });
                    break;
                case "translating":
                    var f = this.options.paper.snapToGrid({
                            x: a.clientX,
                            y: a.clientY
                        }),
                        g = f.x,
                        h = f.y;
                    if (b = g - this._snappedClientX, c = h - this._snappedClientY, b || c) {
                        if (this.translateSelectedElements(b, c), this.boxesUpdated) this.model.length > 1 && this.updateSelectionBoxes();
                        else {
                            var i = V(this.options.paper.viewport).scale();
                            this.$el.children(".selection-box").add(this.$selectionWrapper).css({
                                left: "+=" + b * i.sx,
                                top: "+=" + c * i.sy
                            })
                        }
                        this._snappedClientX = g, this._snappedClientY = h
                    }
                    this.notify("selection-box:pointermove", a);
                    break;
                default:
                    this._action && this.pointermove(a)
            }
            this.boxesUpdated = !1
        },
        translateSelectedElements: function(a, b) {
            var c = {};
            this.model.each(function(d) {
                if (!c[d.id]) {
                    var e = {
                        selection: this.cid
                    };
                    d.translate(a, b, e), _.each(d.getEmbeddedCells({
                        deep: !0
                    }), function(a) {
                        c[a.id] = !0
                    });
                    var f = this.options.graph.getConnectedLinks(d);
                    _.each(f, function(d) {
                        c[d.id] || (d.translate(a, b, e), c[d.id] = !0)
                    })
                }
            }, this)
        },
        notify: function(a, b) {
            var c = Array.prototype.slice.call(arguments, 1);
            this.trigger.apply(this, [a, this._activeElementView].concat(c))
        },
        getElementsInSelectedArea: function(a) {
            var b = this.options.paper,
                c = {
                    strict: this.options.strictSelection
                };
            if (this.options.useModelGeometry) {
                var d = b.model.findModelsInArea(a, c);
                return _.filter(_.map(d, b.findViewByModel, b))
            }
            return b.findViewsInArea(a, c)
        },
        pointerup: function(a) {
            this._action && (this.triggerAction(this._action, "pointerup", a), this.stopSelecting(a), this._activeElementView = null, this._action = null)
        },
        destroySelectionBox: function(a) {
            this.$('[data-model="' + a.get("id") + '"]').remove(), 0 === this.$el.children(".selection-box").length && this.hide(), this._boxCount = Math.max(0, this._boxCount - 1)
        },
        hide: function() {
            this.$el.removeClass("lasso selected")
        },
        showSelected: function() {
            this.$el.addClass("selected")
        },
        showLasso: function() {
            this.$el.addClass("lasso")
        },
        destroyAllSelectionBoxes: function() {
            this.hide(), this.$el.children(".selection-box").remove(), this._boxCount = 0
        },
        createSelectionBox: function(a) {
            var b = a.findView(this.options.paper);
            if (b) {
                var c = b.getBBox({
                    useModelGeometry: this.options.useModelGeometry
                });
                $("<div/>").addClass("selection-box").attr("data-model", a.get("id")).css({
                    left: c.x,
                    top: c.y,
                    width: c.width,
                    height: c.height
                }).appendTo(this.el), this.showSelected(), this._boxCount++
            }
        },
        createSelectionWrapper: function() {
            var a = $("<div/>", {
                    "class": "selection-wrapper"
                }),
                b = $("<div/>", {
                    "class": "box"
                });
            return a.append(b), a.attr("data-selection-length", this.model.length), this.$el.prepend(a), a
        },
        updateSelectionWrapper: function() {
            var a = {
                    x: 1 / 0,
                    y: 1 / 0
                },
                b = {
                    x: 0,
                    y: 0
                };
            if (this.model.each(function(c) {
                    var d = this.options.paper.findViewByModel(c);
                    if (d) {
                        var e = d.getBBox({
                            useModelGeometry: this.options.useModelGeometry
                        });
                        a.x = Math.min(a.x, e.x), a.y = Math.min(a.y, e.y), b.x = Math.max(b.x, e.x + e.width), b.y = Math.max(b.y, e.y + e.height)
                    }
                }, this), this.$selectionWrapper.css({
                    left: a.x,
                    top: a.y,
                    width: b.x - a.x,
                    height: b.y - a.y
                }).attr("data-selection-length", this.model.length), _.isFunction(this.options.boxContent)) {
                var c = this.$(".box"),
                    d = this.options.boxContent.call(this, c[0]);
                d && c.html(d)
            }
        },
        updateSelectionBoxes: function() {
            this._boxCount && (this.hide(), _.each(this.$el.children(".selection-box"), function(a) {
                var b = $(a).remove().attr("data-model"),
                    c = this.model.get(b);
                c && this.createSelectionBox(c)
            }, this), this.updateSelectionWrapper(), this.boxesUpdated = !0)
        },
        onRemove: function() {
            $(document.body).off(".selection", this.adjustSelection), $(document).off(".selection", this.pointerup)
        },
        onHandlePointerDown: function(a) {
            this._action = $(a.target).closest(".handle").attr("data-action"), this._action && (a.preventDefault(), a.stopPropagation(), a = joint.util.normalizeEvent(a), this._clientX = a.clientX, this._clientY = a.clientY, this._startClientX = this._clientX, this._startClientY = this._clientY, this.triggerAction(this._action, "pointerdown", a))
        },
        getCellView: function(a) {
            var b = this.model.get(a.getAttribute("data-model"));
            return b && b.findView(this.options.paper)
        },
        pointermove: function(a) {
            if (this._action) {
                var b = this.options.paper.snapToGrid({
                        x: a.clientX,
                        y: a.clientY
                    }),
                    c = this.options.paper.snapToGrid({
                        x: this._clientX,
                        y: this._clientY
                    }),
                    d = b.x - c.x,
                    e = b.y - c.y;
                this.triggerAction(this._action, "pointermove", a, d, e, a.clientX - this._startClientX, a.clientY - this._startClientY), this._clientX = a.clientX, this._clientY = a.clientY
            }
        },
        triggerAction: function(a, b, c) {
            var d = Array.prototype.slice.call(arguments, 2);
            d.unshift("action:" + a + ":" + b), this.trigger.apply(this, d)
        },
        onRemoveElement: function(a) {
            this.destroySelectionBox(a), this.updateSelectionWrapper()
        },
        onResetElements: function(a) {
            this.destroyAllSelectionBoxes(), a.each(this.createSelectionBox, this), this.updateSelectionWrapper()
        },
        onAddElement: function(a) {
            this.createSelectionBox(a), this.updateSelectionWrapper()
        },
        removeElements: function(a) {
            var b = this.collection.toArray();
            this.cancelSelection(), this.options.graph.removeCells(b, {
                selection: this.cid
            })
        },
        startRotating: function(a) {
            this.options.graph.trigger("batch:start");
            var b = this.options.graph.getBBox(this.model.models).center(),
                c = this.options.paper.snapToGrid({
                    x: a.clientX,
                    y: a.clientY
                }),
                d = _.transform(this.model.toArray(), function(a, b) {
                    a[b.id] = g.normalizeAngle(b.get("angle") || 0)
                });
            this._rotation = {
                center: b,
                clientAngle: g.point(c).theta(b),
                initialAngles: d
            }
        },
        startResizing: function(a) {
            var b = this.options.paper,
                c = this.options.graph,
                d = b.options.gridSize,
                e = this.model.toArray(),
                f = c.getBBox(e),
                g = _.invoke(e, "getBBox"),
                h = _.min(g, "width").width,
                i = _.min(g, "height").height;
            this._resize = {
                cells: c.getSubgraph(e),
                bbox: f,
                minWidth: d * f.width / h,
                minHeight: d * f.height / i
            }, c.trigger("batch:start")
        },
        doResize: function(a, b, c) {
            var d = this._resize,
                e = d.bbox,
                f = e.width,
                g = e.height,
                h = Math.max(f + b, d.minWidth),
                i = Math.max(g + c, d.minHeight);
            (Math.abs(f - h) > .001 || Math.abs(g - i) > .001) && (this.options.graph.resizeCells(h, i, d.cells, {
                selection: this.cid
            }), e.width = h, e.height = i, this.updateSelectionBoxes())
        },
        doRotate: function(a) {
            var b = this._rotation,
                c = this.options.rotateAngleGrid,
                d = this.options.paper.snapToGrid({
                    x: a.clientX,
                    y: a.clientY
                }),
                e = b.clientAngle - g.point(d).theta(b.center);
            Math.abs(e) > .001 && (this.model.each(function(a) {
                var d = g.snapToGrid(b.initialAngles[a.id] + e, c);
                a.rotate(d, !0, b.center, {
                    selection: this.cid
                })
            }, this), this.updateSelectionBoxes())
        },
        stopBatch: function() {
            this.options.graph.trigger("batch:stop")
        },
        getAction: function() {
            return this._action
        }
    }, {
        depthComparator: function(a) {
            return a.getAncestors().length
        }
    }), joint.ui.SelectionView = joint.ui.Selection;
    joint.ui.Clipboard = Backbone.Collection.extend({
        LOCAL_STORAGE_KEY: "joint.ui.Clipboard.cells",
        defaults: {
            useLocalStorage: !0
        },
        copyElements: function(a, b, c) {
            this.options = _.extend({}, this.defaults, c), c = this.options;
            var d = a.toArray(),
                e = _.sortBy(b.cloneSubgraph(d, c), function(a) {
                    return a.isLink() ? 2 : 1
                });
            return this.reset(e), c.useLocalStorage && window.localStorage && localStorage.setItem(this.LOCAL_STORAGE_KEY, JSON.stringify(this.toJSON())), d
        },
        cutElements: function(a, b, c) {
            var d = this.copyElements(a, b, c);
            return b.trigger("batch:start", {
                batchName: "cut"
            }), _.invoke(d, "remove"), b.trigger("batch:stop", {
                batchName: "cut"
            }), d
        },
        pasteCells: function(a, b) {
            if (b = _.defaults(b || {}, this.options), b.useLocalStorage && this.isEmpty() && window.localStorage) {
                var c = {
                        cells: JSON.parse(localStorage.getItem(this.LOCAL_STORAGE_KEY))
                    },
                    d = (new joint.dia.Graph).fromJSON(c, {
                        sort: !1
                    });
                this.reset(d.getCells())
            }
            var e = this.map(function(a) {
                return this.modifyCell(a, b)
            }, this);
            return a.trigger("batch:start", {
                batchName: "paste"
            }), a.addCells(e), a.trigger("batch:stop", {
                batchName: "paste"
            }), this.copyElements(this, a), e
        },
        clear: function() {
            this.options = {}, this.reset([]), window.localStorage && localStorage.removeItem(this.LOCAL_STORAGE_KEY)
        },
        modifyCell: function(a, b) {
            return a.unset("z"), a.isLink() && b.link && a.set(b.link), b.translate && a.translate(b.translate.dx || 20, b.translate.dy || 20), a.collection = null, a
        }
    });
    ! function(a, b) {
        "use strict";
        var c = function() {
            this.options = {
                handles: [{
                    name: "remove",
                    position: "nw",
                    events: {
                        pointerdown: "removeElement"
                    },
                    icon: null
                }, {
                    name: "direction",
                    position: "se",
                    events: {
                        pointerdown: "directionSwap"
                    },
                    icon: null
                }],
                bbox: function(a) {
                    var b = .5 * a.getConnectionLength();
                    return a.getPointAtLength(b)
                },
                typeCssName: "type-link",
                tinyThreshold: -1,
                smallThreshold: -1,
                boxContent: !1
            }
        };
        c.prototype.directionSwap = function() {
            var a = this.options.cellView.model;
            a.set({
                source: a.get("target"),
                target: a.get("source")
            }, {
                halo: this.cid
            })
        };
        var d = function() {
            this.options = {
                handles: [{
                    name: "remove",
                    position: "nw",
                    events: {
                        pointerdown: "removeElement"
                    },
                    icon: null
                }, {
                    name: "resize",
                    position: "se",
                    events: {
                        pointerdown: "startResizing",
                        pointermove: "doResize",
                        pointerup: "stopBatch"
                    },
                    icon: null
                }, {
                    name: "clone",
                    position: "n",
                    events: {
                        pointerdown: "startCloning",
                        pointermove: "doClone",
                        pointerup: "stopCloning"
                    },
                    icon: null
                }, {
                    name: "link",
                    position: "e",
                    events: {
                        pointerdown: "startLinking",
                        pointermove: "doLink",
                        pointerup: "stopLinking"
                    },
                    icon: null
                }, {
                    name: "fork",
                    position: "ne",
                    events: {
                        pointerdown: "startForking",
                        pointermove: "doFork",
                        pointerup: "stopForking"
                    },
                    icon: null
                }, {
                    name: "unlink",
                    position: "w",
                    events: {
                        pointerdown: "unlinkElement"
                    },
                    icon: null
                }, {
                    name: "rotate",
                    position: "sw",
                    events: {
                        pointerdown: "startRotating",
                        pointermove: "doRotate",
                        pointerup: "stopBatch"
                    },
                    icon: null
                }],
                bbox: function(a, b) {
                    return a.getBBox({
                        useModelGeometry: b.options.useModelGeometry
                    })
                },
                typeCssName: "type-element",
                tinyThreshold: 40,
                smallThreshold: 80,
                boxContent: function(b, c) {
                    var d = a.util.template("x: <%= x %>, y: <%= y %>, width: <%= width %>, height: <%= height %>, angle: <%= angle %>"),
                        e = this.getBBox();
                    return d({
                        x: Math.floor(e.x),
                        y: Math.floor(e.y),
                        width: Math.floor(e.width),
                        height: Math.floor(e.height),
                        angle: Math.floor(b.model.get("angle") || 0)
                    })
                },
                loopLinkPreferredSide: "top",
                loopLinkWidth: 40,
                rotateAngleGrid: 15,
                linkAttributes: {},
                smoothLinks: void 0
            }
        };
        d.prototype.startLinking = function(a, c, d) {
            this.startBatch();
            var e = this.options.cellView,
                f = $.data(a.target, "selector"),
                g = this.options.paper.getDefaultLink(e, f && e.el.querySelector(f));
            g.set("source", {
                id: e.model.id,
                selector: f
            }), g.set("target", {
                x: c,
                y: d
            }), g.attr(this.options.linkAttributes), b.isBoolean(this.options.smoothLinks) && g.set("smooth", this.options.smoothLinks), this.options.graph.addCell(g, {
                validation: !1,
                halo: this.cid,
                async: !1
            }), this._linkView = this.options.paper.findViewByModel(g), this._linkView.startArrowheadMove("target", {
                whenNotAllowed: "remove"
            })
        }, d.prototype.startForking = function(c, d, e) {
            var f = this.options;
            this.startBatch();
            var g = f.clone(f.cellView.model, {
                fork: !0
            });
            if (!(g instanceof a.dia.Cell)) throw new Error('ui.Halo: option "clone" has to return a cell.');
            var h = f.paper.getDefaultLink(f.cellView).set({
                source: {
                    id: f.cellView.model.id
                },
                target: {
                    id: g.id
                }
            });
            h.attr(f.linkAttributes), b.isBoolean(f.smoothLinks) && h.set("smooth", f.smoothLinks), this.centerElementAtCursor(g, d, e), f.graph.addCells([g, h], {
                halo: this.cid,
                async: !1
            }), this._cloneView = g.findView(f.paper), this._cloneView.pointerdown(c, d, e)
        }, d.prototype.startResizing = function(a) {
            this.startBatch(), this._flip = [1, 0, 0, 1, 1, 0, 0, 1][Math.floor(g.normalizeAngle(this.options.cellView.model.get("angle")) / 45)]
        }, d.prototype.startRotating = function(a, b, c) {
            this.startBatch();
            var d = this.options.cellView.model.getBBox().center(),
                e = g.normalizeAngle(this.options.cellView.model.get("angle"));
            this._center = d, this._rotationStartAngle = e || 0, this._clientStartAngle = g.point(b, c).theta(d)
        }, d.prototype.doResize = function(a, b, c, d, e) {
            var f = this.options.cellView.model.get("size"),
                g = Math.max(f.width + (this._flip ? d : e), 1),
                h = Math.max(f.height + (this._flip ? e : d), 1);
            this.options.cellView.model.resize(g, h, {
                absolute: !0
            })
        }, d.prototype.doRotate = function(a, b, c) {
            var d = this._clientStartAngle - g.point(b, c).theta(this._center),
                e = g.snapToGrid(this._rotationStartAngle + d, this.options.rotateAngleGrid);
            this.options.cellView.model.rotate(e, !0)
        }, d.prototype.doClone = function(a, b, c) {
            this._cloneView.pointermove(a, b, c)
        }, d.prototype.startCloning = function(b, c, d) {
            var e = this.options;
            this.startBatch();
            var f = e.clone(e.cellView.model, {
                clone: !0
            });
            if (!(f instanceof a.dia.Cell)) throw new Error('ui.Halo: option "clone" has to return a cell.');
            this.centerElementAtCursor(f, c, d), f.addTo(e.graph, {
                halo: this.cid,
                async: !1
            }), this._cloneView = f.findView(e.paper), this._cloneView.pointerdown(b, c, d)
        }, d.prototype.centerElementAtCursor = function(a, b, c) {
            var d = a.getBBox().center(),
                e = b - d.x,
                f = c - d.y;
            a.translate(e, f)
        }, d.prototype.doFork = function(a, b, c) {
            this._cloneView.pointermove(a, b, c)
        }, d.prototype.doLink = function(a, b, c) {
            this._linkView && this._linkView.pointermove(a, b, c)
        }, d.prototype.stopLinking = function(a) {
            this._linkView && (this._linkView.pointerup(a), this._linkView.model.hasLoop() && this.makeLoopLink(this._linkView.model), this.stopBatch(), this.triggerAction("link", "add", this._linkView.model), this._linkView = null)
        }, d.prototype.stopForking = function(a, b, c) {
            this._cloneView.pointerup(a, b, c), this.stopBatch()
        }, d.prototype.stopCloning = function(a, b, c) {
            this._cloneView.pointerup(a, b, c), this.stopBatch()
        }, d.prototype.unlinkElement = function(a) {
            this.startBatch(), this.options.graph.removeLinks(this.options.cellView.model), this.stopBatch()
        }, d.prototype.makeLoopLink = function(a) {
            var c, d, e = this.options.loopLinkWidth,
                f = this.options.paper.options,
                h = g.rect({
                    x: 0,
                    y: 0,
                    width: f.width,
                    height: f.height
                }),
                i = V(this.options.cellView.el).bbox(!1, this.options.paper.viewport),
                j = b.uniq([this.options.loopLinkPreferredSide, "top", "bottom", "left", "right"]),
                k = b.find(j, function(a) {
                    var b, f = 0,
                        j = 0;
                    switch (a) {
                        case "top":
                            b = g.point(i.x + i.width / 2, i.y - e), f = e / 2;
                            break;
                        case "bottom":
                            b = g.point(i.x + i.width / 2, i.y + i.height + e), f = e / 2;
                            break;
                        case "left":
                            b = g.point(i.x - e, i.y + i.height / 2), j = e / 2;
                            break;
                        case "right":
                            b = g.point(i.x + i.width + e, i.y + i.height / 2), j = e / 2
                    }
                    return c = g.point(b).offset(-f, -j), d = g.point(b).offset(f, j), h.containsPoint(c) && h.containsPoint(d)
                }, this);
            k && a.set("vertices", [c, d])
        }, a.ui.Halo = a.mvc.View.extend({
            PIE_INNER_RADIUS: 20,
            PIE_OUTER_RADIUS: 50,
            className: "halo",
            events: {
                "mousedown .handle": "onHandlePointerDown",
                "touchstart .handle": "onHandlePointerDown",
                "mousedown .pie-toggle": "onPieTogglePointerDown",
                "touchstart .pie-toggle": "onPieTogglePointerDown"
            },
            options: {
                clearAll: !0,
                useModelGeometry: !1,
                clone: function(a, b) {
                    return a.clone().unset("z")
                },
                type: "surrounding",
                pieSliceAngle: 45,
                pieStartAngleOffset: 0,
                pieIconSize: 14,
                pieToggles: [{
                    name: "default",
                    position: "e"
                }]
            },
            init: function() {
                var e = this.options.cellView.model,
                    f = e.isLink() ? new c : new d;
                b.assign(this, b.omit(f, "options")), b.defaults(this.options, f.options, {
                    paper: this.options.cellView.paper,
                    graph: this.options.cellView.paper.model
                }), b.bindAll(this, "pointermove", "pointerup", "render", "update"), this.options.clearAll && a.ui.Halo.clear(this.options.paper), this.listenTo(this.options.graph, "reset", this.remove), this.listenTo(this.options.graph, "all", this.update), this.listenTo(this.options.paper, "blank:pointerdown halo:create", this.remove), this.listenTo(this.options.paper, "scale translate", this.update), this.listenTo(e, "remove", this.remove), $(document.body).on("mousemove touchmove", this.pointermove), $(document).on("mouseup touchend", this.pointerup), this.handles = [], b.each(this.options.handles, this.addHandle, this)
            },
            render: function() {
                var c = this.options;
                switch (this.$el.empty(), this.$handles = $("<div/>").addClass("handles").appendTo(this.el), this.$box = $("<label/>").addClass("box").appendTo(this.el), this.$pieToggles = {}, this.$el.addClass(c.type), this.$el.addClass(this.cellTypeCssClass()), this.$el.attr("data-type", c.cellView.model.get("type")), this.$handles.append(b.map(this.handles, this.renderHandle, this)), c.type) {
                    case "toolbar":
                    case "surrounding":
                        this.hasHandle("fork") && this.toggleFork();
                        break;
                    case "pie":
                        b.each(this.options.pieToggles, function(b) {
                            var c = $("<div/>");
                            c.addClass("pie-toggle " + (b.position || "e")), c.attr("data-name", b.name), a.util.setAttributesBySelector(c, b.attrs), c.appendTo(this.el), this.$pieToggles[b.name] = c
                        }, this);
                        break;
                    default:
                        throw new Error("ui.Halo: unknown type")
                }
                return this.update(), this.$el.addClass("animate").appendTo(c.paper.el), this.setPieIcons(), this
            },
            setPieIcons: function() {
                "pie" === this.options.type && this.$el.find(".handle").each(b.bind(function(a, b) {
                    var c, d = $(b),
                        e = d.attr("data-action"),
                        f = this.getHandle(e);
                    if (!f || !f.icon) {
                        var g = window.getComputedStyle(b, ":before").getPropertyValue("content");
                        g && "none" !== g && (c = d.find(".slice-text-icon"), c.length > 0 && V(c[0]).text(g.replace(/['"]/g, "")));
                        var h = d.css("background-image");
                        if (h) {
                            var i = h.match(/url\(['"]?([^'"]+)['"]?\)/);
                            if (i) {
                                var j = i[1];
                                c = d.find(".slice-img-icon"), c.length > 0 && V(c[0]).attr("xlink:href", j)
                            }
                        }
                    }
                }, this))
            },
            update: function() {
                if (this.isRendered()) {
                    this.updateBoxContent();
                    var a = this.getBBox();
                    this.$el.toggleClass("tiny", a.width < this.options.tinyThreshold && a.height < this.options.tinyThreshold), this.$el.toggleClass("small", !this.$el.hasClass("tiny") && a.width < this.options.smallThreshold && a.height < this.options.smallThreshold), this.$el.css({
                        width: a.width,
                        height: a.height,
                        left: a.x,
                        top: a.y
                    }), this.hasHandle("unlink") && this.toggleUnlink()
                }
            },
            getBBox: function() {
                var a = this.options.cellView,
                    c = this.options.bbox,
                    d = b.isFunction(c) ? c(a, this) : c;
                return d = b.defaults({}, d, {
                    x: 0,
                    y: 0,
                    width: 1,
                    height: 1
                }), g.rect(d)
            },
            cellTypeCssClass: function() {
                return this.options.typeCssName
            },
            updateBoxContent: function() {
                var a = this.options.boxContent,
                    c = this.options.cellView;
                if (b.isFunction(a)) {
                    var d = a.call(this, c, this.$box[0]);
                    d && this.$box.html(d)
                } else a ? this.$box.html(a) : this.$box.remove()
            },
            extendHandles: function(a) {
                b.each(a, function(a) {
                    var c = this.getHandle(a.name);
                    c && b.extend(c, a)
                }, this)
            },
            addHandles: function(a) {
                return b.each(a, this.addHandle, this), this
            },
            addHandle: function(a) {
                var c = this.getHandle(a.name);
                return c || (this.handles.push(a), b.each(a.events, function(c, d) {
                    b.isString(c) ? this.on("action:" + a.name + ":" + d, this[c], this) : this.on("action:" + a.name + ":" + d, c)
                }, this), this.$handles && this.renderHandle(a).appendTo(this.$handles)), this
            },
            renderHandle: function(b) {
                var c = this.getHandleIdx(b.name),
                    d = $("<div/>").addClass("handle").addClass(b.name).attr("data-action", b.name).prop("draggable", !1);
                switch (this.options.type) {
                    case "toolbar":
                    case "surrounding":
                        d.addClass(b.position), b.content && d.html(b.content);
                        break;
                    case "pie":
                        var e = this.PIE_OUTER_RADIUS,
                            f = this.PIE_INNER_RADIUS,
                            h = (e + f) / 2,
                            i = g.point(e, e),
                            j = g.toRad(this.options.pieSliceAngle),
                            k = c * j + g.toRad(this.options.pieStartAngleOffset),
                            l = k + j,
                            m = V.createSlicePathData(f, e, k, l),
                            n = V("svg").addClass("slice-svg"),
                            o = V("path").attr("d", m).translate(e, e).addClass("slice"),
                            p = g.point.fromPolar(h, -k - j / 2, i),
                            q = this.options.pieIconSize,
                            r = V("image").attr(p).addClass("slice-img-icon");
                        p.y = p.y + q - 2;
                        var s = V("text", {
                            "font-size": q
                        }).attr(p).addClass("slice-text-icon");
                        r.attr({
                            width: q,
                            height: q
                        }), r.translate(-q / 2, -q / 2), s.translate(-q / 2, -q / 2), n.append([o, r, s]), d.append(n.node)
                }
                return b.icon && this.setHandleIcon(d, b.icon), a.util.setAttributesBySelector(d, b.attrs), d
            },
            setHandleIcon: function(a, b) {
                switch (this.options.type) {
                    case "pie":
                        var c = a.find(".slice-img-icon");
                        V(c[0]).attr("xlink:href", b);
                        break;
                    case "toolbar":
                    case "surrounding":
                        a.css("background-image", "url(" + b + ")")
                }
            },
            removeHandles: function() {
                for (; this.handles.length;) this.removeHandle(this.handles[0].name);
                return this
            },
            removeHandle: function(a) {
                var c = this.getHandleIdx(a),
                    d = this.handles[c];
                return d && (b.each(d.events, function(b, c) {
                    this.off("action:" + a + ":" + c)
                }, this), this.$(".handle." + a).remove(), this.handles.splice(c, 1)), this
            },
            changeHandle: function(a, c) {
                var d = this.getHandle(a);
                return d && (this.removeHandle(a), this.addHandle(b.merge({
                    name: a
                }, d, c))), this
            },
            hasHandle: function(a) {
                return this.getHandleIdx(a) !== -1
            },
            getHandleIdx: function(a) {
                return b.findIndex(this.handles, {
                    name: a
                })
            },
            getHandle: function(a) {
                return b.findWhere(this.handles, {
                    name: a
                })
            },
            toggleHandle: function(a, c) {
                var d = this.getHandle(a);
                if (d) {
                    var e = this.$(".handle." + a);
                    b.isUndefined(c) && (c = !e.hasClass("selected")), e.toggleClass("selected", c);
                    var f = c ? d.iconSelected : d.icon;
                    f && this.setHandleIcon(e, f)
                }
                return this
            },
            selectHandle: function(a) {
                return this.toggleHandle(a, !0)
            },
            deselectHandle: function(a) {
                return this.toggleHandle(a, !1)
            },
            deselectAllHandles: function() {
                return b.chain(this.handles).pluck("name").each(this.deselectHandle, this).value(), this
            },
            onHandlePointerDown: function(b) {
                if (this._action = $(b.target).closest(".handle").attr("data-action"), this._action) {
                    b.preventDefault(), b.stopPropagation(), b = a.util.normalizeEvent(b);
                    var c = this.options.paper.snapToGrid({
                        x: b.clientX,
                        y: b.clientY
                    });
                    this._localX = c.x, this._localY = c.y, this._evt = b, this.triggerAction(this._action, "pointerdown", b, c.x, c.y)
                }
            },
            onPieTogglePointerDown: function(a) {
                a.stopPropagation();
                var b = $(a.target).closest(".pie-toggle"),
                    c = b.attr("data-name");
                this.isOpen(c) ? this.toggleState(c) : this.isOpen() ? (this.toggleState(), this.toggleState(c)) : this.toggleState(c)
            },
            triggerAction: function(a, b, c) {
                var d = Array.prototype.slice.call(arguments, 2);
                d.unshift("action:" + a + ":" + b), this.trigger.apply(this, d)
            },
            stopBatch: function() {
                this.options.graph.stopBatch("halo", {
                    halo: this.cid
                })
            },
            startBatch: function() {
                this.options.graph.startBatch("halo", {
                    halo: this.cid
                })
            },
            pointermove: function(b) {
                if (this._action) {
                    b.preventDefault(), b.stopPropagation(), b = a.util.normalizeEvent(b);
                    var c = this.options.paper.snapToGrid({
                            x: b.clientX,
                            y: b.clientY
                        }),
                        d = c.x - this._localX,
                        e = c.y - this._localY;
                    this._localX = c.x, this._localY = c.y, this._evt = b, this.triggerAction(this._action, "pointermove", b, c.x, c.y, d, e)
                }
            },
            pointerup: function(a) {
                var b = this._action;
                if (b) {
                    this._action = null, this._evt = null;
                    var c = this.options.paper.snapToGrid({
                        x: a.clientX,
                        y: a.clientY
                    });
                    this.triggerAction(b, "pointerup", a, c.x, c.y)
                }
            },
            onRemove: function() {
                $(document.body).off("mousemove touchmove", this.pointermove), $(document).off("mouseup touchend", this.pointerup), this._action && this._evt && this.pointerup(this._evt), this.options.graph.hasActiveBatch("halo") && this.stopBatch()
            },
            onSetTheme: function() {
                this.setPieIcons()
            },
            removeElement: function() {
                this.options.cellView.model.remove()
            },
            toggleUnlink: function() {
                var a = this.options.graph.getConnectedLinks(this.options.cellView.model).length > 0;
                this.$handles.children(".unlink").toggleClass("hidden", !a)
            },
            toggleFork: function() {
                var a = this.options.cellView.model.clone(),
                    b = this.options.paper.createViewForModel(a),
                    c = this.options.paper.options.validateConnection(this.options.cellView, null, b, null, "target");
                this.$handles.children(".fork").toggleClass("hidden", !c), b.remove(), a = null
            },
            toggleState: function(a) {
                if (this.isRendered()) {
                    var c = this.$el;
                    if (b.each(this.$pieToggles, function(a) {
                            a.removeClass("open")
                        }), this.isOpen()) this.trigger("state:close", a), c.removeClass("open");
                    else {
                        if (this.trigger("state:open", a), a) {
                            var d = b.findWhere(this.options.pieToggles, {
                                name: a
                            });
                            d && c.attr({
                                "data-pie-toggle-position": d.position,
                                "data-pie-toggle-name": d.name
                            }), this.$pieToggles[a].addClass("open")
                        }
                        c.addClass("open")
                    }
                }
            },
            isOpen: function(a) {
                return !!this.isRendered() && (a ? this.$pieToggles[a].hasClass("open") : this.$el.hasClass("open"))
            },
            isRendered: function() {
                return !b.isUndefined(this.$box)
            }
        }, {
            clear: function(a) {
                a.trigger("halo:create")
            }
        })
    }(joint, _);
    ! function(a, b) {
        a.ui.Toolbar = a.mvc.View.extend({
            options: {},
            align: ["left", "right"],
            className: "toolbar",
            defaultGroup: "default",
            widgets: [],
            groupViews: [],
            init: function() {
                this.tools = this.options.tools || [], this.groups = this.options.groups || {}
            },
            getWidgetByName: function(a) {
                return b.find(this.widgets, function(b) {
                    return b.options.name === a
                })
            },
            getWidgets: function() {
                return this.widgets
            },
            groupsWithItemsPairs: function() {
                var a = {};
                return b.each(this.tools, function(b) {
                    var c = b.group || this.defaultGroup;
                    a[c] = a[c] || {
                        items: [],
                        group: {}
                    }, a[c].items.push(b), a[c].group = this.groups[c] || {}
                }, this), b.chain(a).pairs().sortBy(function(a) {
                    return a[1].group.index
                }).sortBy(function(a) {
                    return a[1].group.align || "left"
                }).value()
            },
            render: function() {
                var a = this.groupsWithItemsPairs(),
                    c = !1;
                return b.each(a, function(a) {
                    var b = a[0],
                        d = a[1],
                        e = this.renderGroup(b, d);
                    !c && d.group.align && "right" === d.group.align && (c = !0, e.addClass("group-first")), e.appendTo(this.el)
                }, this), this
            },
            renderGroup: function(a, d) {
                var e = new c({
                    name: a,
                    align: d.group.align,
                    items: d.items,
                    references: this.options.references
                });
                return this.groupViews.push(e), e.on("all", b.bind(function() {
                    this.trigger.apply(this, arguments)
                }, this)), e.render(), this.widgets = this.widgets.concat(e.widgets), e.$el
            },
            onRemove: function() {
                b.invoke(this.groupViews, "off"), b.invoke(this.groupViews, "remove")
            }
        });
        var c = a.mvc.View.extend({
            className: "toolbar-group",
            init: function() {
                this.widgets = []
            },
            onRender: function() {
                this.$el.attr("data-group", this.options.name), this.$el.addClass(this.options.align), this.renderItems()
            },
            renderItems: function() {
                b.each(this.options.items, function(a) {
                    var b = this.createWidget(a);
                    this.$el.append(b.$el)
                }, this)
            },
            createWidget: function(c) {
                var d = a.ui.Widget.create(c, this.options.references);
                return d.on("all", b.bind(function(a) {
                    var b = Array.prototype.slice.call(arguments, 1);
                    this.trigger.apply(this, [c.name + ":" + a].concat(b))
                }, this)), this.widgets.push(d), d
            },
            onRemove: function() {
                b.invoke(this.widgets, "off"), b.invoke(this.widgets, "remove")
            }
        })
    }(joint, _),
    function(a, b) {
        a.ui.Widget = a.mvc.View.extend({
            className: "widget",
            references: [],
            constructor: function(b, c) {
                this.availableReferences = c || {}, a.mvc.View.prototype.constructor.call(this, b)
            },
            updateAttrs: function(b) {
                a.util.setAttributesBySelector(this.$el, b)
            },
            bindEvents: function() {},
            validateReferences: function() {
                var a = this.references || [],
                    c = [];
                return b.each(a, function(a) {
                    b.isUndefined(this.availableReferences[a]) && c.push(a)
                }, this), c
            },
            getReference: function(a) {
                return this.availableReferences[a]
            },
            getReferences: function() {
                return this.availableReferences
            }
        }, {
            create: function(c, d) {
                var e = b.camelCase(b.isString(c) ? c : c.type);
                if (!b.isFunction(a.ui.widgets[e])) throw new Error('Widget: unable to find widget: "' + e + '"');
                var f = new a.ui.widgets[e](c, d),
                    g = f.validateReferences(d);
                if (g.length > 0) throw new Error('Widget: "' + e + '" missing dependency: ' + g.join(", "));
                return f.render(), f.updateAttrs(c.attrs), f.bindEvents(), f.$el.attr("data-type", e), c.name && f.$el.attr("data-name", c.name), f
            }
        }), a.ui.widgets = {
            checkbox: a.ui.Widget.extend({
                tagName: "label",
                events: {
                    "change .input": "onChange",
                    mousedown: "pointerdown",
                    touchstart: "pointerdown",
                    mouseup: "pointerup",
                    touchend: "pointerup"
                },
                init: function() {
                    b.bindAll(this, "pointerup")
                },
                render: function() {
                    var a = this.options,
                        b = $("<span/>").text(a.label || "");
                    return this.$input = $("<input/>", {
                        type: "checkbox",
                        "class": "input"
                    }).prop("checked", !!a.value), this.$span = $("<span/>"), this.$el.append([b, this.$input, this.$span]), this
                },
                onChange: function(a) {
                    this.trigger("change", !!a.target.checked, a)
                },
                pointerdown: function(b) {
                    b = a.util.normalizeEvent(b), this.$el.addClass("is-in-action"), this.trigger("pointerdown", b), $(document).on("mouseup.checkbox touchend.checkbox", this.pointerup)
                },
                pointerup: function(b) {
                    b = a.util.normalizeEvent(b), $(document).off("mouseup.checkbox touchend.checkbox"), this.trigger("pointerdown", b), this.$el.removeClass("is-in-action")
                }
            }),
            toggle: a.ui.Widget.extend({
                tagName: "label",
                events: {
                    "change .toggle": "onChange",
                    mousedown: "pointerdown",
                    touchstart: "pointerdown",
                    mouseup: "pointerup",
                    touchend: "pointerup"
                },
                init: function() {
                    b.bindAll(this, "pointerup")
                },
                render: function() {
                    var a = this.options,
                        b = $("<span/>").text(a.label || ""),
                        c = $("<span><i/></span>"),
                        d = $("<input/>", {
                            type: "checkbox",
                            "class": "toggle"
                        }).prop("checked", !!a.value),
                        e = $("<div/>").addClass(a.type);
                    return this.$el.append([b, e.append(d, c)]), this
                },
                onChange: function(a) {
                    this.trigger("change", !!a.target.checked, a)
                },
                pointerdown: function(b) {
                    b = a.util.normalizeEvent(b), this.$el.addClass("is-in-action"), this.trigger("pointerdown", b), $(document).on("mouseup.toggle touchend.toggle", this.pointerup)
                },
                pointerup: function(b) {
                    b = a.util.normalizeEvent(b), $(document).off("mouseup.toggle touchend.toggle"), this.$el.removeClass("is-in-action"), this.trigger("pointerup", b)
                }
            }),
            separator: a.ui.Widget.extend({
                render: function() {
                    return this.options.width && this.$el.css({
                        width: this.options.width
                    }), this
                }
            }),
            label: a.ui.Widget.extend({
                tagName: "label",
                render: function() {
                    return this.$el.text(this.options.text), this
                }
            }),
            range: a.ui.Widget.extend({
                events: {
                    "change .input": "onChange",
                    "input .input": "onChange"
                },
                render: function() {
                    var a, b = this.options;
                    return this.$output = $("<output/>").text(b.value), a = $("<span/>").addClass("units").text(b.unit), this.$input = $("<input/>", {
                        type: "range",
                        name: b.type,
                        min: b.min,
                        max: b.max,
                        step: b.step,
                        "class": "input"
                    }).val(b.value), this.$el.append([this.$input, this.$output, a]), this
                },
                onChange: function(a) {
                    var b = parseInt(this.$input.val(), 10);
                    b !== this.currentValue && (this.currentValue = b, this.$output.text(b), this.trigger("change", b, a))
                },
                setValue: function(a) {
                    this.$input.val(a), this.$input.trigger("change")
                }
            }),
            selectBox: a.ui.Widget.extend({
                render: function() {
                    var c = b.omit(this.options, "type", "group", "index");
                    return this.selectBox = new a.ui.SelectBox(c), this.selectBox.render().$el.appendTo(this.el), this
                },
                bindEvents: function() {
                    this.selectBox.on("all", this.trigger, this)
                }
            }),
            button: a.ui.Widget.extend({
                events: {
                    mousedown: "pointerdown",
                    touchstart: "pointerdown",
                    click: "pointerclick",
                    touchend: "pointerclick"
                },
                tagName: "button",
                render: function() {
                    var a = this.options;
                    return this.$el.text(a.text), this
                },
                pointerclick: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerclick", b)
                },
                pointerdown: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerdown", b)
                }
            }),
            inputText: a.ui.Widget.extend({
                events: {
                    mousedown: "pointerdown",
                    touchstart: "pointerdown",
                    mouseup: "pointerup",
                    touchend: "pointerup",
                    click: "pointerclick",
                    focusin: "pointerfocusin",
                    focusout: "pointerfocusout"
                },
                tagName: "div",
                render: function() {
                    var a = this.options;
                    return this.$label = $("<label/>").text(a.label), this.$input = $("<div/>").addClass("input-wrapper").append($("<input/>", {
                        type: "text",
                        "class": "input"
                    }).val(a.value)), this.$el.append([this.$label, this.$input]), this
                },
                pointerclick: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerclick", b)
                },
                pointerdown: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerdown", b)
                },
                pointerup: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerup", b)
                },
                pointerfocusin: function(b) {
                    b = a.util.normalizeEvent(b), this.$el.addClass("is-focused"), this.trigger("pointerfocusin", b)
                },
                pointerfocusout: function(b) {
                    b = a.util.normalizeEvent(b), this.$el.removeClass("is-focused"), this.trigger("pointerfocusout", b)
                }
            }),
            inputNumber: a.ui.Widget.extend({
                events: {
                    mousedown: "pointerdown",
                    touchstart: "pointerdown",
                    mouseup: "pointerup",
                    touchend: "pointerup",
                    click: "pointerclick",
                    focusin: "pointerfocusin",
                    focusout: "pointerfocusout"
                },
                tagName: "div",
                render: function() {
                    var a = this.options;
                    return this.$label = $("<label/>").text(a.label), this.$input = $("<div/>").addClass("input-wrapper").append($("<input/>", {
                        type: "number",
                        "class": "number",
                        max: a.max,
                        min: a.min
                    }).val(a.value)), this.$el.append([this.$label, this.$input]), this
                },
                pointerclick: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerclick", b)
                },
                pointerdown: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerdown", b)
                },
                pointerup: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerup", b)
                },
                pointerfocusin: function(b) {
                    b = a.util.normalizeEvent(b), this.$el.addClass("is-focused"), this.trigger("pointerfocusin", b)
                },
                pointerfocusout: function(b) {
                    b = a.util.normalizeEvent(b), this.$el.removeClass("is-focused"), this.trigger("pointerfocusout", b)
                }
            }),
            textarea: a.ui.Widget.extend({
                events: {
                    mousedown: "pointerdown",
                    touchstart: "pointerdown",
                    mouseup: "pointerup",
                    touchend: "pointerup",
                    click: "pointerclick",
                    focusin: "pointerfocusin",
                    focusout: "pointerfocusout"
                },
                tagName: "div",
                render: function() {
                    var a = this.options;
                    return this.$label = $("<label/>").text(a.label), this.$input = $("<div/>").addClass("input-wrapper").append($("<textarea/>", {
                        "class": "textarea"
                    }).text(a.value)), this.$el.append([this.$label, this.$input]), this
                },
                pointerclick: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerclick", b)
                },
                pointerdown: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerdown", b)
                },
                pointerup: function(b) {
                    b = a.util.normalizeEvent(b), this.trigger("pointerup", b)
                },
                pointerfocusin: function(b) {
                    b = a.util.normalizeEvent(b), this.$el.addClass("is-focused"), this.trigger("pointerfocusin", b)
                },
                pointerfocusout: function(b) {
                    b = a.util.normalizeEvent(b), this.$el.removeClass("is-focused"), this.trigger("pointerfocusout", b)
                }
            }),
            selectButtonGroup: a.ui.Widget.extend({
                render: function() {
                    var c = b.omit(this.options, "type", "group", "index");
                    return this.selectButtonGroup = new a.ui.SelectButtonGroup(c), this.selectButtonGroup.render().$el.appendTo(this.el), this
                },
                bindEvents: function() {
                    this.selectButtonGroup.on("all", this.trigger, this)
                }
            })
        }, a.ui.widgets.zoomIn = a.ui.widgets.button.extend({
            references: ["paperScroller"],
            options: {
                min: .2,
                max: 5,
                step: .2
            },
            pointerdown: function(b) {
                var c = this.options;
                this.getReferences().paperScroller.zoom(c.step, {
                    max: c.max,
                    grid: c.step
                }), a.ui.widgets.button.prototype.pointerdown.call(this, b)
            }
        }), a.ui.widgets.zoomOut = a.ui.widgets.button.extend({
            references: ["paperScroller"],
            options: {
                min: .2,
                max: 5,
                step: .2
            },
            pointerdown: function(b) {
                var c = this.options;
                this.getReferences().paperScroller.zoom(-c.step, {
                    min: c.min,
                    grid: c.step
                }), a.ui.widgets.button.prototype.pointerdown.call(this, b)
            }
        }), a.ui.widgets.zoomToFit = a.ui.widgets.button.extend({
            references: ["paperScroller"],
            options: {
                min: .2,
                max: 5,
                step: .2
            },
            pointerdown: function(b) {
                var c = this.options;
                this.getReferences().paperScroller.zoomToFit({
                    padding: 20,
                    scaleGrid: c.step,
                    minScale: c.min,
                    maxScale: c.max
                }), a.ui.widgets.button.prototype.pointerdown.call(this, b)
            }
        }), a.ui.widgets.zoomSlider = a.ui.widgets.range.extend({
            references: ["paperScroller"],
            options: {
                min: 20,
                max: 500,
                step: 20,
                value: 100,
                unit: " %"
            },
            bindEvents: function() {
                this.on("change", function(a) {
                    this.getReferences().paperScroller.zoom(a / 100, {
                        absolute: !0,
                        grid: this.options.step / 100
                    })
                }, this), this.getReferences().paperScroller.options.paper.on("scale", function(a) {
                    this.setValue(Math.floor(100 * a))
                }, this)
            }
        }), a.ui.widgets.undo = a.ui.widgets.button.extend({
            references: ["commandManager"],
            pointerclick: function() {
                this.getReferences().commandManager.undo()
            }
        }), a.ui.widgets.redo = a.ui.widgets.button.extend({
            references: ["commandManager"],
            pointerclick: function() {
                this.getReferences().commandManager.redo()
            }
        })
    }(joint, _);
    ! function(a, b) {
        var c = {
            options: function() {
                return {
                    columnWidth: this.options.width / 2 - 10,
                    columns: 2,
                    rowHeight: 80,
                    resizeToFit: !0,
                    dy: 10,
                    dx: 10
                }
            },
            layoutGroup: function(c, d) {
                var e = this.options.layout;
                if (d = d || {}, !a.layout.GridLayout) throw new Error("joint.ui.Stencil: joint.layout.GridLayout is not available.");
                a.layout.GridLayout.layout(c, b.extend({}, e, d.layout))
            }
        };
        a.ui.Stencil = a.mvc.View.extend({
            className: "stencil",
            events: {
                "click .btn-expand": "openGroups",
                "click .btn-collapse": "closeGroups",
                "click .groups-toggle .group-label": "openGroups",
                "click .group-label": "onGroupLabelClick",
                "touchstart .group-label": "onGroupLabelClick",
                "input .search": "onSearch",
                "focusin .search": "pointerFocusIn",
                "focusout .search": "pointerFocusOut"
            },
            options: {
                width: 200,
                height: 800,
                label: "Stencil",
                groups: null,
                groupsToggleButtons: !1,
                dropAnimation: !1,
                search: null,
                layout: null,
                snaplines: null,
                scaleClones: !1,
                dragStartClone: function(a) {
                    return a.clone()
                },
                dragEndClone: function(a) {
                    return a.clone()
                },
                layoutGroup: null
            },
            init: function() {
                this.setPaper(this.options.paperScroller || this.options.paper), this.graphs = {}, this.papers = {}, this.$groups = {}, b.bindAll(this, "onDrag", "onDragEnd", "onDropEnd"), $(document.body).on("mousemove.stencil touchmove.stencil", this.onDrag), $(window).on("mouseup.stencil touchend.stencil", this.onDragEnd), this.onSearch = b.debounce(this.onSearch, 200), this.initializeLayout()
            },
            initializeLayout: function() {
                var a = this.options.layout;
                a && (b.isFunction(a) ? this.layoutGroup = a : (this.layoutGroup = b.bind(c.layoutGroup, this), this.options.layout = b.isObject(a) ? a : {}, b.defaults(this.options.layout, c.options.call(this))))
            },
            setPaper: function(b) {
                var c = this.options;
                if (b instanceof a.dia.Paper) c.paperScroller = null, c.paper = b, c.graph = b.model;
                else {
                    if (!("function" == typeof a.ui.PaperScroller && b instanceof a.ui.PaperScroller)) throw new Error("Stencil: paper required");
                    c.paperScroller = b, c.paper = b.options.paper, c.graph = b.options.paper.model
                }
            },
            renderContent: function() {
                return $("<div/>").addClass("content")
            },
            renderPaperDrag: function() {
                return $("<div/>").addClass("stencil-paper-drag")
            },
            renderSearch: function() {
                return $("<div/>").addClass("search-wrap").append($("<input/>", {
                    type: "search",
                    placeholder: "search"
                }).addClass("search"))
            },
            renderToggleAll: function() {
                return [$("<div/>").addClass("groups-toggle").append($("<label/>").addClass("group-label").html(this.options.label)).append($("<button/>", {
                    text: "+"
                }).addClass("btn btn-expand")).append($("<button/>", {
                    text: "-"
                }).addClass("btn btn-collapse"))]
            },
            renderElementsContainer: function() {
                return $("<div/>").addClass("elements")
            },
            renderGroup: function(a) {
                a = a || {};
                var b = $("<div/>").addClass("group").attr("data-name", a.name).toggleClass("closed", !!a.closed),
                    c = $("<h3/>").addClass("group-label").html(a.label || a.name),
                    d = this.renderElementsContainer();
                return b.append(c, d)
            },
            render: function() {
                this.$content = this.renderContent(), this.$paperDrag = this.renderPaperDrag(), this.$el.empty().append(this.$paperDrag, this.$content), this.options.search && this.$el.addClass("searchable").prepend(this.renderSearch()), this.options.groupsToggleButtons && this.$el.addClass("collapsible").prepend(this.renderToggleAll());
                var c = {
                    width: this.options.width,
                    height: this.options.height,
                    interactive: !1
                };
                if (this.options.groups) {
                    var d = b.sortBy(b.pairs(this.options.groups), function(a) {
                        return a[1].index
                    });
                    b.each(d, function(d) {
                        var e = d[0],
                            f = d[1],
                            g = this.$groups[e] = this.renderGroup({
                                name: e,
                                label: f.label,
                                closed: f.closed
                            }).appendTo(this.$content),
                            h = new a.dia.Graph,
                            i = new a.dia.Paper(b.extend({}, c, {
                                el: g.find(".elements"),
                                model: h,
                                width: f.width || c.width,
                                height: f.height || c.height
                            }));
                        this.graphs[e] = h, this.papers[e] = i
                    }, this)
                } else {
                    var e = this.renderElementsContainer().appendTo(this.$content),
                        f = new a.dia.Graph,
                        g = new a.dia.Paper(b.extend(c, {
                            el: e,
                            model: f
                        }));
                    this.graphs.__default__ = f, this.papers.__default__ = g
                }
                return this._graphDrag = new a.dia.Graph, this._paperDrag = new a.dia.Paper({
                    el: this.$paperDrag,
                    width: 1,
                    height: 1,
                    model: this._graphDrag
                }), this.startListening(), this
            },
            startListening: function() {
                this.stopListening(), b.each(this.papers, b.bind(this.listenTo, this, b, "cell:pointerdown", this.onDragStart))
            },
            load: function(a, c) {
                b.isArray(a) ? this.loadGroup(a, c) : b.isObject(a) && b.each(this.options.groups, function(b, c) {
                    a[c] && this.loadGroup(a[c], c)
                }, this)
            },
            loadGroup: function(a, b) {
                var c = this.getGraph(b);
                c.resetCells(a);
                var d = this.options.height;
                b && (d = this.getGroup(b).height), this.isLayoutEnabled() && this.layoutGroup(c, this.getGroup(b)), d || this.getPaper(b).fitToContent({
                    gridWidth: 1,
                    gridHeight: 1,
                    padding: this.options.paperPadding || 10
                })
            },
            isLayoutEnabled: function() {
                return !!this.options.layout
            },
            getGraph: function(a) {
                var b = this.graphs[a || "__default__"];
                if (!b) throw new Error("Stencil: group " + a + " does not exist.");
                return b
            },
            getPaper: function(a) {
                return this.papers[a || "__default__"]
            },
            preparePaperForDragging: function(a, b, c) {
                var d = this._paperDrag,
                    e = this._graphDrag;
                d.$el.addClass("dragging").appendTo(document.body);
                var f = this.options.dragStartClone(a.model).position(0, 0),
                    g = f.getBBox(),
                    h = 5,
                    i = this.options.snaplines;
                if (i && (h += i.options.distance), i || this.options.scaleClones) {
                    var j = V(this.options.paper.viewport).scale();
                    d.scale(j.sx, j.sy), h *= Math.max(j.sx, j.sy)
                } else d.scale(1, 1);
                this.clearClone(), this.options.dropAnimation && this._paperDrag.$el.stop(!0, !0), e.resetCells([f.position(0, 0)]);
                var k = f.findView(d);
                k.stopListening(), d.fitToContent({
                    padding: h,
                    allowNewOrigin: "any"
                });
                var l = a.getBBox(),
                    m = a.model.getBBox();
                this._cellViewDeltaOrigin = {
                    x: m.x - l.x - l.width / 2,
                    y: m.y - l.y - l.height / 2
                }, this._clone = f, this._cloneBBox = g, this._cloneView = k, this._cloneViewBBox = k.getBBox(), this._paperDragInitialOffset = this.setPaperDragOffset(b, c), this._paperDragPadding = h
            },
            setPaperDragOffset: function(a, b) {
                var c = document.body.scrollTop || document.documentElement.scrollTop,
                    d = this._cloneViewBBox,
                    e = this._paperDragPadding,
                    f = {
                        left: a - d.width / 2 - e,
                        top: b - d.height / 2 + c - e
                    };
                return this._paperDrag.$el.offset(f), f
            },
            setCloneLocalPosition: function(a, b) {
                var c = this.options.paper.clientToLocalPoint({
                    x: a,
                    y: b
                });
                return c.x -= this._cloneBBox.width / 2, c.y -= this._cloneBBox.height / 2, this._clone.set("position", c), c
            },
            onDragStart: function(a, c) {
                c.preventDefault(), this.options.graph.startBatch("stencil-drag"), this.$el.addClass("dragging"), this.preparePaperForDragging(a, c.clientX, c.clientY);
                var d = this.setCloneLocalPosition(c.clientX, c.clientY),
                    e = this._cloneView,
                    f = this.options.snaplines;
                f && (f.captureCursorOffset(this._cloneView, c, d.x, d.y), e.listenTo(this._clone, "change:position", b.bind(this.onCloneSnapped, this)))
            },
            onCloneSnapped: function(a, b, c) {
                if (c.snapped) {
                    var d = this._cloneBBox;
                    a.position(d.x + c.tx, d.y + c.ty, {
                        silent: !0
                    }), this._cloneView.translate(), a.set("position", b, {
                        silent: !0
                    }), this._cloneSnapOffset = {
                        x: c.tx,
                        y: c.ty
                    }
                } else this._cloneSnapOffset = null
            },
            onDrag: function(b) {
                var c = this._cloneView;
                if (c) {
                    b.preventDefault(), b = a.util.normalizeEvent(b);
                    var d = b.clientX,
                        e = b.clientY;
                    this.setPaperDragOffset(d, e);
                    var f = this.setCloneLocalPosition(d, e),
                        g = this.options.paper.options.embeddingMode,
                        h = this.options.snaplines,
                        i = (g || h) && this.insideValidArea({
                            x: d,
                            y: e
                        });
                    g && (i ? c.processEmbedding({
                        paper: this.options.paper
                    }) : c.clearEmbedding()), h && (i ? h.snapWhileMoving(c, b, f.x, f.y) : h.hide())
                }
            },
            onDragEnd: function(b) {
                var c = this._clone;
                if (c) {
                    b = a.util.normalizeEvent(b);
                    var d = this._cloneView,
                        e = this._cloneBBox,
                        f = this._cloneSnapOffset,
                        g = e.x,
                        h = e.y;
                    f && (g += f.x, h += f.y), c.position(g, h, {
                        silent: !0
                    });
                    var i = this.options.dragEndClone(c),
                        j = this.drop(b, i);
                    j ? this.onDropEnd(c) : this.onDropInvalid(b, i), this.options.paper.options.embeddingMode && d && d.finalizeEmbedding({
                        model: i,
                        paper: this.options.paper
                    }), this.options.graph.stopBatch("stencil-drag")
                }
            },
            onDropEnd: function(a) {
                this._clone === a && (this.clearClone(), this.$el.append(this._paperDrag.$el), this.$el.removeClass("dragging"), this._paperDrag.$el.removeClass("dragging"))
            },
            clearClone: function() {
                this._clone && (this._clone.remove(), this._clone = null, this._cloneView = null, this._cloneSnapOffset = null, this._paperDragInitialOffset = null, this._paperDragPadding = null)
            },
            onDropInvalid: function(c, d) {
                var e = this._clone;
                if (e) {
                    c = a.util.normalizeEvent(c), d = d || this.options.dragEndClone(e), this.trigger("drop:invalid", c, d);
                    var f = this.options.dropAnimation;
                    if (f) {
                        var g = b.isObject(f) ? f.duration : 150,
                            h = b.isObject(f) ? f.easing : "swing";
                        this._cloneView = null, this._paperDrag.$el.animate(this._paperDragInitialOffset, g, h, b.partial(this.onDropEnd, e))
                    } else this.onDropEnd(e)
                }
            },
            insideValidArea: function(a) {
                var b, c = this.options.paper,
                    d = this.options.paperScroller,
                    e = this.getDropArea(this.$el);
                if (d)
                    if (d.options.autoResizePaper) b = this.getDropArea(d.$el);
                    else {
                        var f = this.getDropArea(d.$el),
                            g = this.getDropArea(c.$el);
                        b = g.intersect(f)
                    }
                else b = this.getDropArea(c.$el);
                return !(!b || !b.containsPoint(a) || e.containsPoint(a))
            },
            getDropArea: function(a) {
                var b = a.offset(),
                    c = document.body.scrollTop || document.documentElement.scrollTop,
                    d = document.body.scrollLeft || document.documentElement.scrollLeft;
                return g.rect({
                    x: b.left + parseInt(a.css("border-left-width"), 10) - d,
                    y: b.top + parseInt(a.css("border-top-width"), 10) - c,
                    width: a.innerWidth(),
                    height: a.innerHeight()
                })
            },
            drop: function(a, b) {
                var c = this.options.paper,
                    d = this.options.graph,
                    e = {
                        x: a.clientX,
                        y: a.clientY
                    };
                if (this.insideValidArea(e)) {
                    var f = c.clientToLocalPoint(e),
                        h = b.getBBox();
                    f.x += h.x + this._cellViewDeltaOrigin.x, f.y += h.y + this._cellViewDeltaOrigin.y;
                    var i = this._cloneSnapOffset ? 1 : c.options.gridSize;
                    return b.set("position", {
                        x: g.snapToGrid(f.x, i),
                        y: g.snapToGrid(f.y, i)
                    }), b.unset("z"), d.addCell(b, {
                        stencil: this.cid
                    }), !0
                }
                return !1
            },
            filter: function(c, d) {
                var e = c.toLowerCase() == c,
                    f = b.reduce(this.papers, function(f, g, h) {
                        var i = g.model.get("cells").filter(function(f) {
                                var h = g.findViewByModel(f),
                                    i = !c || b.some(d, function(d, g) {
                                        if ("*" != g && f.get("type") != g) return !1;
                                        var h = b.some(d, function(d) {
                                            var g = a.util.getByPath(f.attributes, d, "/");
                                            return !b.isUndefined(g) && !b.isNull(g) && (g = g.toString(), e && (g = g.toLowerCase()), g.indexOf(c) >= 0)
                                        });
                                        return h
                                    });
                                return V(h.el).toggleClass("unmatched", !i), i
                            }, this),
                            j = !b.isEmpty(i),
                            k = (new a.dia.Graph).resetCells(i);
                        return this.trigger("filter", k, h, c), this.isLayoutEnabled() && this.layoutGroup(k, this.getGroup(h)), this.$groups[h] && this.$groups[h].toggleClass("unmatched", !j), g.fitToContent({
                            gridWidth: 1,
                            gridHeight: 1,
                            padding: this.options.paperPadding || 10
                        }), f || j
                    }, !1, this);
                this.$el.toggleClass("not-found", !f)
            },
            getGroup: function(a) {
                return this.options.groups && this.options.groups[a] || {}
            },
            onSearch: function(a) {
                this.filter(a.target.value, this.options.search)
            },
            pointerFocusIn: function() {
                this.$el.addClass("is-focused")
            },
            pointerFocusOut: function() {
                this.$el.removeClass("is-focused")
            },
            onGroupLabelClick: function(a) {
                a.preventDefault();
                var b = $(a.target).closest(".group");
                this.toggleGroup(b.data("name"))
            },
            toggleGroup: function(a) {
                this.$('.group[data-name="' + a + '"]').toggleClass("closed")
            },
            closeGroup: function(a) {
                this.$('.group[data-name="' + a + '"]').addClass("closed")
            },
            openGroup: function(a) {
                this.$('.group[data-name="' + a + '"]').removeClass("closed")
            },
            isGroupOpen: function(a) {
                return !this.$('.group[data-name="' + a + '"]').hasClass("closed")
            },
            closeGroups: function() {
                this.$(".group").addClass("closed")
            },
            openGroups: function() {
                this.$(".group").removeClass("closed")
            },
            onRemove: function() {
                b.invoke(this.papers, "remove"), this.papers = {}, this._paperDrag && (this._paperDrag.remove(), this._paperDrag = null), $(document.body).off(".stencil", this.onDrag).off(".stencil", this.onDragEnd), $(window).off(".stencil", this.onDragEnd)
            }
        })
    }(joint, _);
    ! function(a) {
        "use strict";
        a.ui.Inspector = a.mvc.View.extend({
            className: "inspector",
            options: {
                cellView: void 0,
                cell: void 0,
                live: !0,
                validateInput: function(a, b, c) {
                    return !a.validity || a.validity.valid
                },
                renderFieldContent: void 0,
                operators: {},
                multiOpenGroups: !0,
                stateKey: function(a) {
                    return a.id
                }
            },
            events: {
                "change [data-attribute]:not([data-custom-field])": "onChangeInput",
                "click .group-label": "onGroupLabelClick",
                "click .btn-list-add": "addListItem",
                "click .btn-list-del": "deleteListItem",
                mousedown: "pointerdown",
                touchstart: "pointerdown",
                mouseup: "pointerup",
                touchend: "pointerup",
                focusin: "pointerfocusin",
                focusout: "pointerfocusout"
            },
            HTMLEntities: {
                lt: "<",
                gt: ">",
                amp: "&",
                nbsp: " ",
                quot: '"',
                cent: "Â¢",
                pound: "Â£",
                euro: "â‚¬",
                yen: "Â¥",
                copy: "Â©",
                reg: "Â®"
            },
            init: function() {
                this.options.groups = this.options.groups || {}, _.bindAll(this, "stopBatchCommand", "pointerup", "onContentEditableBlur", "replaceHTMLEntity"), $(document).on("mouseup", this.stopBatchCommand), this.widgets = [], this.flatAttributes = a.util.flattenObject(this.options.inputs, "/", function(a) {
                    return a.type
                }), this._when = {}, this._bound = {};
                var b = _.map(this.flatAttributes, function(a, b) {
                    if (a.when) {
                        var c = {
                            expression: a.when,
                            path: b
                        };
                        _.each(this.extractExpressionPaths(c.expression), function(a) {
                            (this._when[a] || (this._when[a] = [])).push(c)
                        }, this)
                    }
                    return "select" == a.type && _.isString(a.options) && (this._bound[b] = a.options), a.path = b, a
                }, this);
                this.groupedFlatAttributes = _.sortBy(_.sortBy(b, "index"), function(a) {
                    var b = this.options.groups[a.group];
                    return b && b.index || Number.MAX_VALUE
                }, this), this.on("render", function() {
                    var a = {};
                    _.each(this.$("[data-attribute]"), function(b) {
                        var c = $(b),
                            d = c.attr("data-attribute");
                        a[d] = c
                    }, this), this._byPath = a, this._attributeKeysInUse = this.getAttributeKeysInUse(), _.each(this.$groups, function(a) {
                        var b = $(a),
                            c = 0 === b.find("> .field:not(.hidden)").length;
                        b.toggleClass("empty", c)
                    })
                }, this), this.listenTo(this.getModel(), "all", this.onCellChange, this)
            },
            getModel: function() {
                return this.options.cell || this.options.cellView.model
            },
            onCellChange: function(a, b, c, d) {
                if (d = d || {}, d.inspector != this.cid) switch (a) {
                    case "remove":
                        this.remove();
                        break;
                    case "change:position":
                        this.updateInputPosition();
                        break;
                    case "change:size":
                        this.updateInputSize();
                        break;
                    case "change:angle":
                        this.updateInputAngle();
                        break;
                    case "change:source":
                    case "change:target":
                    case "change:vertices":
                        break;
                    default:
                        var e = "change:";
                        if (a.slice(0, e.length) === e) {
                            var f = a.slice(e.length);
                            _.contains(this._attributeKeysInUse, f) && this.render()
                        }
                }
            },
            render: function() {
                this.$el.empty(), this.removeWidgets();
                var a, b, c = [];
                return _.each(this.groupedFlatAttributes, function(d) {
                    if (a !== d.group) {
                        var e = this.options.groups[d.group];
                        b = this.renderGroup({
                            name: d.group,
                            label: e && e.label
                        }), e && e.closed ? this.closeGroup(b, {
                            init: !0
                        }) : this.openGroup(b, {
                            init: !0
                        }), c.push(b)
                    }
                    this.renderTemplate(b, d, d.path), a = d.group
                }, this), this.$groups = c, this.$el.append(c), this.trigger("render"), this
            },
            getAttributeKeysInUse: function() {
                var a = _.map(this._byPath, function(a, b) {
                        return b.substring(0, b.indexOf("/")) || b
                    }),
                    b = _.values(this._bound),
                    c = _.keys(this._when);
                return _.uniq([].concat(a, b, c))
            },
            getCellAttributeValue: function(b, c) {
                var d = this.getModel(),
                    e = a.util.getByPath(d.attributes, b, "/");
                if (c = c || this.flatAttributes[b], !c) return e;
                if (_.isUndefined(e) && !_.isUndefined(c.defaultValue) && (e = c.defaultValue), c.valueRegExp) {
                    if (_.isUndefined(e)) throw new Error("Inspector: defaultValue must be present when valueRegExp is used.");
                    var f = e.match(new RegExp(c.valueRegExp));
                    e = f && f[2]
                }
                return e
            },
            resolveBindings: function(b) {
                switch (b.type) {
                    case "select":
                        var c = b.options || [];
                        _.isString(c) && (c = a.util.getByPath(this.getModel().attributes, c, "/") || []), _.isObject(c[0]) || (c = _.map(c, function(a) {
                            return {
                                value: a,
                                content: a
                            }
                        })), b.items = c
                }
            },
            updateBindings: function(a) {
                var b = _.reduce(this._bound, function(b, c, d) {
                    return 0 == a.indexOf(c) && b.push(d), b
                }, []);
                _.isEmpty(b) || (_.each(b, function(a) {
                    this.renderTemplate(null, this.flatAttributes[a], a, {
                        replace: !0
                    })
                }, this), this.trigger("render"))
            },
            renderFieldContent: function(b, c, d) {
                var e;
                if (_.isFunction(this.options.renderFieldContent) && (e = this.options.renderFieldContent(b, c, d))) return $(e).attr({
                    "data-attribute": c,
                    "data-type": b.type,
                    "data-custom-field": !0
                });
                var f, g, h, i;
                switch (b.type) {
                    case "select-box":
                        g = _.findIndex(b.options, function(a) {
                            return !(!_.isUndefined(a.value) || a.content !== d) || !!_.isEqual(a.value, d)
                        });
                        var j = _.extend({}, _.omit(b, "type", "group", "index", "selectBoxOptionsClass"), {
                            selected: g,
                            selectBoxOptionsClass: _.compact([a.util.addClassNamePrefix("inspector-select-box-options"), b.selectBoxOptionsClass]).join(" ")
                        });
                        f = new a.ui.SelectBox(j), f.$el.attr({
                            "data-attribute": c,
                            "data-type": b.type
                        }), f.render(), i = $("<label/>", {
                            html: b.label || c
                        }), e = $("<div/>").append(i, f.el), b.previewMode ? (h = f.selection, f.on("options:mouseout close", function() {
                            f.selection = h, this.processInput(f.$el, {
                                previewCancel: !0,
                                dry: !0
                            })
                        }, this), f.on("option:hover", function(a, b) {
                            f.selection = a, this.processInput(f.$el, {
                                dry: !0
                            })
                        }, this), f.on("option:select", function(a, b) {
                            var c = _.isUndefined(h) ? void 0 : f.getSelectionValue(h),
                                d = f.getSelectionValue(a),
                                e = c === d;
                            this.processInput(f.$el, {
                                previewDone: !0,
                                dry: e,
                                originalValue: c
                            }), h = a
                        }, this)) : f.on("option:select", function(a, b) {
                            this.processInput(f.$el)
                        }, this), this.widgets.push(f);
                        break;
                    case "color-palette":
                        g = _.findIndex(b.options, function(a) {
                            return a.value === d || !(!_.isUndefined(a.value) || a.content !== d)
                        }), f = new a.ui.ColorPalette(_.extend({}, _.omit(b, "type", "group", "index"), {
                            selected: g
                        })), f.$el.attr({
                            "data-attribute": c,
                            "data-type": b.type
                        }), f.render(), i = $("<label/>", {
                            html: b.label || c
                        }), e = $("<div/>").append(i, f.el), b.previewMode ? (h = f.selection, f.on("options:mouseout close", function() {
                            f.selection = h, this.processInput(f.$el, {
                                previewCancel: !0,
                                dry: !0
                            })
                        }, this), f.on("option:hover", function(a, b) {
                            f.selection = a, this.processInput(f.$el, {
                                dry: !0
                            })
                        }, this), f.on("option:select", function(a, b) {
                            var c = _.isUndefined(h) ? void 0 : f.getSelectionValue(h),
                                d = f.getSelectionValue(a),
                                e = c === d;
                            this.processInput(f.$el, {
                                previewDone: !0,
                                dry: e,
                                originalValue: c
                            }), h = a
                        }, this)) : f.on("option:select", function(a, b) {
                            this.processInput(f.$el)
                        }, this), this.widgets.push(f);
                        break;
                    case "select-button-group":
                        b.multi ? (g = [], _.each(b.options, function(a, b) {
                            var c = _.isUndefined(a.value) ? a.content : a.value,
                                e = _.find(d, function(a) {
                                    return _.isEqual(c, a)
                                });
                            e && g.push(b)
                        })) : g = _.findIndex(b.options, function(a) {
                            return !!_.isEqual(a.value, d) || !(!_.isUndefined(a.value) || a.content !== d)
                        }), f = new a.ui.SelectButtonGroup(_.extend({}, _.omit(b, "type", "group", "index"), {
                            selected: g
                        })), f.$el.attr({
                            "data-attribute": c,
                            "data-type": b.type
                        }), f.render(), i = $("<label/>", {
                            html: b.label || c
                        }), e = $("<div/>").append(i, f.el), b.previewMode ? (h = f.selection, f.on("mouseout", function() {
                            f.selection = h, this.processInput(f.$el, {
                                previewCancel: !0,
                                dry: !0
                            })
                        }, this), f.on("option:hover", function(a, c) {
                            b.multi ? f.selection = _.uniq(f.selection.concat([a])) : f.selection = a, this.processInput(f.$el, {
                                dry: !0
                            })
                        }, this), f.on("option:select", function(a, b) {
                            var c = _.isUndefined(h) ? void 0 : f.getSelectionValue(h),
                                d = f.getSelectionValue(a),
                                e = _.isEqual(c, d);
                            this.processInput(f.$el, {
                                previewDone: !0,
                                dry: e,
                                originalValue: c
                            }), h = a
                        }, this)) : f.on("option:select", function(a, b) {
                            this.processInput(f.$el)
                        }, this), this.widgets.push(f);
                        break;
                    default:
                        e = this.renderOwnFieldContent({
                            options: b,
                            type: b.type,
                            label: b.label || c,
                            attribute: c,
                            value: d
                        })
                }
                return e
            },
            renderGroup: function(a) {
                a = a || {};
                var b = $("<div/>").addClass("group").attr("data-name", a.name),
                    c = $("<h3/>").addClass("group-label").text(a.label || a.name);
                return b.append(c)
            },
            renderOwnFieldContent: function(a) {
                var b, c, d, e, f, g, h, i;
                switch (i = $("<label/>").text(a.label), a.type) {
                    case "number":
                        c = $("<input/>", {
                            type: "number",
                            min: a.options.min,
                            max: a.options.max,
                            step: a.options.step
                        }).val(a.value), b = [i, $("<div/>").addClass("input-wrapper").append(c)];
                        break;
                    case "range":
                        i.addClass("with-output"), e = $("<output/>").text(a.value), f = $("<span/>").addClass("units").text(a.options.unit), c = $("<input/>", {
                            type: "range",
                            name: a.type,
                            min: a.options.min,
                            max: a.options.max,
                            step: a.options.step
                        }).val(a.value), c.on("change input", function() {
                            e.text(c.val())
                        }), b = [i, e, f, c];
                        break;
                    case "textarea":
                        c = $("<textarea/>").text(a.value), b = [i, $("<div/>").addClass("input-wrapper").append(c)];
                        break;
                    case "content-editable":
                        var j = _.isString(a.value) ? a.value.replace(/\n/g, "<br>").replace(/ /g, "&nbsp;") : "";
                        c = $("<div/>").prop("contenteditable", !0).css("display", "inline-block").html(j).on("blur", this.onContentEditableBlur), b = [i, $("<div/>").addClass("input-wrapper").append(c)];
                        break;
                    case "select":
                        var k = a.options.items;
                        c = $("<select/>"), a.options.multiple && c.prop({
                            size: a.options.size || k.length,
                            multiple: !0
                        });
                        var l = function(b) {
                            return a.options.multiple ? _.find(a.value, function(a) {
                                return _.isEqual(b, a)
                            }) : _.isEqual(b, a.value)
                        };
                        _.each(k, function(a) {
                            var b = $("<option/>", {
                                value: a.value
                            }).text(a.content);
                            l(a.value) && b.attr("selected", "selected"), c.append(b)
                        }), b = [i, c];
                        break;
                    case "toggle":
                        g = $("<span><i/></span>"), c = $("<input/>", {
                            type: "checkbox"
                        }).prop("checked", !!a.value), d = $("<div/>").addClass(a.type), b = [i, d.append(c, g)];
                        break;
                    case "color":
                        c = $("<input/>", {
                            type: "color"
                        }).val(a.value), b = [i, c];
                        break;
                    case "text":
                        c = $("<input/>", {
                            type: "text"
                        }).val(a.value), b = [i, $("<div/>").addClass("input-wrapper").append(c)];
                        break;
                    case "object":
                        c = $("<div/>"), h = $("<div/>").addClass("object-properties"), b = [i, c.append(h)];
                        break;
                    case "list":
                        g = $("<button/>").addClass("btn-list-add").text(a.options.addButtonLabel || "+"), h = $("<div/>").addClass("list-items"), c = $("<div/>"), b = [i, c.append(g, h)]
                }
                return c && c.addClass(a.type).attr({
                    "data-type": a.type,
                    "data-attribute": a.attribute
                }), $.fn.append.apply($("<div>"), b).children()
            },
            onContentEditableBlur: function(a) {
                var b = $("<input/>", {
                    disabled: !0,
                    tabIndex: -1,
                    style: {
                        width: "1px",
                        height: "1px",
                        border: "none",
                        margin: 0,
                        padding: 0
                    }
                }).appendTo(this.$el);
                b.focus(), b[0].setSelectionRange(0, 0), b.blur().remove(), $(a.target).trigger("change")
            },
            replaceHTMLEntity: function(a, b) {
                return this.HTMLEntities[b] || ""
            },
            renderObjectProperty: function(a) {
                a = a || {};
                var b = $("<div/>", {
                    "data-property": a.property,
                    "class": "object-property"
                });
                return b
            },
            renderListItem: function(a) {
                a = a || {};
                var b = $("<button/>").addClass("btn-list-del").text(a.options.removeButtonLabel || "-"),
                    c = $("<div/>", {
                        "data-index": a.index,
                        "class": "list-item"
                    });
                return c.append(b)
            },
            renderFieldContainer: function(a) {
                a = a || {};
                var b = $("<div/>", {
                    "data-field": a.path,
                    "class": "field " + a.type + "-field"
                });
                return b
            },
            renderTemplate: function(b, c, d, e) {
                b = b || this.$el, e = e || {}, this.resolveBindings(c);
                var f = this.renderFieldContainer({
                    path: d,
                    type: c.type
                });
                c.when && !this.isExpressionValid(c.when) && (f.addClass("hidden"), c.when.otherwise && c.when.otherwise.unset && this.unsetProperty(d));
                var g = this.getCellAttributeValue(d, c),
                    h = this.renderFieldContent(c, d, g);
                if (f.append(h), a.util.setAttributesBySelector(f, c.attrs), "list" === c.type) _.each(g, function(a, b) {
                    var e = this.renderListItem({
                        index: b,
                        options: c
                    });
                    this.renderTemplate(e, c.item, d + "/" + b), h.children(".list-items").append(e)
                }, this);
                else if ("object" === c.type) {
                    c.flatAttributes = a.util.flattenObject(c.properties, "/", function(a) {
                        return a.type
                    });
                    var i = _.map(c.flatAttributes, function(a, b) {
                        return a.path = b, a
                    });
                    i = _.sortBy(i, function(a) {
                        return a.index
                    }), _.each(i, function(a) {
                        var b = this.renderObjectProperty({
                            property: a.path
                        });
                        this.renderTemplate(b, a, d + "/" + a.path), h.children(".object-properties").append(b)
                    }, this)
                }
                e.replace ? b.find('[data-field="' + d + '"]').replaceWith(f) : b.append(f)
            },
            updateInputPosition: function() {
                var a = this._byPath["position/x"],
                    b = this._byPath["position/y"],
                    c = this.getModel().get("position");
                a && a.val(c.x), b && b.val(c.y)
            },
            updateInputSize: function() {
                var a = this._byPath["size/width"],
                    b = this._byPath["size/height"],
                    c = this.getModel().get("size");
                a && a.val(c.width), b && b.val(c.height)
            },
            updateInputAngle: function() {
                var a = this._byPath.angle,
                    b = this.getModel().get("angle");
                a && a.val(b)
            },
            validateInput: function(a, b, c) {
                switch (a) {
                    case "select-box":
                    case "color-palette":
                    case "select-button-group":
                        return !0;
                    default:
                        return this.options.validateInput(b, c, a)
                }
            },
            onChangeInput: function(a) {
                this.processInput($(a.target))
            },
            processInput: function(a, b) {
                var c = a.attr("data-attribute"),
                    d = a.attr("data-type");
                if (this.validateInput(d, a[0], c)) {
                    this.options.live && this.updateCell(a, c, b);
                    var e = this.getFieldValue(a[0], d),
                        f = this.parse(d, e, a[0]);
                    this.trigger("change:" + c, f, a[0], b)
                }
            },
            updateDependants: function(a) {
                _.each(this._when[a], function(a) {
                    var b = this._byPath[a.path],
                        c = b.closest(".field"),
                        d = c.hasClass("hidden"),
                        e = this.isExpressionValid(a.expression);
                    c.toggleClass("hidden", !e), a.expression.otherwise && a.expression.otherwise.unset && this.options.live && (e ? d && this.updateCell(b, a.path) : (this.unsetProperty(a.path), this.renderTemplate(null, this.flatAttributes[a.path], a.path, {
                        replace: !0
                    }), this.trigger("render")))
                }, this)
            },
            unsetProperty: function(b, c) {
                var d = this.getModel(),
                    e = b.split("/"),
                    f = _.first(e),
                    g = e.slice(1).join("/");
                if (c = c || {}, c.inspector = this.cid, c["inspector_" + this.cid] = !0, "attrs" == b) d.removeAttr(g, c);
                else if (b == f) d.unset(f, c);
                else {
                    var h = _.merge({}, d.get(f)),
                        i = a.util.unsetByPath(h, g, "/");
                    d.set(f, i, c)
                }
            },
            getOptions: function(a) {
                if (0 !== a.length) {
                    var b = a.attr("data-attribute"),
                        c = this.flatAttributes[b];
                    if (!c) {
                        var d = a.parent().closest("[data-attribute]"),
                            e = d.attr("data-attribute");
                        c = this.getOptions(d);
                        var f = b.replace(e + "/", ""),
                            g = c;
                        c = g.item || g.flatAttributes[f], c.parent = g
                    }
                    return c
                }
            },
            updateCell: function(b, c, d) {
                var e = this.getModel(),
                    f = {};
                b ? f[c] = b : f = this._byPath, this.startBatchCommand();
                var g = {},
                    h = {};
                _.each(f, function(b, c) {
                    if (!b.closest(".field").hasClass("hidden")) {
                        var d, f, i = b.attr("data-type");
                        switch (i) {
                            case "list":
                                f = this.findParentListByPath(c), f ? (d = c.substr(f.length + 1), a.util.setByPath(g[f], d, [], "/")) : g[c] = [];
                                break;
                            case "object":
                                break;
                            default:
                                if (!this.validateInput(i, b[0], c)) return;
                                var j = this.getFieldValue(b[0], i),
                                    k = this.parse(i, j, b[0]),
                                    l = this.getOptions(b);
                                if (l.valueRegExp) {
                                    var m = a.util.getByPath(e.attributes, c, "/") || l.defaultValue;
                                    k = m.replace(new RegExp(l.valueRegExp), "$1" + k + "$3")
                                }
                                if (f = this.findParentListByPath(c), f && g[f]) return d = c.substr(f.length + 1), void a.util.setByPath(g[f], d, k, "/");
                                h[c] = k
                        }
                    }
                }, this), _.each(h, function(a, b) {
                    this.setProperty(b, a, d), this.updateBindings(b), this.updateDependants(b)
                }, this), _.each(g, function(a, b) {
                    this.setProperty(b, a, _.extend({
                        rewrite: !0
                    }, d)), this.updateBindings(b), this.updateDependants(b)
                }, this), this.stopBatchCommand()
            },
            findParentListByPath: function(a) {
                for (var b, c, d = a.split("/"), e = 0, f = d[e], g = this.flatAttributes[f]; e < d.length - 1 && (!g || "list" !== g.type);) g && "object" === g.type && (b = g.properties), c = d[++e], f += "/" + c, g = b ? b[c] : this.flatAttributes[f];
                return f !== a ? f : null
            },
            getFieldValue: function(a, b) {
                if (_.isFunction(this.options.getFieldValue)) {
                    var c = this.options.getFieldValue(a, b);
                    if (c) return c.value
                }
                var d = $(a);
                switch (b) {
                    case "select-box":
                    case "color-palette":
                    case "select-button-group":
                        var e = d.data("view");
                        if (!e) throw new Error("ui.Inspector: can not read value of removed " + b);
                        return e.getSelectionValue();
                    case "content-editable":
                        return d.html().replace(/<br(\s*)\/*>/gi, "\n").replace(/<[p|div]\s/gi, "\n$0").replace(/(<([^>]+)>)/gi, "").replace(/&(\w+);/gi, this.replaceHTMLEntity).replace(/\n$/, "");
                    default:
                        return d.val()
                }
            },
            setProperty: function(b, c, d) {
                d = d || {}, d.inspector = this.cid;
                var e = a.dia.Cell.prototype.prop,
                    f = this.getModel();
                d.previewDone && e.call(f, b, d.originalValue, {
                    rewrite: !0,
                    silent: !0
                }), _.isUndefined(c) ? a.dia.Cell.prototype.removeProp.call(f, b, d) : e.call(f, b, _.clone(c), d)
            },
            parse: function(a, b, c) {
                switch (a) {
                    case "number":
                    case "range":
                        b = parseFloat(b);
                        break;
                    case "toggle":
                        b = c.checked
                }
                return b
            },
            startBatchCommand: function() {
                this.inBatch || (this.inBatch = !0, this.getModel().startBatch("inspector", {
                    cid: this.cid
                }))
            },
            stopBatchCommand: function() {
                this.inBatch && (this.getModel().stopBatch("inspector", {
                    cid: this.cid
                }), this.inBatch = !1)
            },
            addListItem: function(a) {
                var b = $(a.target),
                    c = b.closest("[data-attribute]"),
                    d = c.attr("data-attribute"),
                    e = this.getOptions(c),
                    f = c.children(".list-items").children(".list-item").last(),
                    g = 0 === f.length ? -1 : parseInt(f.attr("data-index"), 10),
                    h = g + 1,
                    i = this.renderListItem({
                        index: h,
                        options: e
                    });
                this.renderTemplate(i, e.item, d + "/" + h), b.parent().children(".list-items").append(i), i.find("input:first").focus(), this.trigger("render"), this.options.live && this.updateCell()
            },
            deleteListItem: function(a) {
                var b = $(a.target).closest(".list-item");
                b.nextAll(".list-item").each(function() {
                    var a = parseInt($(this).attr("data-index"), 10),
                        b = a - 1;
                    $(this).find("[data-field]").each(function() {
                        $(this).attr("data-field", $(this).attr("data-field").replace("/" + a, "/" + b))
                    }), $(this).find("[data-attribute]").each(function() {
                        $(this).attr("data-attribute", $(this).attr("data-attribute").replace("/" + a, "/" + b))
                    }), $(this).attr("data-index", b)
                }), b.remove(), this.trigger("render"), this.options.live && this.updateCell()
            },
            pointerdown: function(a) {
                this.startBatchCommand(), this._$activeField = $(a.target).closest(".field").addClass("is-in-action"), $(document).on("mouseup.inspector touchend.inspector", this.pointerup)
            },
            pointerup: function() {
                $(document).off(".inspector", this.pointerup), this._$activeField && (this._$activeField.removeClass("is-in-action"), this._$activeField = null)
            },
            pointerfocusin: function(a) {
                $(a.target).closest(".field").addClass("is-focused")
            },
            pointerfocusout: function(a) {
                $(a.target).closest(".field").removeClass("is-focused")
            },
            onRemove: function() {
                this.removeWidgets(), this === this.constructor.instance && (this.constructor.instance = null), $(document).off("mouseup", this.stopBatchCommand)
            },
            removeWidgets: function() {
                _.invoke(this.widgets, "remove"), this.widgets = []
            },
            onGroupLabelClick: function(a) {
                a.preventDefault(), this.options.multiOpenGroups || this.closeGroups();
                var b = $(a.target).closest(".group");
                this.toggleGroup(b)
            },
            toggleGroup: function(a) {
                var b = _.isString(a) ? this.$('.group[data-name="' + a + '"]') : $(a);
                b.hasClass("closed") ? this.openGroup(b) : this.closeGroup(b)
            },
            closeGroup: function(a, b) {
                b = b || {};
                var c = _.isString(a) ? this.$('.group[data-name="' + a + '"]') : $(a);
                !b.init && c.hasClass("closed") || (c.addClass("closed"), this.trigger("group:close", c.data("name"), b))
            },
            openGroup: function(a, b) {
                b = b || {};
                var c = _.isString(a) ? this.$('.group[data-name="' + a + '"]') : $(a);
                (b.init || c.hasClass("closed")) && (c.removeClass("closed"), this.trigger("group:open", c.data("name"), b))
            },
            closeGroups: function() {
                _.each(this.$groups, this.closeGroup, this)
            },
            openGroups: function() {
                _.each(this.$groups, this.openGroup, this)
            },
            COMPOSITE_OPERATORS: ["not", "and", "or", "nor"],
            PRIMITIVE_OPERATORS: ["eq", "ne", "regex", "text", "lt", "lte", "gt", "gte", "in", "nin", "equal"],
            _isComposite: function(a) {
                return _.intersection(this.COMPOSITE_OPERATORS, _.keys(a)).length > 0
            },
            _isPrimitive: function(a) {
                var b = _.keys(this.options.operators).concat(this.PRIMITIVE_OPERATORS);
                return _.intersection(b, _.keys(a)).length > 0
            },
            _evalCustomPrimitive: function(a, b, c) {
                return !!this.options.operators[a].apply(this, [this.getModel(), b].concat(c))
            },
            _evalPrimitive: function(a) {
                return _.reduce(a, function(a, b, c) {
                    return _.reduce(b, function(a, b, d) {
                        var e = this.getCellAttributeValue(d);
                        if (_.isFunction(this.options.operators[c])) return this._evalCustomPrimitive(c, e, b);
                        switch (c) {
                            case "eq":
                                return b == e;
                            case "ne":
                                return b != e;
                            case "regex":
                                return new RegExp(b).test(e);
                            case "text":
                                return !b || _.isString(e) && e.toLowerCase().indexOf(b) > -1;
                            case "lt":
                                return e < b;
                            case "lte":
                                return e <= b;
                            case "gt":
                                return e > b;
                            case "gte":
                                return e >= b;
                            case "in":
                                return _.contains(b, e);
                            case "nin":
                                return !_.contains(b, e);
                            case "equal":
                                return _.isEqual(b, e);
                            default:
                                return a
                        }
                    }, !1, this)
                }, !1, this)
            },
            _evalExpression: function(a) {
                return this._isPrimitive(a) ? this._evalPrimitive(a) : _.reduce(a, function(a, b, c) {
                    if ("not" == c) return !this._evalExpression(b);
                    var d = _.map(b, this._evalExpression, this);
                    switch (c) {
                        case "and":
                            return _.every(d);
                        case "or":
                            return _.some(d);
                        case "nor":
                            return !_.some(d);
                        default:
                            return a
                    }
                }, !1, this)
            },
            _extractVariables: function(a) {
                return _.isArray(a) || this._isComposite(a) ? _.reduce(a, function(a, b) {
                    return a.concat(this._extractVariables(b))
                }, [], this) : _.reduce(a, function(a, b) {
                    return _.keys(b)
                }, [])
            },
            isExpressionValid: function(a) {
                return a = _.omit(a, "otherwise", "dependencies"), this._evalExpression(a)
            },
            extractExpressionPaths: function(a) {
                var b = a && a.dependencies || [];
                return a = _.omit(a, "otherwise", "dependencies"), _.uniq(this._extractVariables(a).concat(b))
            },
            getGroupsStateKey: function() {
                if (_.isFunction(this.options.stateKey)) return this.options.stateKey(this.getModel());
                throw new Error("Inspector: Option stateKey must be a function")
            },
            storeGroupsState: function() {
                var b = this.getGroupsStateKey();
                a.ui.Inspector.groupStates[b] = _.map(this.$(".group.closed"), function(a) {
                    return $(a).attr("data-name")
                })
            },
            getGroupsState: function() {
                return a.ui.Inspector.groupStates[this.getGroupsStateKey()]
            },
            restoreGroupsState: function() {
                var b = function(a, b) {
                        _.each(b.options.groups, function(b, c) {
                            a(b, c) ? this.closeGroup(c) : this.openGroup(c)
                        }, b)
                    },
                    c = this.getGroupsStateKey();
                a.ui.Inspector.groupStates[c] ? b(function(b, d) {
                    return _.contains(a.ui.Inspector.groupStates[c], d)
                }, this) : b(function(a) {
                    return a.closed
                }, this)
            }
        }, {
            groupStates: {},
            instance: null,
            create: function(a, b) {
                b = b || {}, _.defaults(b, {
                    restoreGroupsState: !0,
                    storeGroupsState: !0
                });
                var c = b.cell || b.cellView.model,
                    d = this.instance;
                return d && d.options.cell === c || (d && d.el.parentNode && (b.storeGroupsState && d.storeGroupsState(), d.updateCell(), d.remove()), d = new this(b).render(), this.instance = d, $(a).html(d.el), b.restoreGroupsState && d.restoreGroupsState()), d
            },
            close: function() {
                var a = this.instance;
                a && a.remove()
            }
        })
    }(joint);
    joint.ui.FreeTransform = joint.mvc.View.extend({
        className: "free-transform",
        events: {
            "mousedown .resize": "startResizing",
            "mousedown .rotate": "startRotating",
            "touchstart .resize": "startResizing",
            "touchstart .rotate": "startRotating"
        },
        DIRECTIONS: ["nw", "n", "ne", "e", "se", "s", "sw", "w"],
        POSITIONS: ["top-left", "top", "top-right", "right", "bottom-right", "bottom", "bottom-left", "left"],
        options: {
            cellView: void 0,
            rotateAngleGrid: 15,
            preserveAspectRatio: !1,
            minWidth: 0,
            minHeight: 0,
            maxWidth: 1 / 0,
            maxHeight: 1 / 0,
            allowOrthogonalResize: !0,
            allowRotation: !0
        },
        init: function() {
            this.options.cellView && _.defaults(this.options, {
                cell: this.options.cellView.model,
                paper: this.options.cellView.paper,
                graph: this.options.cellView.paper.model
            }), _.bindAll(this, "update", "remove", "pointerup", "pointermove"), joint.ui.FreeTransform.clear(this.options.paper), $(document.body).on("mousemove touchmove", this.pointermove), $(document).on("mouseup touchend", this.pointerup), this.listenTo(this.options.graph, "all", this.update), this.listenTo(this.options.graph, "reset", this.remove), this.listenTo(this.options.cell, "remove", this.remove), this.listenTo(this.options.paper, "blank:pointerdown", this.remove), this.listenTo(this.options.paper, "scale translate", this.update), this.options.paper.$el.append(this.el), joint.ui.FreeTransform.registerInstanceToPaper(this, this.options.paper)
        },
        renderHandles: function() {
            var a = $("<div/>").prop("draggable", !1),
                b = a.clone().addClass("rotate"),
                c = _.map(this.POSITIONS, function(b) {
                    return a.clone().addClass("resize").attr("data-position", b)
                });
            this.$el.empty().append(c, b)
        },
        render: function() {
            this.renderHandles(), this.$el.attr("data-type", this.options.cell.get("type")), this.$el.toggleClass("no-orthogonal-resize", this.options.preserveAspectRatio || !this.options.allowOrthogonalResize), this.$el.toggleClass("no-rotation", !this.options.allowRotation), this.update()
        },
        update: function() {
            var a = this.options.paper.viewport.getCTM(),
                b = this.options.cell.getBBox();
            b.x *= a.a, b.x += a.e, b.y *= a.d, b.y += a.f, b.width *= a.a, b.height *= a.d;
            var c = g.normalizeAngle(this.options.cell.get("angle") || 0),
                d = "rotate(" + c + "deg)";
            this.$el.css({
                width: b.width + 4,
                height: b.height + 4,
                left: b.x - 3,
                top: b.y - 3,
                transform: d,
                "-webkit-transform": d,
                "-ms-transform": d
            });
            var e = Math.floor(c * (this.DIRECTIONS.length / 360));
            if (e != this._previousDirectionsShift) {
                var f = this.DIRECTIONS.slice(e).concat(this.DIRECTIONS.slice(0, e));
                this.$(".resize").removeClass(this.DIRECTIONS.join(" ")).each(function(a, b) {
                    $(b).addClass(f[a])
                }), this._previousDirectionsShift = e
            }
        },
        calculateTrueDirection: function(a) {
            var b = this.options.cell,
                c = g.normalizeAngle(b.get("angle")),
                d = this.POSITIONS.indexOf(a);
            return d += Math.floor(c * (this.POSITIONS.length / 360)), d %= this.POSITIONS.length, this.POSITIONS[d]
        },
        startResizing: function(a) {
            a.stopPropagation(), this.options.graph.trigger("batch:start");
            var b = $(a.target).data("position"),
                c = this.calculateTrueDirection(b),
                d = 0,
                e = 0;
            _.each(b.split("-"), function(a) {
                d = {
                    left: -1,
                    right: 1
                }[a] || d, e = {
                    top: -1,
                    bottom: 1
                }[a] || e
            });
            var f = this.toValidResizeDirection(b),
                h = {
                    "top-right": "bottomLeft",
                    "top-left": "corner",
                    "bottom-left": "topRight",
                    "bottom-right": "origin"
                }[f];
            this._initial = {
                angle: g.normalizeAngle(this.options.cell.get("angle") || 0),
                resizeX: d,
                resizeY: e,
                selector: h,
                direction: f,
                relativeDirection: b,
                trueDirection: c
            }, this._action = "resize", this.startOp(a.target)
        },
        toValidResizeDirection: function(a) {
            return {
                top: "top-left",
                bottom: "bottom-right",
                left: "bottom-left",
                right: "top-right"
            }[a] || a
        },
        startRotating: function(a) {
            a.stopPropagation(), this.options.graph.trigger("batch:start");
            var b = this.options.cell.getBBox().center(),
                c = this.options.paper.snapToGrid({
                    x: a.clientX,
                    y: a.clientY
                });
            this._initial = {
                centerRotation: b,
                modelAngle: g.normalizeAngle(this.options.cell.get("angle") || 0),
                startAngle: g.point(c).theta(b)
            }, this._action = "rotate", this.startOp(a.target)
        },
        pointermove: function(a) {
            if (this._action) {
                a = joint.util.normalizeEvent(a);
                var b = this.options,
                    c = b.paper.snapToGrid({
                        x: a.clientX,
                        y: a.clientY
                    }),
                    d = b.paper.options.gridSize,
                    e = b.cell,
                    f = this._initial;
                switch (this._action) {
                    case "resize":
                        var h = e.getBBox(),
                            i = g.point(c).rotate(h.center(), f.angle),
                            j = i.difference(h[f.selector]()),
                            k = f.resizeX ? j.x * f.resizeX : h.width,
                            l = f.resizeY ? j.y * f.resizeY : h.height;
                        if (k = g.snapToGrid(k, d), l = g.snapToGrid(l, d), k = Math.max(k, b.minWidth || d), l = Math.max(l, b.minHeight || d), k = Math.min(k, b.maxWidth), l = Math.min(l, b.maxHeight), b.preserveAspectRatio) {
                            var m = h.width * l / h.height,
                                n = h.height * k / h.width;
                            m > k ? l = n : k = m
                        }
                        h.width == k && h.height == l || e.resize(k, l, {
                            freeTransform: this.cid,
                            direction: f.direction,
                            relativeDirection: f.relativeDirection,
                            trueDirection: f.trueDirection,
                            ui: !0,
                            minWidth: b.minWidth,
                            minHeight: b.minHeight,
                            maxWidth: b.maxWidth,
                            maxHeight: b.maxHeight,
                            preserveAspectRatio: b.preserveAspectRatio
                        });
                        break;
                    case "rotate":
                        var o = f.startAngle - g.point(c).theta(f.centerRotation);
                        e.rotate(g.snapToGrid(f.modelAngle + o, b.rotateAngleGrid), !0)
                }
            }
        },
        pointerup: function(a) {
            this._action && (this.stopOp(), this.options.graph.trigger("batch:stop"), this._action = null, this._initial = null)
        },
        onRemove: function() {
            $(document.body).off("mousemove touchmove", this.pointermove), $(document).off("mouseup touchend", this.pointerup), joint.ui.FreeTransform.unregisterInstanceFromPaper(this, this.options.paper)
        },
        startOp: function(a) {
            a && ($(a).addClass("in-operation"), this._elementOp = a), this.$el.addClass("in-operation")
        },
        stopOp: function() {
            this._elementOp && ($(this._elementOp).removeClass("in-operation"), this._elementOp = null), this.$el.removeClass("in-operation")
        }
    }, {
        instancesByPaper: {},
        clear: function(a) {
            a.trigger("freetransform:create"), this.removeInstancesForPaper(a)
        },
        removeInstancesForPaper: function(a) {
            _.invoke(this.getInstancesForPaper(a), "remove")
        },
        getInstancesForPaper: function(a) {
            return this.instancesByPaper[a.cid] || {}
        },
        registerInstanceToPaper: function(a, b) {
            this.instancesByPaper[b.cid] || (this.instancesByPaper[b.cid] = {}), this.instancesByPaper[b.cid][a.cid] = a
        },
        unregisterInstanceFromPaper: function(a, b) {
            this.instancesByPaper[b.cid] && (this.instancesByPaper[b.cid][a.cid] = null)
        }
    });
    joint.ui.Tooltip = joint.mvc.View.extend({
        className: "tooltip",
        options: {
            left: void 0,
            right: void 0,
            top: void 0,
            bottom: void 0,
            position: void 0,
            positionSelector: void 0,
            direction: "auto",
            minResizedWidth: 100,
            padding: 0,
            rootTarget: null,
            target: null,
            trigger: "hover",
            viewport: {
                selector: null,
                padding: 0
            },
            dataAttributePrefix: "tooltip",
            template: '<div class="tooltip-arrow"/><div class="tooltip-arrow-mask"/><div class="tooltip-content"/>'
        },
        init: function() {
            this.eventNamespace = ("." + this.className + this.cid).replace(/ /g, "_"), this.settings = {};
            var a = this.options.trigger.split(" ");
            _.bindAll(this, "render", "hide", "show", "toggle", "isVisible", "position"), this.options.rootTarget ? (this.$rootTarget = $(this.options.rootTarget), _.each(a, function(a) {
                switch (a) {
                    case "click":
                        this.$rootTarget.on("click" + this.eventNamespace, this.options.target, this.toggle);
                        break;
                    case "hover":
                        this.$rootTarget.on("mouseover" + this.eventNamespace, this.options.target, this.render);
                        break;
                    case "focus":
                        this.$rootTarget.on("focusin" + this.eventNamespace, this.options.target, this.render)
                }
            }, this)) : (this.$target = $(this.options.target), _.each(a, function(a) {
                switch (a) {
                    case "click":
                        this.$target.on("click" + this.eventNamespace, this.toggle);
                        break;
                    case "hover":
                        this.$target.on("mouseover" + this.eventNamespace, this.render);
                        break;
                    case "focus":
                        this.$target.on("focusin" + this.eventNamespace, this.render)
                }
            }, this)), this.$el.append(this.options.template)
        },
        onRemove: function() {
            this.options.rootTarget ? this.$rootTarget.off(this.eventNamespace) : this.$target.off(this.eventNamespace)
        },
        hide: function() {
            var a = this.settings;
            a && (this.unbindHideActions(a.currentTarget), this.$el.removeClass(a.className), this.$el.remove())
        },
        show: function(a) {
            this.render(a || {
                target: this.options.target
            })
        },
        toggle: function(a) {
            this.isVisible() ? this.hide() : this.show(a)
        },
        isVisible: function() {
            return document.body.contains(this.el)
        },
        render: function(a) {
            var b = _.isUndefined(a.x) || _.isUndefined(a.y) ? null : a,
                c = $(a.target).closest(this.options.target)[0],
                d = this.settings = this.getTooltipSettings(c);
            d.currentTarget = c, this.bindHideActions(c);
            var e;
            e = b ? {
                x: b.x,
                y: b.y,
                width: 1,
                height: 1
            } : joint.util.getElementBBox(c), this.$(".tooltip-content").html(d.content), this.$el.hide(), this.$el.removeClass("left right top bottom"), this.$el.addClass(d.className), $(document.body).append(this.$el);
            var f = this.$("img");
            f.length ? f.on("load", _.bind(function() {
                this.position(e), this.$el.addClass("rendered")
            }, this)) : (this.position(e), this.$el.addClass("rendered"))
        },
        getTooltipSettings: function(a) {
            var b = this.loadDefinitionFromElementData(a);
            return this.evaluateOptions(a, b)
        },
        unbindHideActions: function(a) {
            var b = this.eventNamespace + ".remove";
            $(a).off(b), clearInterval(this.interval)
        },
        bindHideOnRemoveTarget: function(a) {
            clearInterval(this.interval), this.interval = setInterval(_.bind(function() {
                $.contains(document, a) || (clearInterval(this.interval), this.hide())
            }, this), 500)
        },
        bindHideActions: function(a) {
            var b = this.settings,
                c = $(a),
                d = this.eventNamespace + ".remove";
            this.bindHideOnRemoveTarget(a), _.each(this.options.trigger.split(" "), function(a) {
                var e = {
                        hover: ["mouseout", "mousedown"],
                        focus: ["focusout"]
                    },
                    f = e[a] || [];
                b.hideTrigger && (f = b.hideTrigger.split(" ") || []), _.each(f, function(a) {
                    c.on(a + d, this.hide)
                }, this)
            }, this)
        },
        evaluateOptions: function(a, b) {
            b = b || {};
            var c = _.extend({}, b, this.options);
            return _.each(c, function(d, e) {
                var f = _.isFunction(d) ? d(a) : d;
                c[e] = _.isUndefined(f) || _.isNull(f) ? b[e] : f
            }), this.normalizePosition(c), c
        },
        loadDefinitionFromElementData: function(a) {
            if (!a) return {};
            var b = function(a) {
                    return "left" === a || "bottom" === a || "top" === a || "right" === a
                },
                c = this.getAllAttrs(a, "data-" + this.options.dataAttributePrefix),
                d = {};
            return _.each(c, function(a, c) {
                "" === c && (c = "content"), b(c) || (d[c] = a)
            }), d
        },
        getAllAttrs: function(a, b) {
            var c = b || "",
                d = a.attributes,
                e = {};
            return _.each(d, function(a) {
                if (_.startsWith(a.name, c)) {
                    var b = _.camelCase(a.name.slice(c.length));
                    e[b] = a.value
                }
            }), e
        },
        normalizePosition: function(a) {
            var b = a.left || a.right || a.top || a.bottom;
            !a.position && b && (a.left && (a.position = "left"), a.right && (a.position = "right"), a.top && (a.position = "top"), a.bottom && (a.position = "bottom")), !a.positionSelector && b && (a.positionSelector = b)
        },
        position: function(a) {
            var b = this.settings;
            this.$el.show(), this.$el.css("width", "auto");
            var c = this.getViewportViewBBox(),
                d = this.getTooltipBBox(a, c),
                e = {};
            "left" === b.position || "right" === b.position ? e.top = a.y + a.height / 2 - d.y : "top" === b.position || "bottom" === b.position ? e.left = a.x + a.width / 2 - d.x : e.top = a.y + a.height / 2 - d.y, this.$el.css({
                left: d.x,
                top: d.y,
                width: d.width || "auto"
            });
            var f = this.$(".tooltip-arrow, .tooltip-arrow-mask");
            f.removeAttr("style"), f.css(e), b.direction && "off" !== b.direction && this.$el.addClass("auto" === b.direction ? b.position || "left" : b.direction)
        },
        getViewportViewBBox: function() {
            var a = this.settings,
                b = a.viewport.selector ? $(a.currentTarget).closest(a.viewport.selector) : "html",
                c = joint.util.getElementBBox(b),
                d = $(window);
            a.viewport.selector || (c.width = d.width() + d.scrollLeft(), c.height = d.height() + d.scrollTop());
            var e = a.viewport.padding || 0;
            return c.x += e, c.y += e, c.width -= 2 * e, c.height -= 2 * e, c
        },
        getPosition: function(a, b, c, d) {
            var e = this.settings,
                f = e.position || "left",
                g = e.padding,
                h = Math.min(e.minResizedWidth, c.width + g),
                i = {
                    left: function(f) {
                        var i = {
                            x: a.x + a.width + g,
                            y: b.y + b.height / 2 - c.height / 2
                        };
                        if (f) {
                            var j = d.x + d.width - i.x;
                            if (j > h && j < c.width + g && (i.width = j), j < h) return e.position = "right", this.right(!1)
                        }
                        return i
                    },
                    right: function(f) {
                        var i = {
                            x: a.x - c.width - g,
                            y: b.y + b.height / 2 - c.height / 2
                        };
                        if (f) {
                            var j = a.x - g - d.x;
                            if (j > h && j < c.width + g && (i.width = j, i.x = d.x), j < h) return e.position = "left", this.left(!1)
                        }
                        return i
                    },
                    top: function(f) {
                        var h = {
                            x: b.x + b.width / 2 - c.width / 2,
                            y: a.y + a.height + g
                        };
                        if (f) {
                            var i = d.y + d.height - (a.y + a.height + g);
                            if (i < c.height) return e.position = "bottom", this.bottom(!1)
                        }
                        return h
                    },
                    bottom: function(f) {
                        var h = {
                            x: b.x + b.width / 2 - c.width / 2,
                            y: a.y - c.height - g
                        };
                        if (f) {
                            var i = a.y - g - d.y;
                            if (i < c.height) return e.position = "top", this.top(!1)
                        }
                        return h
                    }
                };
            return i[f](h > 0)
        },
        getTooltipBBox: function(a, b) {
            var c, d, e = this.measureTooltipElement();
            c = $(this.settings.positionSelector), d = c[0] ? joint.util.getElementBBox(c[0]) : a;
            var f = this.getPosition(d, a, e, b);
            f.y < b.y ? f.y = b.y : f.y + e.height > b.y + b.height && (f.y = b.y + b.height - e.height);
            var g = f.width || e.width;
            return f.x < b.x ? f.x = b.x : f.x + g > b.x + b.width && (f.x = b.x + b.width - g), f
        },
        measureTooltipElement: function() {
            var a = this.$el.clone().appendTo($("body")).css({
                    left: -1e3,
                    top: -500
                }),
                b = {
                    width: a.outerWidth(),
                    height: a.outerHeight()
                };
            return a.remove(), b
        }
    });
    joint.ui.Snaplines = joint.mvc.View.extend({
        options: {
            paper: void 0,
            distance: 10
        },
        className: "snaplines",
        init: function() {
            _.bindAll(this, "hide"), this.$horizontal = $("<div>").addClass("snapline horizontal").appendTo(this.el), this.$vertical = $("<div>").addClass("snapline vertical").appendTo(this.el), this.$el.hide().appendTo(this.options.paper.el), this.startListening()
        },
        startListening: function() {
            this.stopListening(), this.listenTo(this.options.paper, "cell:pointerdown", this.captureCursorOffset), this.listenTo(this.options.paper, "cell:pointermove", this.snapWhileMoving), this.listenTo(this.options.paper.model, "batch:stop", this.onBatchStop), $(document).on("mouseup touchend", this.hide), this.filterTypes = {}, this.filterCells = {}, this.filterFunction = void 0, _.isArray(this.options.filter) ? _.each(this.options.filter, function(a) {
                _.isString(a) ? this.filterTypes[a] = !0 : this.filterCells[a.id] = !0
            }, this) : _.isFunction(this.options.filter) && (this.filterFunction = this.options.filter)
        },
        onBatchStop: function(a) {
            a = a || {}, "resize" === a.batchName && this.snapWhileResizing(a.cell, a)
        },
        captureCursorOffset: function(a, b, c, d) {
            if (this.canElementMove(a)) {
                var e = a.model.get("position");
                this._cursorOffset = {
                    x: c - e.x,
                    y: d - e.y
                }
            }
        },
        snapWhileResizing: function(a, b) {
            if (b.ui && !b.snapped && b.direction && b.trueDirection) {
                var c = this.options.paper.findViewByModel(a);
                if (c && c.model.isElement()) {
                    var d = a.getBBox(),
                        e = d.bbox(a.get("angle")),
                        f = e.origin(),
                        h = e.corner(),
                        i = g.normalizeAngle(a.get("angle")),
                        j = this.options.distance,
                        k = null,
                        l = null,
                        m = {
                            vertical: 0,
                            horizontal: 0
                        },
                        n = b.direction,
                        o = b.trueDirection,
                        p = b.relativeDirection;
                    if (o.indexOf("right") !== -1 ? m.vertical = h.x : m.vertical = f.x, o.indexOf("bottom") !== -1 ? m.horizontal = h.y : m.horizontal = f.y, _.find(this.options.paper.model.getElements(), function(b) {
                            if (b.id === a.id || b.isEmbeddedIn(a) || this.filterTypes[b.get("type")] || this.filterCells[b.id] || this.filterFunction && this.filterFunction(b)) return !1;
                            var c = b.getBBox().bbox(b.get("angle")),
                                d = c.origin(),
                                e = c.corner(),
                                f = {
                                    vertical: [d.x, e.x],
                                    horizontal: [d.y, e.y]
                                };
                            return _.each(f, function(a, b) {
                                a = _.map(a, function(a) {
                                    return {
                                        position: a,
                                        distance: Math.abs(a - m[b])
                                    }
                                }), a = _.filter(a, function(a) {
                                    return a.distance < j
                                }), a = _.sortBy(a, function(a, b) {
                                    return a.distance > b.distance ? 1 : a.distance === b.distance ? 0 : -1
                                }), f[b] = a
                            }), _.isNull(k) && f.vertical.length > 0 && (k = f.vertical[0].position), _.isNull(l) && f.horizontal.length > 0 && (l = f.horizontal[0].position), _.isNumber(k) && _.isNumber(l)
                        }, this), this.hide(), _.isNumber(k) || _.isNumber(l)) {
                        var q = 0;
                        _.isNumber(k) && (q = o.indexOf("right") !== -1 ? k - e.corner().x : e.origin().x - k);
                        var r = 0;
                        _.isNumber(l) && (r = o.indexOf("bottom") !== -1 ? l - e.corner().y : e.origin().y - l);
                        var s = 0,
                            t = 0,
                            u = !(i % 90);
                        if (u) 90 === i || 270 === i ? (s = r, t = q) : (s = q, t = r);
                        else {
                            var v;
                            v = i >= 0 && i < 90 ? 1 : i >= 90 && i < 180 ? 4 : i >= 180 && i < 270 ? 3 : 2, l && k && (r > q ? (r = 0, l = null) : (q = 0, k = null));
                            var w = g.toRad(i % 90);
                            q && (s = 3 === v ? q / Math.cos(w) : q / Math.sin(w)), r && (t = 3 === v ? r / Math.cos(w) : r / Math.sin(w));
                            var x = 1 === v || 3 === v;
                            switch (p) {
                                case "top":
                                case "bottom":
                                    t = r ? r / (x ? Math.cos(w) : Math.sin(w)) : q / (x ? Math.sin(w) : Math.cos(w));
                                    break;
                                case "left":
                                case "right":
                                    s = q ? q / (x ? Math.cos(w) : Math.sin(w)) : r / (x ? Math.sin(w) : Math.cos(w))
                            }
                        }
                        switch (p) {
                            case "top":
                            case "bottom":
                                s = 0;
                                break;
                            case "left":
                            case "right":
                                t = 0
                        }
                        var y = this.options.paper.options.gridSize,
                            z = Math.max(d.width + s, y),
                            A = Math.max(d.height + t, y);
                        b.minWidth && b.minWidth > y && (z = Math.max(z, b.minWidth)), b.minHeight && b.minHeight > y && (A = Math.max(A, b.minHeight)), b.maxWidth && (z = Math.min(z, b.maxWidth)), b.maxHeight && (A = Math.min(A, b.maxHeight)), b.preserveAspectRatio && (s > t ? A = z * (d.height / d.width) : z = A * (d.width / d.height)), z === d.width && A === d.height || a.resize(z, A, {
                            snaplines: this.cid,
                            restrictedArea: this.options.paper.getRestrictedArea(c),
                            direction: n,
                            relativeDirection: p,
                            trueDirection: o,
                            snapped: !0
                        });
                        var B = a.getBBox().bbox(i),
                            C = 1;
                        k && Math.abs(B.x - k) > C && Math.abs(B.width + B.x - k) > C && (k = null), l && Math.abs(B.y - l) > C && Math.abs(B.height + B.y - l) > C && (l = null), this.show({
                            vertical: k,
                            horizontal: l
                        })
                    }
                }
            }
        },
        canElementMove: function(a) {
            return a && a.model.isElement() && a.can("elementMove")
        },
        snapWhileMoving: function(a, b, c, d) {
            if (this.canElementMove(a)) {
                var e = a.model,
                    f = e.get("position"),
                    h = e.get("size"),
                    i = g.rect(_.extend({
                        x: c - this._cursorOffset.x,
                        y: d - this._cursorOffset.y
                    }, h)),
                    j = i.center(),
                    k = i.bbox(e.get("angle")),
                    l = k.origin(),
                    m = k.corner(),
                    n = this.options.distance,
                    o = null,
                    p = null,
                    q = 0,
                    r = 0;
                if (_.find(this.options.paper.model.getElements(), function(a) {
                        if (a === e || a.isEmbeddedIn(e) || this.filterTypes[a.get("type")] || this.filterCells[a.id] || this.filterFunction && this.filterFunction(a)) return !1;
                        var b = a.getBBox().bbox(a.get("angle")),
                            c = b.center(),
                            d = b.origin(),
                            f = b.corner();
                        return _.isNull(o) && (Math.abs(c.x - j.x) < n ? (o = c.x, q = .5) : Math.abs(d.x - l.x) < n ? o = d.x : Math.abs(d.x - m.x) < n ? (o = d.x, q = 1) : Math.abs(f.x - m.x) < n ? (o = f.x, q = 1) : Math.abs(f.x - l.x) < n && (o = f.x)), _.isNull(p) && (Math.abs(c.y - j.y) < n ? (p = c.y, r = .5) : Math.abs(d.y - l.y) < n ? p = d.y : Math.abs(d.y - m.y) < n ? (p = d.y, r = 1) : Math.abs(f.y - m.y) < n ? (p = f.y, r = 1) : Math.abs(f.y - l.y) < n && (p = f.y)), _.isNumber(o) && _.isNumber(p)
                    }, this), this.hide(), _.isNumber(o) || _.isNumber(p)) {
                    _.isNumber(o) && (k.x = o - q * k.width), _.isNumber(p) && (k.y = p - r * k.height);
                    var s = k.center(),
                        t = s.x - i.width / 2,
                        u = s.y - i.height / 2;
                    e.translate(t - f.x, u - f.y, {
                        restrictedArea: this.options.paper.getRestrictedArea(a),
                        snapped: !0
                    }), this.show({
                        vertical: o,
                        horizontal: p
                    })
                }
            }
        },
        show: function(a) {
            a = a || {};
            var b = this.options.paper.viewport.getCTM();
            a.horizontal ? this.$horizontal.css("top", a.horizontal * b.d + b.f).show() : this.$horizontal.hide(), a.vertical ? this.$vertical.css("left", a.vertical * b.a + b.e).show() : this.$vertical.hide(), this.$el.show()
        },
        hide: function() {
            this.$el.hide()
        },
        onRemove: function() {
            $(document).off("mouseup", this.hide)
        }
    });
    joint.ui.TextEditor = joint.mvc.View.extend({
        options: {
            text: void 0,
            newlineCharacterBBoxWidth: 10,
            placeholder: void 0,
            focus: !0,
            debug: !1,
            useNativeSelection: !0,
            annotateUrls: !1,
            urlAnnotation: {
                attrs: {
                    "class": "url-annotation",
                    fill: "lightblue",
                    "text-decoration": "underline"
                }
            },
            textareaAttributes: {
                autocorrect: "off",
                autocomplete: "off",
                autocapitalize: "off",
                spellcheck: "false",
                tabindex: "0"
            }
        },
        className: "text-editor",
        events: {
            "keyup textarea": "onKeyup",
            "input textarea": "onInput",
            "copy textarea": "onCopy",
            "cut textarea": "onCut",
            "paste textarea": "onPaste",
            "mousedown .char-selection-box": "onMousedown",
            "dblclick .char-selection-box": "onDoubleClick",
            "click .char-selection-box": "onTripleClick"
        },
        selection: {
            start: null,
            end: null
        },
        selecting: !1,
        init: function() {
            _.bindAll(this, "onMousedown", "onMousemove", "onMouseup", "onDoubleClick", "onTripleClick", "onKeydown", "onAfterPaste", "onAfterKeydown"), this.setTextElement(this.options.text), $(document.body).on("mousemove", this.onMousemove), $(document.body).on("mouseup", this.onMouseup), $(document.body).on("keydown", this.onKeydown), this.options.cellView ? this.$viewport = $(this.options.cellView.paper.viewport) : this.$viewport = $(this.options.text), this.options.annotations && this.setAnnotations(this.options.annotations)
        },
        setTextElement: function(a) {
            this.$elText && this.unbindTextElement(), this.options.text = a, this.$elText = $(a), this.$elText.on("mousedown", this.onMousedown), this.$elText.on("dblclick", this.onDoubleClick), this.$elText.on("click", this.onTripleClick)
        },
        render: function(a) {
            this.$caret = $("<div>", {
                "class": "caret"
            }), this.$selection = $("<div>"), this.$selectionBox = $("<div>", {
                "class": "char-selection-box"
            }), this.$el.append(this.$caret, this.$selection), this.$textareaContainer = $("<div>", {
                "class": "textarea-container"
            }), this.$textarea = $("<textarea>", this.options.textareaAttributes), this.textarea = this.$textarea[0], this._textContent = this.textarea.value = this.getTextContent(), this._textareaValueBeforeInput = this.textarea.value, this.$textareaContainer.append(this.textarea), this.options.focus && this.$el.append(this.$textareaContainer), $(a || document.body).append(this.$el);
            var b = V(this.options.text).bbox();
            return this.$textareaContainer.css({
                left: b.x,
                top: b.y
            }), this.focus(), V(this.options.text).attr("cursor", "text"), this.selectAll(), this
        },
        annotateURLBeforeCaret: function(a) {
            var b = this.getURLBoundary(Math.max(a - 1, 0));
            return !!b && (this.annotateURL(this.getAnnotations() || [], b[0], b[1]), !0)
        },
        hasSelection: function() {
            return _.isNumber(this.selection.start) && _.isNumber(this.selection.end) && this.selection.start !== this.selection.end
        },
        textContentHasChanged: function() {
            return this._textContent !== this.textarea.value
        },
        restoreTextAreaSelectionDirection: function() {
            this._selectionDirection && (this.textarea.selectionDirection = this._selectionDirection)
        },
        storeSelectionDirection: function() {
            this._selectionDirection = this.textarea.selectionDirection
        },
        onKeydown: function(a) {
            this.options.debug && console.log("onKeydown(): ", a.keyCode), this.hasSelection() && (this.deselect(), this.restoreTextAreaSelectionDirection()), setTimeout(this.onAfterKeydown, 0), this._copied = !1, this._selectionStartBeforeInput = this.textarea.selectionStart, this._selectionEndBeforeInput = this.textarea.selectionEnd
        },
        onAfterKeydown: function() {
            this.$textarea.is(":focus") && (this.storeSelectionDirection(), this.textarea.selectionStart === this.textarea.selectionEnd ? this.setCaret(this.textarea.selectionStart) : this.select(this.textarea.selectionStart, this.textarea.selectionEnd))
        },
        onKeyup: function(a) {
            this.textContentHasChanged() && this.onInput(a)
        },
        onCopy: function(a) {
            this._copied || this.copyToClipboard()
        },
        onCut: function(a) {
            this._copied || this.copyToClipboard()
        },
        copyToClipboard: function() {
            var a = document.queryCommandSupported && document.queryCommandSupported("copy");
            a && (this._copied = !0, document.execCommand("copy"))
        },
        onInput: function(a) {
            if (this.textContentHasChanged()) {
                var b = this.textarea.value.length - this._textareaValueBeforeInput.length,
                    c = {
                        start: this._selectionStartBeforeInput,
                        end: this._selectionEndBeforeInput
                    },
                    d = {
                        start: this.textarea.selectionStart,
                        end: this.textarea.selectionEnd
                    };
                this.options.debug && console.log("onInput()", a, "selectionBeforeInput", c, "selectionAfterInput", d, "diffLength", b);
                var e = this.inferTextOperationType(c, d, b),
                    f = !1,
                    g = this.getAnnotations();
                if (this.options.annotateUrls && "insert" === e) {
                    var h = this.textarea.value.substr(c.start, b);
                    this.options.debug && console.log("onInput()", "inserted text", h), /\s/.test(h) && (f = this.annotateURLBeforeCaret(c.start), f && (g = this.shiftAnnotations(g, d.end, b)))
                }
                if (g && (f || (g = this.annotate(g, c, d, b)), this.options.debug && console.log("onInput()", "modified annotations", g), this._currentAnnotationAttributes && "insert" === e)) {
                    var i = {
                        start: c.start,
                        end: d.end,
                        attrs: this._currentAnnotationAttributes
                    };
                    g.push(i), this._currentAnnotationAttributes = void 0, this.options.debug && console.log("onInput()", "insert annotation", i, "final annotations", g)
                }
                this._annotations = g, this.trigger("text:change", this.textarea.value, this._textareaValueBeforeInput, g, c, d), this._selectionBeforeInput = d, this._textareaValueBeforeInput = this.textarea.value, this._textContent = this.textarea.value
            }
        },
        onPaste: function(a) {
            this.options.debug && console.log("onPaste()"), this._textareaValueBeforeInput = this.textarea.value, setTimeout(this.onAfterPaste, 0)
        },
        onAfterPaste: function() {
            this.setCaret(this.textarea.selectionStart)
        },
        onMousedown: function(a) {
            if (3 !== a.originalEvent.detail) {
                this.options.debug && console.log("onMousedown()");
                var b = this.getCharNumFromEvent(a);
                this.startSelecting(), this.select(b), a.preventDefault(), a.stopPropagation()
            }
        },
        onMousemove: function(a) {
            if (this.selectionInProgress()) {
                this.options.debug && console.log("onMousemove()");
                var b = this.getCharNumFromEvent(a);
                this.storeSelectionDirection(), this.select(null, b), a.preventDefault(), a.stopPropagation()
            }
        },
        onMouseup: function(a) {
            this.selectionInProgress() && (this.options.debug && console.log("onMouseup()"), this.stopSelecting(), this.trigger("select:changed", this.selection.start, this.selection.end))
        },
        onDoubleClick: function(a) {
            this.options.debug && console.log("onDoubleClick()");
            var b = this.getCharNumFromEvent(a),
                c = this.getWordBoundary(b);
            this.select(c[0], c[1]), a.preventDefault(), a.stopPropagation()
        },
        onTripleClick: function(a) {
            3 === a.originalEvent.detail && (this.options.debug && console.log("onTripleClick()"), this.hideCaret(), this.selectAll(), a.preventDefault(), a.stopPropagation())
        },
        findAnnotationsUnderCursor: function(a, b) {
            return V.findAnnotationsAtIndex(a, b)
        },
        findAnnotationsInSelection: function(a, b, c) {
            return V.findAnnotationsBetweenIndexes(a, b, c)
        },
        inferTextOperationType: function(a, b, c) {
            return a.start === a.end && b.start === b.end && c > 0 ? "insert" : a.start === a.end && b.start === b.end && c <= 0 ? "delete-single" : a.start !== a.end && b.start === b.end && b.start === a.start ? "delete" : a.start !== a.end && b.start !== a.start ? "delete-insert" : void 0
        },
        annotate: function(a, b, c, d) {
            var e = [],
                f = this.inferTextOperationType(b, c, d);
            return _.each(a, function(a) {
                var g, h;
                switch (f) {
                    case "insert":
                        a.start < b.start && b.start <= a.end ? a.end += d : a.start >= b.start && (a.start += d, a.end += d);
                        break;
                    case "delete-single":
                        a.start < b.start && b.start <= a.end && b.start !== c.start ? a.end += d : a.start <= b.start && b.start < a.end && b.start === c.start ? a.end += d : a.start >= b.start && (a.start += d, a.end += d);
                        break;
                    case "delete":
                        a.start <= b.start && b.start <= a.end ? b.end <= a.end ? a.end += d : a.end += c.start - a.end : a.start >= b.start && a.start < b.end ? (g = a.end - a.start, h = b.end - a.start, a.start = b.start, a.end = a.start + g - h) : a.start >= b.end && (a.start += d, a.end += d);
                        break;
                    case "delete-insert":
                        if (a.start <= b.start && b.start <= a.end) b.start < a.end && (b.end > a.end ? a.end = c.end : a.end = c.end + (a.end - b.end));
                        else if (a.start >= b.start && a.start <= b.end) {
                            var i = c.start - b.start;
                            h = b.end - a.start, g = a.end - a.start, a.start = b.start + i, a.end = a.start + g - h
                        } else a.start >= b.start && a.end <= b.end ? a.start = a.end = 0 : a.start >= b.end && (a.start += d, a.end += d);
                        break;
                    default:
                        this.options.debug && console.log("ui.TextEditor: Unknown text operation.")
                }
                a.end > a.start && e.push(a)
            }, this), e
        },
        shiftAnnotations: function(a, b, c) {
            return V.shiftAnnotations(a, b, c)
        },
        setCurrentAnnotation: function(a) {
            this._currentAnnotationAttributes = a
        },
        setAnnotations: function(a) {
            this._annotations = a
        },
        getAnnotations: function() {
            return this._annotations
        },
        getCombinedAnnotationAttrsAtIndex: function(a, b) {
            var c = {};
            return _.each(b, function(b) {
                _.isUndefined(b.start && _.isUndefined(b.end)) ? V.mergeAttrs(c, b.attrs) : a >= b.start && a < b.end && V.mergeAttrs(c, b.attrs)
            }), c
        },
        getSelectionAttrs: function(a, b) {
            var c = a.start,
                d = a.end;
            if (c === d && 0 === c) return this.getCombinedAnnotationAttrsAtIndex(c, b);
            if (c === d) return this.getCombinedAnnotationAttrsAtIndex(c - 1, b);
            for (var e, f = c; f < d; f++) {
                var g = this.getCombinedAnnotationAttrsAtIndex(f, b);
                if (e && !_.isEqual(e, g)) {
                    e = joint.util.flattenObject(V.mergeAttrs({}, e)), g = joint.util.flattenObject(V.mergeAttrs({}, g));
                    var h = {};
                    _.each(g, function(a, b) {
                        e[b] === g[b] && joint.util.setByPath(h, b, a)
                    }), e = h
                } else e = g
            }
            return e
        },
        getTextContent: function() {
            var a = this.options.text,
                b = V(a).find(".v-line");
            return 0 === b.length ? a.textContent : _.reduce(b, function(a, b, c, d) {
                var e = b.node.textContent;
                return b.hasClass("v-empty-line") && (e = ""), c === d.length - 1 ? a + e : a + e + "\n"
            }, "")
        },
        startSelecting: function() {
            this.selecting = !0
        },
        stopSelecting: function() {
            this.selecting = !1
        },
        selectionInProgress: function() {
            return this.selecting === !0
        },
        selectAll: function() {
            return this.select(0, this.getNumberOfChars())
        },
        select: function(a, b) {
            return this.options.debug && console.log("select(", a, b, ")"), _.isUndefined(b) && (b = a), _.isNumber(a) && (this.selection.start = a), _.isNumber(b) && (this.selection.end = b), _.isNumber(this.selection.end) || (this.selection.end = this.selection.start), _.isNumber(this.selection.start) && _.isNumber(this.selection.end) && (this.selection.start === this.selection.end ? (this.clearSelection(), this.focus(), this.setCaret(this.selection.start)) : (this.hideCaret(), this.renderSelection(this.selection.start, this.selection.end)), this.trigger("select:change", this.selection.start, this.selection.end)), this
        },
        setTextAreaSelection: function(a, b) {
            var c = {
                start: a,
                end: b
            };
            c = this.normalizeSelectionRange(c), this.textarea.focus(), this.textarea.selectionStart = c.start, this.textarea.selectionEnd = c.end
        },
        renderSelection: function(a, b) {
            this.options.debug && console.log("renderSelection()");
            var c = {
                start: a,
                end: b
            };
            if (c = this.normalizeSelectionRange(c), this.clearSelection(), this.options.useNativeSelection) {
                this.$viewport && (this._viewportUserSelectBefore = this.$viewport.css("user-select"), this.$viewport.css({
                    "-webkit-user-select": "all",
                    "-moz-user-select": "all",
                    "user-select": "all"
                }));
                var d = c.end - c.start;
                this.selectTextInElement(this.options.text, c.start, d)
            } else this.renderSelectionBoxes(c.start, c.end)
        },
        normalizeSelectionStartAndLength: function(a, b, c) {
            var d = a.substr(0, b),
                e = a.substr(b, c),
                f = this.countLineBreaks(d),
                g = this.countLineBreaks(e);
            b -= f, c -= g;
            var h = this.countEmptyLines(d),
                i = this.countEmptyLines(e);
            return b += h, c += h, c -= h, c += i, {
                start: b,
                length: c
            }
        },
        selectTextInElement: function(a, b, c) {
            if (_.isFunction(a.selectSubString) && this.selectTextInElementUsingSelectSubString(a, b, c), !this.actualSelectionMatchesExpectedSelection(b, c)) try {
                this.selectTextInElementUsingRanges(a, b, c)
            } catch (d) {
                this.options.debug && console.log(d), _.isFunction(a.selectSubString) && this.selectTextInElementUsingSelectSubString(a, b, c)
            }
        },
        selectTextInElementUsingSelectSubString: function(a, b, c) {
            var d = this.normalizeSelectionStartAndLength(this.getTextContent(), b, c);
            try {
                a.selectSubString(d.start, d.length)
            } catch (e) {
                this.options.debug && console.log(e)
            }
        },
        selectTextInElementUsingRanges: function(a, b, c) {
            var d = window.getSelection();
            d.removeAllRanges();
            var e = this.normalizeSelectionStartAndLength(this.getTextContent(), b, c);
            b = 0 + e.start, c = 0 + e.length;
            for (var f, g, h, i, j, k, l = this.getTextNodesFromDomElement(a), m = 0, n = b + c; c > 0 && l.length > 0;) f = l.shift(), h = m, i = m + f.length, (h >= b && h < n || i > b && i <= n || b >= h && b < i || n > h && n <= i) && (j = Math.max(b - h, 0), k = Math.min(j + Math.min(c, f.length), i), g = document.createRange(), g.setStart(f, j), g.setEnd(f, k), d.addRange(g), c -= k - j), m += f.length
        },
        actualSelectionMatchesExpectedSelection: function(a, b) {
            var c = window.getSelection(),
                d = c.toString(),
                e = this.getExpectedSelectedContent(a, b);
            return d = d.replace(/\s/g, " "), e === d
        },
        getExpectedSelectedContent: function(a, b) {
            var c = this.getTextContent(),
                d = c.substr(a, b);
            return d = d.replace(/(\n\r|\r|\n){2,}/g, "-"), d = d.replace(/\n\r|\r|\n/g, ""), d = d.replace(/\s/g, " ")
        },
        getTextNodesFromDomElement: function(a) {
            var b = [];
            return _.each(a.childNodes, function(a) {
                _.isUndefined(a.tagName) ? b.push(a) : b = b.concat(this.getTextNodesFromDomElement(a))
            }, this), b
        },
        renderSelectionBoxes: function(a, b) {
            this.options.debug && console.log("renderSelectionBoxes()"), this.$selection.empty();
            for (var c, d, e, f = this.getFontSize(), g = this.getTextTransforms(), h = g.rotation, i = a; i < b; i++) {
                var j = this.$selectionBox.clone();
                try {
                    e = this.getCharBBox(i)
                } catch (k) {
                    this.trigger("select:out-of-range", a, b);
                    break
                }
                d && 0 === h && Math.round(e.y) === Math.round(d.y) && Math.round(e.height) === Math.round(d.height) && Math.round(e.x) === Math.round(d.x + d.width) ? c.css({
                    width: "+=" + e.width
                }) : (j.css({
                    left: e.x,
                    top: e.y - e.height,
                    width: e.width,
                    height: e.height,
                    "-webkit-transform": "rotate(" + h + "deg)",
                    "-webkit-transform-origin": "0% 100%",
                    "-moz-transform": "rotate(" + h + "deg)",
                    "-moz-transform-origin": "0% 100%"
                }), this.$selection.append(j), c = j), d = e
            }
            e && this.$textareaContainer.css({
                left: e.x,
                top: e.y - f * g.scaleY
            })
        },
        clearSelection: function() {
            return this.options.debug && console.log("clearSelection()"), this.$selection.empty(), this.options.text.selectSubString && (this.$viewport && this._viewportUserSelectBefore && this.$viewport.css({
                "-webkit-user-select": this._viewportUserSelectBefore,
                "-moz-user-select": this._viewportUserSelectBefore,
                "user-select": this._viewportUserSelectBefore
            }), window.getSelection().removeAllRanges()), this
        },
        deselect: function() {
            return this.options.debug && console.log("deselect()"), this.stopSelecting(), this.clearSelection(), this.setTextAreaSelection(this.selection.start, this.selection.end), this
        },
        getSelectionStart: function() {
            return this.selection.start
        },
        getSelectionEnd: function() {
            return this.selection.end
        },
        getSelectionRange: function() {
            return this.normalizeSelectionRange(this.selection)
        },
        normalizeSelectionRange: function(a) {
            return a = _.clone(a), a.start > a.end && (a.end = [a.start, a.start = a.end][0]), a
        },
        getSelectionLength: function() {
            var a = this.getSelectionRange();
            return a.end - a.start
        },
        getSelection: function() {
            var a = this.getSelectionRange();
            return this.getTextContent().slice(a.start, a.end)
        },
        getWordBoundary: function(a) {
            for (var b = this.textarea.value, c = /\W/, d = a; d;) {
                if (c.test(b[d])) {
                    d += 1;
                    break
                }
                d -= 1
            }
            for (var e = this.getNumberOfChars(), f = a; f <= e && !c.test(b[f]);) f += 1;
            return d < f ? [d, f] : [f, d]
        },
        getURLBoundary: function(a) {
            for (var b = this.textarea.value, c = /\s/, d = /[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/, e = a; e;) {
                if (c.test(b[e])) {
                    e += 1;
                    break
                }
                e -= 1
            }
            for (var f = this.getNumberOfChars(), g = a; g <= f && !c.test(b[g]);) g += 1;
            if (d.test(b.substring(e, g))) return [e, g]
        },
        annotateURL: function(a, b, c) {
            var d = this.textarea.value.substring(b, c),
                e = _.extend({
                    url: d
                }, this.options.urlAnnotation);
            return e.start = b, e.end = c, _.isEqual(e, _.last(a)) || a.push(e), a
        },
        getCharBBox: function(a) {
            if (this.isLineEnding(a)) {
                var b = this.getCharBBox(a - 1);
                return b.x = b.x2, b.y = b.y2, b.width = this.options.newlineCharacterBBoxWidth || 10, b
            }
            var c = this.realToSvgCharNum(a),
                d = this.options.text,
                e = d.getStartPositionOfChar(c),
                f = d.getEndPositionOfChar(c),
                g = d.getExtentOfChar(c);
            e = this.localToScreenCoordinates(e), f = this.localToScreenCoordinates(f);
            var h = this.getTextTransforms(),
                i = e.x,
                j = e.y,
                k = g.width * h.scaleX,
                l = g.height * h.scaleY;
            return {
                x: i,
                y: j,
                width: k,
                height: l,
                x2: f.x,
                y2: f.y
            }
        },
        realToSvgCharNum: function(a) {
            for (var b = 0, c = 0; c <= a; c++) this.isLineEnding(c) && (b += 1);
            return a - b
        },
        selectionStartToSvgCharNum: function(a) {
            return a - this.nonEmptyLinesBefore(a)
        },
        isLineEnding: function(a) {
            var b = this.textarea.value;
            return "\n" === b[a] && a > 0 && "\n" !== b[a - 1]
        },
        svgToRealCharNum: function(a) {
            for (var b = 0, c = 0; c <= a + b; c++) this.isLineEnding(c) && (b += 1);
            return a + b
        },
        localToScreenCoordinates: function(a) {
            return $(this.options.text).show(), V.transformPoint(a, this.options.text.getCTM())
        },
        getNumberOfChars: function() {
            return this.getTextContent().length
        },
        getCharNumFromEvent: function(a) {
            var b = this.options.text,
                c = a.clientX,
                d = a.clientY,
                e = V(b).toLocalPoint(c, d),
                f = b.getCharNumAtPosition(e);
            if (f < 0) return this.getNumberOfChars();
            var g = this.localToScreenCoordinates(e),
                h = this.getCharBBox(this.svgToRealCharNum(f));
            return Math.abs(h.x - g.x) < Math.abs(h.x + h.width - g.x) ? this.svgToRealCharNum(f) : this.svgToRealCharNum(f) + 1
        },
        lineNumber: function(a) {
            var b = this.textarea.value.substr(0, a);
            return this.countLineBreaks(b)
        },
        emptyLinesBefore: function(a) {
            for (var b = this.textarea.value.split(/\n\r|\r|\n/g), c = this.lineNumber(a), d = 0, e = c - 1; e >= 0; e--) b[e] || (d += 1);
            return d
        },
        countLineBreaks: function(a) {
            return (a.match(/\n\r|\r|\n/g) || []).length
        },
        countEmptyLines: function(a) {
            return (a.match(/(\n\r|\r|\n){2,}/g) || []).length
        },
        nonEmptyLinesBefore: function(a) {
            return this.lineNumber(a) - this.emptyLinesBefore(a)
        },
        isEmptyLine: function(a) {
            var b = this.textarea.value.split(/\n\r|\r|\n/g);
            return !b[a]
        },
        isEmptyLineUnderSelection: function(a) {
            var b = this.lineNumber(a);
            return this.isEmptyLine(b)
        },
        getTextTransforms: function() {
            var a = this.options.text.getCTM();
            return V.decomposeMatrix(a)
        },
        getFontSize: function() {
            return parseInt(V(this.options.text).attr("font-size"), 10)
        },
        getTextAnchor: function() {
            return V(this.options.text).attr("text-anchor") || ""
        },
        setCaret: function(a, b) {
            _.isObject(a) && (b = a, a = void 0), b = b || {};
            var c = this.options.text,
                d = this.getNumberOfChars(),
                e = this.selection.start,
                f = this.textarea.value;
            "undefined" != typeof a && (a = Math.min(Math.max(a, 0), d), e = this.selection.start = this.selection.end = a), b.silent || this.trigger("caret:change", e), this.setTextAreaSelection(e, e), this.options.debug && console.log("setCaret(", a, b, ")", "selectionStart", e, "isLineEnding", this.isLineEnding(e), "isEmptyLineUnderSelection", this.isEmptyLineUnderSelection(e), "svgCharNum", this.selectionStartToSvgCharNum(e), "nonEmptyLinesBefore", this.nonEmptyLinesBefore(e));
            var g;
            try {
                var h;
                this.isEmptyLineUnderSelection(e) || !this.isLineEnding(e) && f.length !== e ? (h = this.selectionStartToSvgCharNum(e), g = c.getStartPositionOfChar(h)) : (h = this.selectionStartToSvgCharNum(e) - 1, g = c.getEndPositionOfChar(h))
            } catch (i) {
                this.trigger("caret:out-of-range", e), g = {
                    x: 0,
                    y: 0
                }
            }
            var j = this.localToScreenCoordinates(g),
                k = this.getTextTransforms(),
                l = k.rotation,
                m = this.getFontSize() * k.scaleY;
            return this.options.placeholder && this.$caret.toggleClass("placeholder", 0 === d), this.$caret.css({
                left: j.x,
                top: j.y + (d ? -m : 0),
                height: m,
                "line-height": m + "px",
                "font-size": m + "px",
                "-webkit-transform": "rotate(" + l + "deg)",
                "-webkit-transform-origin": "0% 100%",
                "-moz-transform": "rotate(" + l + "deg)",
                "-moz-transform-origin": "0% 100%"
            }).attr({
                "text-anchor": this.getTextAnchor()
            }).show(), this.$textareaContainer.css({
                left: j.x,
                top: j.y + (d ? -m : 0)
            }), this.focus(), this
        },
        focus: function() {
            return this.options.debug && console.log("focus()"), this.showCaret(), this
        },
        blur: function() {
            return this.options.debug && console.log("blur()"), this.hideCaret(), this
        },
        showCaret: function() {
            return this.options.debug && console.log("showCaret()"), this.$caret.show(), this
        },
        hideCaret: function() {
            return this.options.debug && console.log("hideCaret()"), this.$caret.hide(), this
        },
        unbindTextElement: function() {
            this.$elText.off("mousedown", this.onMousedown), this.$elText.off("dblclick", this.onDoubleClick), this.$elText.off("click", this.onTripleClick)
        },
        onRemove: function() {
            this.unbindTextElement(), $(document.body).off("mousemove", this.onMousemove), $(document.body).off("mouseup", this.onMouseup), $(document.body).off("keydown", this.onKeydown), V(this.options.text).attr("cursor", "")
        }
    }, _.extend({
        getTextElement: function(a) {
            var b = a.tagName.toUpperCase();
            if ("TEXT" === b || "TSPAN" === b || "TEXTPATH" === b) return "TEXT" === b ? a : this.getTextElement(a.parentNode)
        },
        edit: function(a, b) {
            b = b || {};
            var c = b.update !== !1;
            this.options = _.extend({}, b, {
                update: c
            });
            var d = this.getTextElement(a);
            if (!d) return void(this.options.debug && console.log("ui.TextEditor: cannot find a text element."));
            this.close(), this.ed = new joint.ui.TextEditor(_.extend({
                text: d
            }, b)), this.ed.on("all", this.trigger, this);
            var e;
            if (b.cellView) {
                if (e = b.cellView.paper.el, this.cellViewUnderEdit = b.cellView, this.cellViewUnderEditInteractiveOption = this.cellViewUnderEdit.options.interactive, this.cellViewUnderEdit.options.interactive = !1, b.annotationsProperty && !this.ed.getAnnotations()) {
                    var f = this.cellViewUnderEdit.model.prop(b.annotationsProperty);
                    f && this.ed.setAnnotations(this.deepCloneAnnotations(f))
                }
            } else {
                var g = V(d).svg();
                e = g.parentNode
            }
            return c && this.ed.on("text:change", function(a, c, e) {
                if (b.cellView) {
                    var f = null;
                    if (b.textProperty && (b.cellView.model.isLink() && "labels" === b.textProperty.substr(0, "labels".length) && (f = V($(V(d).node).closest(".label")[0]).index()), b.cellView.model.prop(b.textProperty, a, {
                            textEditor: this.ed.cid
                        })), b.annotationsProperty && b.cellView.model.prop(b.annotationsProperty, this.deepCloneAnnotations(e), {
                            rewrite: !0,
                            textEditor: this.ed.cid
                        }), null !== f) {
                        var g = V(b.cellView.el).find(".label");
                        d = g[f].findOne("text"), this.ed.setTextElement(d.node)
                    }
                } else V(d).text(a, e)
            }, this), this.ed.render(e), this
        },
        close: function() {
            if (this.ed) {
                if (this.ed.options.annotateUrls) {
                    var a = this.ed.getSelectionStart(),
                        b = this.findAnnotationsUnderCursor(),
                        c = _.find(b, function(a) {
                            return !!a.url && a
                        });
                    if (!c) {
                        var d = this.ed.annotateURLBeforeCaret(a);
                        d && this.applyAnnotations(this.getAnnotations())
                    }
                }
                this.ed.remove(), this.cellViewUnderEdit && (this.cellViewUnderEdit.options.interactive = this.cellViewUnderEditInteractiveOption), this.ed = this.cellViewUnderEdit = this.cellViewUnderEditInteractiveOption = void 0
            }
        },
        applyAnnotations: function(a) {
            var b = this.options;
            if (this.ed && b.update) {
                b.cellView && b.annotationsProperty ? (b.cellView.model.prop(b.annotationsProperty, this.deepCloneAnnotations(a), {
                    rewrite: !0
                }), this.ed.setAnnotations(a)) : V(this.ed.options.text).text(this.ed.getTextContent(), a);
                var c = this.getSelectionRange(),
                    d = this.getSelectionLength();
                d > 0 ? this.ed.select(c.start, c.end) : this.ed.setCaret()
            }
        },
        deepCloneAnnotations: function(a) {
            try {
                return JSON.parse(JSON.stringify(a))
            } catch (b) {
                return
            }
        },
        proxy: function(a, b) {
            if (this.ed) return this.ed[a].apply(this.ed, b)
        },
        setCurrentAnnotation: function(a) {
            return this.proxy("setCurrentAnnotation", arguments)
        },
        getAnnotations: function() {
            return this.proxy("getAnnotations", arguments)
        },
        setCaret: function() {
            return this.proxy("setCaret", arguments)
        },
        deselect: function() {
            return this.proxy("deselect", arguments)
        },
        selectAll: function() {
            return this.proxy("selectAll", arguments)
        },
        select: function() {
            return this.proxy("select", arguments)
        },
        getNumberOfChars: function() {
            return this.proxy("getNumberOfChars", arguments)
        },
        getCharNumFromEvent: function() {
            return this.proxy("getCharNumFromEvent", arguments)
        },
        getWordBoundary: function() {
            return this.proxy("getWordBoundary", arguments)
        },
        findAnnotationsUnderCursor: function() {
            return this.proxy("findAnnotationsUnderCursor", [this.ed.getAnnotations(), this.ed.getSelectionStart()])
        },
        findAnnotationsInSelection: function() {
            if (this.ed) {
                var a = this.ed.getSelectionRange();
                return this.proxy("findAnnotationsInSelection", [this.ed.getAnnotations(), a.start, a.end])
            }
        },
        getSelectionAttrs: function(a) {
            if (this.ed) {
                var b = this.ed.getSelectionRange();
                return this.proxy("getSelectionAttrs", [b, a])
            }
        },
        getSelectionLength: function() {
            return this.proxy("getSelectionLength", arguments)
        },
        getSelectionRange: function() {
            return this.proxy("getSelectionRange", arguments)
        }
    }, Backbone.Events));
    joint.ui.Dialog = joint.mvc.View.extend({
        className: "dialog",
        events: {
            "click .bg": "action",
            "click .btn-close": "action",
            "click .controls button": "action",
            "mousedown .titlebar": "onDragStart",
            "touchstart .titlebar": "onDragStart"
        },
        options: {
            draggable: !1,
            closeButtonContent: "&times;",
            closeButton: !0,
            inlined: !1,
            modal: !0
        },
        init: function() {
            _.bindAll(this, "onDrag", "onDragEnd")
        },
        render: function() {
            var a = $("<div/>", {
                    "class": "bg",
                    "data-action": "close"
                }),
                b = $("<div/>", {
                    "class": "fg"
                }),
                c = $("<div/>", {
                    "class": "titlebar"
                }),
                d = $("<div/>", {
                    "class": "body"
                }),
                e = $("<button/>", {
                    "class": "btn-close",
                    "data-action": "close",
                    html: this.options.closeButtonContent
                }),
                f = $("<div/>", {
                    "class": "controls"
                });
            return this.$el.toggleClass("draggable", !!this.options.draggable), this.options.type && this.$el.attr("data-type", this.options.type), this.options.inlined && this.$el.addClass("inlined"), this.options.modal && this.$el.addClass("modal"), this.options.width && b.width(this.options.width), this.options.title ? c.append(this.options.title) : c.addClass("empty"), this.options.content && d.append(this.options.content), this.options.buttons && _.each(this.options.buttons.reverse(), function(a) {
                var b = $("<button/>", {
                    "class": "control-button",
                    html: a.content,
                    "data-action": a.action
                });
                a.position && b.addClass(a.position), f.append(b)
            }), b.append(c, d, f), this.options.closeButton && b.append(e), this.$el.empty().append(a, b), this
        },
        open: function(a) {
            return this.delegateEvents(), this.on("action:close", this.close, this), $(document.body).on({
                "mousemove.dialog touchmove.dialog": this.onDrag,
                "mouseup.dialog touchend.dialog": this.onDragEnd
            }), $(a || document.body).append(this.render().el), this.$el.addClass("rendered"), this
        },
        close: function() {
            return this.remove(), this
        },
        onRemove: function() {
            $(document.body).off(".dialog", this.onDrag).off(".dialog", this.onDragStart)
        },
        action: function(a) {
            var b = $(a.target).closest("[data-action]"),
                c = b.attr("data-action");
            c && this.trigger("action:" + c)
        },
        onDragStart: function(a) {
            this.options.draggable && (a = joint.util.normalizeEvent(a), this._dx = a.clientX, this._dy = a.clientY, this._dragging = !0)
        },
        onDrag: function(a) {
            if (this._dragging) {
                a = joint.util.normalizeEvent(a);
                var b = this.$(".fg"),
                    c = b.offset();
                b.css({
                    top: c.top + (a.clientY - this._dy),
                    left: c.left + (a.clientX - this._dx),
                    margin: 0
                }), this._dx = a.clientX, this._dy = a.clientY
            }
        },
        onDragEnd: function() {
            this._dragging = !1
        }
    });
    joint.ui.FlashMessage = joint.ui.Dialog.extend({
        className: joint.ui.Dialog.prototype.className + " flash-message",
        options: _.merge({}, joint.ui.Dialog.prototype.options, {
            closeButton: !0,
            modal: !1,
            cascade: !0,
            closeAnimation: {
                delay: 2e3,
                duration: 200,
                easing: "swing",
                properties: {
                    opacity: 0
                }
            },
            openAnimation: {
                duration: 200,
                easing: "swing",
                properties: {
                    opacity: 1
                }
            }
        }),
        init: function() {
            _.bindAll(this, "startCloseAnimation"), joint.ui.Dialog.prototype.init.apply(this, arguments), this.on("close:animation:complete", this.close, this)
        },
        open: function() {
            joint.ui.Dialog.prototype.open.apply(this, arguments);
            var a = this.$(".fg");
            return this._foregroundHeight = a.height(), this.addToCascade(), a.css("height", 0), this.startOpenAnimation(), this.options.closeAnimation && this.options.closeAnimation.delay && setTimeout(this.startCloseAnimation, this.options.closeAnimation.delay), this
        },
        close: function() {
            return joint.ui.Dialog.prototype.close.apply(this, arguments), this.removeFromCascade(), this
        },
        addToCascade: function() {
            if (this.options.cascade) {
                var a = this.constructor.top;
                this.$(".fg").css("top", a), this.constructor.top += this._foregroundHeight + this.constructor.padding
            }
            this.constructor.opened.push(this)
        },
        removeFromCascade: function() {
            if (this.options.cascade) {
                for (var a = this.constructor.opened, b = !1, c = 0; c < a.length; c++) {
                    var d = a[c];
                    if (d.options.cascade && b) {
                        var e = parseInt(d.$(".fg").css("top"), 10);
                        d.$(".fg").css("top", e - this._foregroundHeight - this.constructor.padding)
                    }
                    d === this && (b = !0)
                }
                b && (this.constructor.top -= this._foregroundHeight + this.constructor.padding)
            }
            this.constructor.opened = _.without(this.constructor.opened, this)
        },
        startCloseAnimation: function() {
            this.$(".fg").animate(this.options.closeAnimation.properties, _.extend({
                complete: _.bind(function() {
                    this.trigger("close:animation:complete")
                }, this)
            }, this.options.closeAnimation))
        },
        startOpenAnimation: function() {
            var a = this.$(".fg");
            a.animate(_.extend({}, this.options.openAnimation.properties, {
                height: this._foregroundHeight
            }), _.extend({
                complete: _.bind(function() {
                    this.trigger("open:animation:complete")
                }, this)
            }, this.options.openAnimation))
        }
    }, {
        top: 20,
        padding: 15,
        opened: [],
        open: function(a, b, c) {
            return c = c || {}, new joint.ui.FlashMessage(_.extend({
                title: b,
                type: "info",
                content: a
            }, c)).open(c.target)
        },
        close: function() {
            _.invoke(this.opened, "close")
        }
    });
    ! function(a, b, c) {
        "use strict";
        var d = function() {
            c.bindAll(this, "handleKey"), this.parser = new e, this.enable()
        };
        c.extend(d.prototype, b.Events), d.prototype.on = function(a, c, d) {
            return b.Events.on.call(this, this.normalizeEvent(a), c, d), this
        }, d.prototype.off = function(a, c, d) {
            var e = a ? this.normalizeEvent(a) : null;
            return b.Events.off.call(this, e, c, d), this
        }, d.prototype.normalizeEvent = function(a) {
            return "object" == typeof a ? c.transform(a, function(a, b, c) {
                a[this.normalizeShortcut(c)] = b
            }, null, this) : this.normalizeShortcut(a)
        }, d.prototype.normalizeShortcut = function(a) {
            if ("all" === a.toLowerCase()) return a;
            for (var b = this.parser.toEventObjectList(a), c = [], d = 0; d < b.length; d++) c.push(this.hash(b[d]));
            return c.join(" ")
        }, d.prototype.enable = function() {
            window.addEventListener ? (document.addEventListener("keydown", this.handleKey, !1), document.addEventListener("keypress", this.handleKey, !1), document.addEventListener("keyup", this.handleKey, !1)) : window.attachEvent && (document.attachEvent("keydown", this.handleKey, !1), document.attachEvent("keypress", this.handleKey, !1), document.attachEvent("keyup", this.handleKey, !1))
        }, d.prototype.disable = function() {
            window.removeEventListener ? (document.removeEventListener("keydown", this.handleKey, !1), document.removeEventListener("keypress", this.handleKey, !1), document.removeEventListener("keyup", this.handleKey, !1)) : window.detachEvent && (document.detachEvent("keydown", this.handleKey, !1), document.detachEvent("keypress", this.handleKey, !1), document.detachEvent("keyup", this.handleKey, !1))
        }, d.prototype.isActive = function(a, b) {
            return this.isModifierActive(a, b)
        }, d.prototype.isModifierActive = function(a, b) {
            for (var c = this.parser.toEventObjectList(a), d = 0; d < c.length; d++)
                if (c[d].modifiersCompare(b)) return !0;
            return !1
        }, d.prototype.hash = function(a) {
            var b = function(a) {
                    return a ? 1 : 0
                },
                c = [a.type, ":", a.which, b(a.shiftKey), b(a.ctrlKey), b(a.altKey), b(a.metaKey)];
            return c.join("")
        }, d.prototype.handleKey = function(a) {
            if (!this.isUnsupportedElement(a)) {
                var c = l.fromNative(a);
                b.Events.trigger.call(this, this.hash(c), a)
            }
        }, d.prototype.isUnsupportedElement = function(a) {
            var b = a.target || a.srcElement;
            if (b) {
                var c = b.tagName.toUpperCase();
                return "INPUT" === c || "SELECT" === c || "TEXTAREA" === c || b.isContentEditable
            }
            return !1
        };
        var e = function() {};
        e.prototype = {
            constructor: e,
            parseEventString: function(a) {
                a = a || "";
                var b, c, d = a.split("+"),
                    f = new l(0);
                for (c = 0; c < d.length; c++) {
                    b = d[c];
                    var g = this.getModifierPropertyName(b);
                    g && (f[g] = !0), 1 !== d.length && void 0 !== g || (f.which = e.getCode(b))
                }
                return f
            },
            toEventObjectList: function(a) {
                var b = a.replace(/\s*\+\s*/gi, "+").split(" ");
                return c.map(b, this.composeEventObject, this)
            },
            composeEventObject: function(a) {
                var b = a.split(":"),
                    c = j.KEYDOWN,
                    d = b[0];
                if (b.length > 1 && (d = b[1], c = b[0]), k.indexOf(c) === -1) throw a + ": invalid shortcut definition";
                var e = this.parseEventString(d);
                return c === j.KEYUP && g[e.which] && (e[g[e.which]] = !1), e.setType(c)
            },
            getModifierPropertyName: function(a) {
                var b = f[a];
                return g[b]
            }
        }, e.getCode = function(a) {
            return i[a] || a.toUpperCase().charCodeAt(0)
        };
        var f = {
                "â‡§": 16,
                shift: 16,
                "âŒ¥": 18,
                alt: 18,
                option: 18,
                "âŒƒ": 17,
                ctrl: 17,
                control: 17,
                "âŒ˜": 91,
                command: 91,
                meta: 91
            },
            g = {
                16: "shiftKey",
                18: "altKey",
                17: "ctrlKey",
                91: "metaKey"
            },
            h = {
                226: "\\",
                57392: "ctrl",
                63289: "num",
                59: ";",
                61: "=",
                173: "-"
            },
            i = {
                backspace: 8,
                tab: 9,
                shift: 16,
                ctrl: 17,
                alt: 18,
                meta: 91,
                clear: 12,
                enter: 13,
                "return": 13,
                esc: 27,
                escape: 27,
                capslock: 20,
                space: 32,
                left: 37,
                up: 38,
                right: 39,
                down: 40,
                del: 46,
                "delete": 46,
                home: 36,
                end: 35,
                insert: 45,
                ins: 45,
                pageup: 33,
                pagedown: 34,
                plus: 187,
                minus: 189,
                "-": 189,
                ",": 188,
                ".": 190,
                "/": 191,
                "`": 192,
                "=": 187,
                ";": 186,
                "'": 222,
                "[": 219,
                "]": 221,
                "\\": 220
            },
            j = {
                KEYPRESS: "keypress",
                KEYDOWN: "keydown",
                KEYUP: "keyup"
            },
            k = [j.KEYPRESS, j.KEYDOWN, j.KEYUP],
            l = function(a, b, c, d, e, f) {
                this.which = a, this.shiftKey = b || !1, this.ctrlKey = c || !1, this.altKey = d || !1, this.metaKey = e || !1, this.type = f || j.KEYDOWN
            };
        l.fromNative = function(a) {
            var b = a.which;
            a.type === j.KEYPRESS && (b = String.fromCharCode(a.which).toUpperCase().charCodeAt(0)), h[b] && (b = e.getCode(h[b]));
            var c = new l(b, a.shiftKey, a.ctrlKey, a.altKey, a.metaKey, a.type);
            return a.type === j.KEYUP && g[b] && (c[g[b]] = !1), c
        }, l.prototype.modifiersCompare = function(a) {
            return !(this.shiftKey && this.shiftKey !== a.shiftKey || this.ctrlKey && this.ctrlKey !== a.ctrlKey || this.altKey && this.altKey !== a.altKey || this.metaKey && this.metaKey !== a.metaKey)
        }, l.prototype.setType = function(a) {
            return this.type = a, this
        }, a.ui.Keyboard = d
    }(joint, Backbone, _);
    joint.ui.Lightbox = joint.ui.Dialog.extend({
        className: joint.ui.Dialog.prototype.className + " lightbox",
        options: _.merge({}, joint.ui.Dialog.prototype.options, {
            closeButton: !0,
            modal: !0,
            closeAnimation: {
                delay: 2e3,
                duration: 200,
                easing: "swing",
                properties: {
                    opacity: 0
                }
            },
            top: 100,
            windowArea: .8,
            openAnimation: !1
        }),
        init: function() {
            _.bindAll(this, "startCloseAnimation", "positionAndScale"), joint.ui.Dialog.prototype.init.apply(this, arguments), this.options.image && (this.$image = $("<img/>").on("load", this.positionAndScale), this.options.content = this.$image), $(window).on("resize", this.positionAndScale), this.on("close:animation:complete", this.remove, this)
        },
        open: function() {
            return joint.ui.Dialog.prototype.open.apply(this, arguments), this.$image && this.$image.attr("src", this.options.image), this.positionAndScale(), this.startOpenAnimation(), this
        },
        positionAndScale: function() {
            var a = this.$(".fg"),
                b = this.$(".body > img"),
                c = this.options.windowArea,
                d = window.innerWidth * c;
            this.$el.css("margin-top", this.options.top);
            var e = this.$(".titlebar");
            e.css("width", d);
            var f = e.height(),
                g = window.innerHeight * c - f - this.options.top;
            e.css("width", "auto"), a.css({
                width: d,
                height: g
            });
            var h = b.width(),
                i = b.height();
            a.css({
                width: h,
                height: i
            })
        },
        close: function() {
            return this.options.closeAnimation ? this.startCloseAnimation() : joint.ui.Dialog.prototype.close.apply(this, arguments), this
        },
        onRemove: function() {
            joint.ui.Dialog.prototype.onRemove.apply(this, arguments), $(window).off("resize", this.positionAndScale), this.$image && this.$image.off("load", this.positionAndScale)
        },
        startCloseAnimation: function() {
            this.$el.animate(this.options.closeAnimation.properties, _.extend({
                complete: _.bind(function() {
                    this.trigger("close:animation:complete")
                }, this)
            }, this.options.closeAnimation))
        },
        startOpenAnimation: function() {
            this.$el.animate(_.extend({}, this.options.openAnimation.properties, {
                height: this._foregroundHeight
            }), _.extend({
                complete: _.bind(function() {
                    this.trigger("open:animation:complete")
                }, this)
            }, this.options.openAnimation))
        }
    });
    joint.ui.ContextToolbar = joint.mvc.View.extend({
        className: "context-toolbar",
        eventNamespace: "context-toolbar",
        events: {
            "click .tool": "onToolPointerdown"
        },
        options: {
            padding: 20,
            autoClose: !0
        },
        init: function() {
            _.bindAll(this, "onDocumentMousedown")
        },
        render: function() {
            return this.constructor.opened && this.constructor.close(), this.bind(), this.options.type && this.$el.attr("data-type", this.options.type), $(this.getRoot()).append(this.$el), this.renderContent(), this.position(), this.constructor.opened = this, this
        },
        renderContent: function() {
            var a = $("<div/>", {
                "class": "tools"
            });
            this.options.tools && _.each(this.options.tools, function(b) {
                var c;
                c = b.icon ? $("<img/>", {
                    src: b.icon
                }) : b.content;
                var d = $("<button/>", {
                    "class": "tool",
                    html: c,
                    "data-action": b.action
                });
                b.attrs && d.attr(b.attrs), a.append(d)
            }), this.$el.append(a)
        },
        getRoot: function() {
            return this.options.root || document.documentElement
        },
        position: function() {
            var a = joint.util.getElementBBox(this.options.target),
                b = joint.util.getElementBBox(this.getRoot()),
                c = this.$el.outerWidth(),
                d = a.x + a.width / 2 - c / 2,
                e = a.y + a.height + this.options.padding;
            d -= b.x, e -= b.y, this.$el.css({
                left: d,
                top: e
            })
        },
        onRemove: function() {
            this.unbind(), this.constructor.opened = void 0
        },
        bind: function() {
            $(document).on("mousedown." + this.eventNamespace, this.onDocumentMousedown)
        },
        unbind: function() {
            return $(document).off("mousedown." + this.eventNamespace, this.onDocumentMousedown), this
        },
        onToolPointerdown: function(a) {
            var b = $(a.target).closest("[data-action]"),
                c = b.attr("data-action");
            c && this.trigger("action:" + c, a)
        },
        onDocumentMousedown: function(a) {
            if (this.options.autoClose) {
                var b = this.options.target;
                this.el.contains(a.target) || b.contains(a.target) || b === a.target || (this.constructor.close(), this.remove())
            }
        }
    }, {
        opened: void 0,
        close: function() {
            this.opened && (this.opened.remove(), this.opened = void 0)
        },
        update: function() {
            this.opened && this.opened.position()
        }
    });
    joint.ui.Popup = joint.ui.ContextToolbar.extend({
        className: "popup",
        eventNamespace: "popup",
        events: {},
        renderContent: function() {
            var a = _.isFunction(this.options.content) ? this.options.content(this.el) : this.options.content;
            a && this.$el.html(a)
        }
    });
    joint.ui.SelectBox = joint.mvc.View.extend({
        className: "select-box",
        events: {
            "click .select-box-selection": "onToggle"
        },
        options: {
            options: [],
            width: void 0,
            openPolicy: "auto",
            target: null,
            keyboardNavigation: !0,
            selected: void 0,
            selectBoxOptionsClass: void 0,
            disabled: !1
        },
        init: function() {
            this.options.target = this.options.target || document.body, _.bindAll(this, "onOutsideClick", "onOptionSelect"), $(document).on("click.selectBox", this.onOutsideClick), this.$el.data("view", this), _.isUndefined(this.options.selected) ? this.selection = _.findWhere(this.options.options, {
                selected: !0
            }) || this.options.options[0] : this.selection = this.options.options[this.options.selected]
        },
        render: function() {
            return this.$el.empty(), this.$selection = null, this.renderSelection(this.selection), this.options.width && this.$el.css("width", this.options.width), this.options.disabled && this.disable(), this.$el.append(this.$options), this
        },
        renderOptions: function() {
            this.removeOptions();
            var a = {
                selectBoxView: this,
                parentClassName: _.result(this, "className") || null,
                extraClassName: _.result(this.options, "selectBoxOptionsClass") || null,
                options: this.options.options
            };
            this.options.width && (a.width = this.options.width), this.optionsView = new this.constructor.OptionsView(a), this.optionsView.render(), this.listenTo(this.optionsView, "option:select", this.onOptionSelect), this.listenTo(this.optionsView, "option:hover", this.onOptionHover), this.listenTo(this.optionsView, "options:mouseout", this.onOptionsMouseOut), this.$options = this.optionsView.$el, this.$optionsArrow = this.optionsView.$arrow, this.$target = $(this.options.target)
        },
        onOptionHover: function(a, b) {
            this.trigger("option:hover", a, b)
        },
        onOptionsMouseOut: function(a) {
            this.trigger("options:mouseout", a)
        },
        onOptionSelect: function(a, b) {
            this.select(a, b)
        },
        removeOptions: function() {
            this.optionsView && (this.stopListening(this.optionsView), this.optionsView.remove(), this.optionsView = null)
        },
        renderSelection: function(a) {
            if (this.$selection || (this.$selection = $("<div/>", {
                    "class": "select-box-selection"
                }), this.$el.append(this.$selection)), this.$selection.empty(), a) {
                var b = this.constructor.OptionsView.prototype.renderOptionContent.call(void 0, a);
                this.$selection.append(b)
            } else if (this.options.placeholder) {
                var c = $("<div/>", {
                    "class": "select-box-placeholder",
                    html: this.options.placeholder
                });
                this.$selection.append(c)
            }
        },
        onToggle: function(a) {
            this.toggle()
        },
        onOutsideClick: function(a) {
            !this.el.contains(a.target) && this.$el.hasClass("opened") && this.close()
        },
        getSelection: function() {
            return this.selection
        },
        getSelectionValue: function(a) {
            return a = a || this.selection, a && (_.isUndefined(a.value) ? a.content : a.value)
        },
        getSelectionIndex: function() {
            return _.findIndex(this.options.options, this.selection)
        },
        select: function(a, b) {
            this.selection = this.options.options[a], this.renderSelection(this.selection), this.trigger("option:select", this.selection, a, b), this.close()
        },
        selectByValue: function(a, b) {
            for (var c = this.options.options || [], d = 0; d < c.length; d++) {
                var e = c[d];
                if (_.isUndefined(e.value) && e.content === a) return this.select(d, b);
                if (!_.isUndefined(e.value) && _.isEqual(e.value, a)) return this.select(d, b)
            }
        },
        isOpen: function() {
            return this.$el.hasClass("opened")
        },
        toggle: function() {
            this.isOpen() ? this.close() : this.open()
        },
        position: function() {
            var a = this.$(".select-box-selection"),
                b = a.outerHeight(),
                c = a.offset(),
                d = c.left,
                e = c.top,
                f = this.$options.outerHeight(),
                g = {
                    left: 0,
                    top: 0
                };
            this.options.target !== document.body ? (g = this.$target.offset(), g.width = this.$target.outerWidth(), g.height = this.$target.outerHeight(), g.left -= this.$target.scrollLeft(), g.top -= this.$target.scrollTop()) : (g.width = $(window).width(), g.height = $(window).height());
            var h = d,
                i = "auto",
                j = this.options.openPolicy;
            switch ("selected" !== j || this.selection || (j = "auto"), j) {
                case "above":
                    i = e - f;
                    break;
                case "coverAbove":
                    i = e - f + b;
                    break;
                case "below":
                    i = e + b;
                    break;
                case "coverBelow":
                    i = e;
                    break;
                case "selected":
                    var k = this.$options.find(".selected").position();
                    i = e - k.top;
                    break;
                default:
                    var l = e - this.$target.scrollTop() + f > g.top + g.height;
                    i = l ? e - f + b : e
            }
            h -= g.left, i -= g.top, this.$options.css({
                left: h,
                top: i
            })
        },
        open: function() {
            this.isDisabled() || (this.renderOptions(), this.$options.appendTo(this.options.target), this.$options.addClass("rendered"), this.position(), this.$el.addClass("opened"), this.respectWindowBoundaries(), this.alignOptionsArrow())
        },
        respectWindowBoundaries: function() {
            var a = this.calculateElOverflow(this.$options),
                b = {
                    left: 0,
                    top: 0
                };
            this.$options.outerWidth() <= this.$target.innerWidth() && (a.left && a.right || (a.left ? b.left = a.left : a.right && (b.left = -a.right))), this.$options.outerHeight() <= this.$target.innerHeight() && (a.top && a.bottom || (a.top ? b.top = a.top : a.bottom && (b.top = -a.bottom))), this.$options.css({
                left: "+=" + b.left,
                top: "+=" + b.top
            })
        },
        alignOptionsArrow: function() {
            var a = this.$el[0].getBoundingClientRect(),
                b = this.$options[0].getBoundingClientRect(),
                c = a.left + a.width / 2;
            c -= b.left, c -= this.$optionsArrow.outerWidth() / 2, this.$optionsArrow.css({
                left: c
            })
        },
        close: function() {
            this.removeOptions(), this.$el.removeClass("opened"), this.trigger("close")
        },
        onRemove: function() {
            this.removeOptions(), $(document).off(".selectBox", this.onOutsideClick)
        },
        isDisabled: function() {
            return this.$el.hasClass("disabled")
        },
        enable: function() {
            this.$el.removeClass("disabled")
        },
        disable: function() {
            this.close(), this.$el.addClass("disabled")
        },
        onSetTheme: function(a, b) {
            this.$options && (a && this.$options.removeClass(this.themeClassNamePrefix + a), this.$options.addClass(this.themeClassNamePrefix + b))
        },
        calculateElOverflow: function(a, b) {
            b || (b = window), a instanceof jQuery && (a = a[0]), b instanceof jQuery && (b = b[0]);
            var c, d = {},
                e = a.getBoundingClientRect();
            if (b === window) {
                var f = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
                    g = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                c = {
                    width: f,
                    height: g,
                    left: 0,
                    top: 0,
                    right: f,
                    bottom: g
                }
            } else c = b.getBoundingClientRect();
            return _.each(["left", "top"], function(a) {
                d[a] = Math.min(0, e[a] - c[a])
            }), _.each(["right", "bottom"], function(a) {
                d[a] = Math.min(0, c[a] - e[a])
            }), _.each(d, function(a, b) {
                d[b] = Math.abs(Math.round(a))
            }), d
        }
    }, {
        OptionsView: joint.mvc.View.extend({
            events: {
                "mouseover .select-box-option": "onOptionHover",
                "click .select-box-option": "onOptionClick"
            },
            className: function() {
                var a = ["select-box-options"],
                    b = this.options.parentClassName;
                return b && a.push(b), a.join(" ")
            },
            init: function() {
                _.bindAll(this, "onMouseout", "onKeydown"), $(document).on({
                    "keydown.selectBoxOptions": this.onKeydown,
                    "mouseleave.selectBoxOptions mouseout.selectBoxOptions": this.onMouseout
                })
            },
            render: function() {
                var a = this.options.extraClassName;
                return a && this.$el.addClass(a), this.options.width && this.$el.css("width", this.options.width), _.each(this.options.options, function(a, b) {
                    var c = this.renderOption(a, b);
                    this.options.selectBoxView.selection === a && c.addClass("selected hover"), this.$el.append(c)
                }, this), this.$arrow = $("<div/>").addClass("select-box-options-arrow").appendTo(this.$el), this
            },
            renderOption: function(a, b) {
                var c = this.renderOptionContent(a);
                return c.addClass("select-box-option"), c.data("index", b), c
            },
            renderOptionContent: function(a) {
                var b = $("<div/>", {
                    "class": "select-box-option-content",
                    html: a.content
                });
                return a.icon && b.prepend($("<img/>", {
                    "class": "select-box-option-icon",
                    src: a.icon
                })), b
            },
            select: function(a, b) {
                this.trigger("option:select", a, b)
            },
            hover: function(a) {
                var b = this.options.options[a];
                this.markOptionHover(a), this.trigger("option:hover", b, a)
            },
            onOptionClick: function(a) {
                var b = this.getOptionIndex(a.target);
                this.select(b, {
                    ui: !0
                })
            },
            onOptionHover: function(a) {
                var b = this.getOptionIndex(a.target);
                this.hover(b)
            },
            onMouseout: function(a) {
                this.trigger("options:mouseout", a)
            },
            onKeydown: function(a) {
                var b = this.options.selectBoxView;
                if (b.options.keyboardNavigation && b.isOpen()) {
                    var c;
                    switch (a.which) {
                        case 39:
                        case 40:
                            c = 1;
                            break;
                        case 38:
                        case 37:
                            c = -1;
                            break;
                        case 13:
                            var d = this.getOptionHoverIndex();
                            return void(d >= 0 && this.select(d));
                        case 27:
                            return this.close();
                        default:
                            return
                    }
                    a.preventDefault();
                    var e = this.getOptionHoverIndex(),
                        f = e + c,
                        g = this.options.options;
                    f < 0 && (f = g.length - 1), f >= g.length && (f = 0), this.hover(f)
                }
            },
            onRemove: function() {
                $(document).off(".selectBoxOptions")
            },
            markOptionHover: function(a) {
                this.$el.find(".hover").removeClass("hover"), $(this.$el.find(".select-box-option")[a]).addClass("hover")
            },
            getOptionHoverIndex: function() {
                return this.$el.find(".select-box-option.hover").index()
            },
            getOptionIndex: function(a) {
                return $(a).closest(".select-box-option").data("index")
            }
        })
    });
    joint.ui.ColorPalette = joint.ui.SelectBox.extend({
        className: "select-box color-palette",
        position: function() {
            var a = this.$(".select-box-selection"),
                b = a.outerHeight(),
                c = a.offset(),
                d = c.left,
                e = c.top + b;
            if (this.options.target !== document.body) {
                this.$target = this.$target || $(this.options.target);
                var f = this.$target.offset();
                d -= f.left - this.$target.scrollLeft(), e -= f.top - this.$target.scrollTop()
            }
            this.$options.css({
                left: d,
                top: e
            })
        }
    }, {
        OptionsView: joint.ui.SelectBox.OptionsView.extend({
            renderOptionContent: function(a) {
                var b = $("<div/>", {
                    "class": "select-box-option-content"
                });
                return b.css("background-color", a.content), a.icon && b.prepend($("<img/>", {
                    "class": "select-box-option-icon",
                    src: a.icon
                })), b
            }
        })
    });
    joint.ui.SelectButtonGroup = joint.mvc.View.extend({
        className: "select-button-group",
        events: {
            "click .select-button-group-button": "onSelect",
            "mouseover .select-button-group-button": "onOptionHover",
            mouseleave: "onMouseOut",
            "mousedown .select-button-group-button": "pointerdown",
            "touchstart .select-button-group-button": "pointerdown",
            "mouseup .select-button-group-button": "pointerup",
            "touchend .select-button-group-button": "pointerup"
        },
        options: {
            buttonWidth: void 0,
            buttonHeight: void 0,
            options: [],
            disabled: !1,
            multi: !1,
            selected: void 0
        },
        init: function() {
            _.bindAll(this, "onSelect", "pointerup"), this.$el.data("view", this);
            var a = this.options.multi;
            _.isUndefined(this.options.selected) ? this.selection = a ? _.filter(this.options.options, {
                selected: !0
            }) : _.findWhere(this.options.options, {
                selected: !0
            }) : a ? this.selection = _.isArray(this.options.selected) ? _.filter(this.options.options, function(a, b) {
                return _.contains(this.options.selected, b)
            }, this) : [this.options.options[this.options.selected]] : this.selection = this.options.options[this.options.selected]
        },
        render: function() {
            return this.renderOptions(this.selection), this.options.width && this.$el.css("width", this.options.width), this.options.disabled && this.disable(), this.$el.append(this.$options), this
        },
        renderOptions: function() {
            this.removeOptions();
            var a = this.options.multi;
            _.each(this.options.options, function(b, c) {
                var d = a ? _.contains(this.selection, b) : this.selection === b,
                    e = this.renderOption(b, c, d);
                this.$el.append(e), d && e.addClass("selected")
            }, this)
        },
        removeOptions: function() {
            this.$el.empty()
        },
        renderOption: function(a, b, c) {
            var d = this.renderOptionContent(a, c);
            d.data("index", b);
            var e = a.buttonWidth || this.options.buttonWidth;
            e && d.css("width", e);
            var f = a.buttonHeight || this.options.buttonHeight;
            return f && d.css("height", f), d
        },
        renderOptionContent: function(a, b) {
            var c = $("<div/>", {
                "class": "select-button-group-button",
                html: a.content
            });
            if (a.icon || b && a.iconSelected) {
                var d = $("<img/>", {
                        "class": "select-button-group-button-icon",
                        src: b && a.iconSelected ? a.iconSelected : a.icon
                    }),
                    e = a.iconWidth || this.options.iconWidth;
                e && d.css("width", e);
                var f = a.iconHeight || this.options.iconHeight;
                f && d.css("height", f), c.prepend(d)
            }
            return joint.util.setAttributesBySelector(c, a.attrs), c
        },
        getOptionIndex: function(a) {
            return $(a).closest(".select-button-group-button").data("index")
        },
        onSelect: function(a) {
            if (!this.isDisabled()) {
                var b = this.getOptionIndex(a.target);
                this.select(b, {
                    ui: !0
                })
            }
        },
        onOptionHover: function(a) {
            if (!this.isDisabled()) {
                var b = this.getOptionIndex(a.target);
                this.trigger("option:hover", this.options.options[b], b)
            }
        },
        onMouseOut: function(a) {
            this.isDisabled() || this.trigger("mouseout", a)
        },
        getSelection: function() {
            return this.selection
        },
        getSelectionValue: function(a) {
            if (a = a || this.selection) return this.options.multi ? _.map(a, function(a) {
                return _.isUndefined(a.value) ? a.content : a.value
            }) : _.isUndefined(a.value) ? a.content : a.value
        },
        select: function(a, b) {
            var c = this.options.options[a],
                d = $(this.$(".select-button-group-button")[a]),
                e = this.options.multi;
            if (e) {
                d.toggleClass("selected");
                var f = d.hasClass("selected");
                f ? this.selection.indexOf(c) === -1 && this.selection.push(c) : this.selection = _.without(this.selection, c), c.iconSelected && d.find(".select-button-group-button-icon").attr("src", f ? c.iconSelected : c.icon)
            } else {
                this.selection = c;
                var g = this.$(".selected"),
                    h = this.options.options[g.index()];
                g.removeClass("selected"), d.addClass("selected"), h && h.iconSelected && g.find(".select-button-group-button-icon").attr("src", h.icon), this.selection.iconSelected && d.find(".select-button-group-button-icon").attr("src", this.selection.iconSelected)
            }
            this.trigger("option:select", this.selection, a, b)
        },
        selectByValue: function(a, b) {
            _.isArray(a) || (a = [a]);
            for (var c = this.options.options || [], d = 0; d < c.length; d++) {
                var e = c[d];
                if (_.isUndefined(e.value) && _.contains(a, e.content)) this.select(d, b);
                else if (!_.isUndefined(e.value)) {
                    var f = _.find(a, function(a) {
                        return _.isEqual(a, e.value)
                    });
                    f && this.select(d, b)
                }
            }
        },
        deselect: function() {
            this.$(".selected").removeClass("selected"), this.options.multi ? this.selection = [] : this.selection = void 0
        },
        isDisabled: function() {
            return this.$el.hasClass("disabled")
        },
        enable: function() {
            this.$el.removeClass("disabled")
        },
        disable: function() {
            this.$el.addClass("disabled")
        },
        pointerdown: function(a) {
            var b = this.getOptionIndex(a.target),
                c = $(this.$(".select-button-group-button")[b]);
            c.addClass("is-in-action"), $(document).on("mouseup.select-button-group touchend.select-button-group", this.pointerup)
        },
        pointerup: function() {
            this.$(".is-in-action").removeClass("is-in-action"), $(document).off("mouseup.select-button-group touchend.select-button-group")
        }
    });
    joint.ui.Navigator = joint.mvc.View.extend({
        className: "navigator",
        events: {
            mousedown: "startAction",
            touchstart: "startAction"
        },
        options: {
            paperConstructor: joint.dia.Paper,
            paperOptions: {},
            zoomOptions: null,
            zoom: {
                min: .5,
                max: 2
            },
            width: 300,
            height: 200,
            padding: 10
        },
        init: function() {
            this.options.zoomOptions ? this.options.zoom = _.extend({}, this.options.zoom, this.options.zoomOptions) : this.options.zoom && (this.options.zoom = _.defaults({}, this.options.zoom, this.constructor.prototype.options.zoom)), _.bindAll(this, "updateCurrentView", "doAction", "stopAction", "scrollTo"), this.updateCurrentView = _.debounce(this.updateCurrentView, 0);
            var a = this.options.paperScroller;
            a.$el.on("scroll.navigator", this.updateCurrentView);
            var b = this.sourcePaper = a.options.paper;
            this.listenTo(b, "resize", this.updatePaper);
            var c = this.targetPaper = new this.options.paperConstructor(_.merge({
                model: b.model,
                interactive: !1
            }, this.options.paperOptions));
            c.$el.on({
                "mousedown.navigator": this.scrollTo,
                "touchstart.navigator": this.scrollTo
            }), $(document.body).on({
                "mousemove.navigator touchmove.navigator": this.doAction,
                "mouseup.navigator touchend.navigator": this.stopAction
            })
        },
        render: function() {
            this.targetPaper.$el.appendTo(this.el);
            var a = this.sourcePaper.model,
                b = a.getElements().concat(a.getLinks());
            if (_.each(b, _.bind(this.targetPaper.renderView, this.targetPaper)), this.$currentView = $("<div>").addClass("current-view"), this.options.zoom) {
                var c = $("<div>").addClass("current-view-control");
                this.$currentView.append(c)
            }
            return this.$el.append(this.$currentView).css({
                width: this.options.width,
                height: this.options.height,
                padding: this.options.padding
            }), this.updatePaper(this.sourcePaper.options.width, this.sourcePaper.options.height), this
        },
        updatePaper: function(a, b) {
            var c = this.sourcePaper.options.origin,
                d = V(this.sourcePaper.viewport).scale(),
                e = this.options.width - 2 * this.options.padding,
                f = this.options.height - 2 * this.options.padding;
            a /= d.sx, b /= d.sy;
            var g = this.ratio = Math.min(e / a, f / b),
                h = c.x * g / d.sx,
                i = c.y * g / d.sy;
            a *= g, b *= g, this.targetPaper.setDimensions(a, b), this.targetPaper.setOrigin(h, i), this.targetPaper.scale(g, g), this.updateCurrentView()
        },
        updateCurrentView: function() {
            var a = this.ratio,
                b = V(this.sourcePaper.viewport).scale(),
                c = this.options.paperScroller,
                d = c.toLocalPoint(0, 0),
                e = this.targetPaper.$el.position(),
                f = V(this.targetPaper.viewport).translate();
            f.ty = f.ty || 0, this.currentViewGeometry = {
                top: e.top + d.y * a + f.ty,
                left: e.left + d.x * a + f.tx,
                width: c.$el.innerWidth() * a / b.sx,
                height: c.$el.innerHeight() * a / b.sy
            }, this.$currentView.css(this.currentViewGeometry)
        },
        startAction: function(a) {
            a = joint.util.normalizeEvent(a), this._action = $(a.target).hasClass("current-view-control") ? "zooming" : "panning", this._clientX = a.clientX, this._clientY = a.clientY
        },
        doAction: function(a) {
            if (this._action) {
                a = joint.util.normalizeEvent(a);
                var b = V(this.sourcePaper.viewport).scale(),
                    c = (a.clientX - this._clientX) * b.sx,
                    d = (a.clientY - this._clientY) * b.sy;
                switch (this._action) {
                    case "panning":
                        this.options.paperScroller.el.scrollLeft += c / this.ratio, this.options.paperScroller.el.scrollTop += d / this.ratio;
                        break;
                    case "zooming":
                        var e = -c / this.currentViewGeometry.width;
                        this.options.paperScroller.zoom(e, this.options.zoom)
                }
                this._clientX = a.clientX, this._clientY = a.clientY
            }
        },
        stopAction: function() {
            this._action = null
        },
        scrollTo: function(a) {
            a = joint.util.normalizeEvent(a);
            var b = V(this.targetPaper.viewport).translate();
            b.ty = b.ty || 0;
            var c, d;
            if (_.isUndefined(a.offsetX)) {
                var e = this.targetPaper.$el.offset();
                c = a.pageX - e.left, d = a.pageY - e.top
            } else c = a.offsetX, d = a.offsetY;
            var f = (c - b.tx) / this.ratio,
                g = (d - b.ty) / this.ratio;
            this.options.paperScroller.center(f, g)
        },
        onRemove: function() {
            this.targetPaper.$el.off(".navigator"), this.targetPaper.remove(), this.options.paperScroller.$el.off(".navigator"), $(document.body).off(".navigator")
        }
    });
    joint.ui.TreeLayoutView = joint.mvc.View.extend({
        MINIMAL_PREVIEW_SIZE: 10,
        className: "tree-layout",
        options: {
            previewAttrs: {
                parent: {
                    rx: 2,
                    ry: 2
                }
            },
            useModelGeometry: !1,
            clone: function(a) {
                return a.clone()
            },
            canInteract: _.constant(!0)
        },
        init: function() {
            _.bindAll(this, "onPointermove", "onPointerup"), this.toggleDefaultInteraction(!1), this.startListening(), this.render(), this.onSetTheme(null, this.theme)
        },
        startListening: function() {
            var a = this.options.paper;
            this.listenTo(a, "element:pointerdown", this.canInteract(this.onPointerdown))
        },
        toggleDefaultInteraction: function(a) {
            this.options.paper.setInteractivity(a)
        },
        render: function() {
            var a = this.options.paper;
            return this.$activeBox = $("<div>").addClass("tree-layout-box active hidden").appendTo(this.el), this.draggingPaper = new joint.dia.Paper({
                model: new joint.dia.Graph,
                interactive: !1,
                width: "100%",
                height: "100%"
            }), this.$translateBox = $("<div>").addClass("tree-layout-box translate hidden").append(this.draggingPaper.render().el).appendTo(this.el), this.$mask = $("<div>").addClass("tree-layout-mask"), this.svgViewport = V(a.viewport), this.svgPreviewChild = V("circle").attr(this.options.previewAttrs.child || {}).addClass("tree-layout-preview child"), this.svgPreviewConnection = V("path").attr(this.options.previewAttrs.link || {}).addClass("tree-layout-preview link"), this.svgPreviewParent = V("rect").attr(this.options.previewAttrs.parent || {}).addClass("tree-layout-preview parent"), this.svgPreview = V("g").addClass("tree-layout-preview-group").append([this.svgPreviewConnection, this.svgPreviewParent, this.svgPreviewChild]), this.$el.appendTo(a.el), this
        },
        onSetTheme: function(a, b) {
            var c = [this.svgPreview, this.$mask];
            _.each(c, function(c) {
                c && (a && c.removeClass(this.themeClassNamePrefix + a), c.addClass(this.themeClassNamePrefix + b))
            }, this)
        },
        onRemove: function() {
            this.svgPreview.remove()
        },
        toggleDropping: function(a) {
            this.$mask.toggleClass("dropping-not-allowed", !a), this.$translateBox.toggleClass("no-drop", !a)
        },
        canDrop: function() {
            return this.isActive() && !this.$translateBox.hasClass("no-drop")
        },
        isActive: function() {
            return !this.$translateBox.hasClass("hidden")
        },
        _startDrag: function(a, b, c) {
            var d = this.options.paper;
            this.$mask.appendTo(d.el), this.toggleDropping(!1), this.ctm = d.viewport.getCTM();
            var e = _.first(a),
                f = e.findView(d),
                g = f.getBBox({
                    useModelGeometry: this.options.useModelGeometry
                });
            this.updateBox(this.$translateBox, _.defaults({
                x: b,
                y: c
            }, g)), this.updateBox(this.$activeBox, g), this.$activeBox.removeClass("hidden"), this.$translateBox.removeClass("hidden"), this.prepareDraggingPaper(e)
        },
        updateBox: function(a, b) {
            a.css({
                width: b.width,
                height: b.height,
                left: b.x,
                top: b.y
            })
        },
        positionTranslateBox: function(a) {
            var b = V.transformPoint(a, this.ctm);
            this.$translateBox.css({
                left: b.x,
                top: b.y
            })
        },
        prepareDraggingPaper: function(a) {
            var b = this.options.clone(a).position(0, 0);
            this.draggingPaper.scale(this.ctm.a, this.ctm.d), this.draggingPaper.model.resetCells([b])
        },
        _doDrag: function(a, b, c) {
            var d, e, f = this.model,
                g = {
                    x: b,
                    y: c
                };
            if (this.candidate && (this.candidate = null, this.hidePreview()), this.positionTranslateBox(g), d = f.getMinimalRootAreaByPoint(g), d && (e = d.findMinimalAreaByPoint(g, {
                    expandBy: Math.min(f.get("siblingGap"), f.get("gap")) / 2
                })), e) {
                var h = this.findDirection(e, g),
                    i = e.getLayoutSiblings(h),
                    j = i.getSiblingRankByPoint(g),
                    k = _.every(a, _.partial(this.isConnectionValid, _, i, j), this);
                k ? (this.candidate = {
                    id: e.root.id,
                    direction: h,
                    siblingRank: j + .5
                }, this.updatePreview(i, j), this.showPreview(), this.toggleDropping(!0)) : this.toggleDropping(!1)
            } else this.toggleDropping(!0)
        },
        _finishDrag: function(a, b, c) {
            this.$mask.remove().removeClass("dropping-not-allowed"), this.candidate ? (_.each(a, _.partial(this.reconnectElement, _, this.candidate), this), this.candidate = null, this.model.layout({
                ui: !0
            })) : this.canDrop() && (_.each(a, _.partial(this.translateElement, _, b, c), this), this.model.layout({
                ui: !0
            })), this.$activeBox.addClass("hidden"), this.$translateBox.addClass("hidden"), this.hidePreview()
        },
        reconnectElement: function(a, b) {
            var c = {
                    direction: b.direction,
                    siblingRank: b.siblingRank,
                    ui: !0
                },
                d = this.model.reconnectElement(a, b.id, c);
            if (!d) {
                var e = this.options.paper,
                    f = e.getDefaultLink(a.findView(e));
                f.set({
                    source: {
                        id: b.id
                    },
                    target: {
                        id: a.id
                    }
                }), f.addTo(e.model, c), this.model.changeSiblingRank(a, b.siblingRank, c), this.model.changeDirection(a, b.direction, c);
                var g = this.model.getAttribute(a, "direction");
                this.model.updateDirections(a, [g, b.direction], c)
            }
        },
        translateElement: function(a, b, c) {
            var d = this.model.graph.getConnectedLinks(a, {
                inbound: !0
            });
            _.invoke(d, "remove");
            var e = a.get("size");
            a.set("position", {
                x: b - e.width / 2,
                y: c - e.height / 2
            }, {
                ui: !0
            })
        },
        updatePreview: function(a, b) {
            var c = a.parentArea.root,
                d = Math.max(this.model.get("siblingGap") / 2, this.MINIMAL_PREVIEW_SIZE),
                e = {
                    width: d,
                    height: d
                },
                f = a.getNeighborPointFromRank(b),
                g = a.getConnectionPoints(f, {
                    ignoreSiblings: !0
                }),
                h = a.getParentConnectionPoint(),
                i = a.getChildConnectionPoint(f, e);
            this.updateParentPreview(c.get("position"), c.get("size")), this.updateChildPreview(f, e), this.updateConnectionPreview(h, i, g)
        },
        showPreview: function() {
            this.svgViewport.append(this.svgPreview)
        },
        hidePreview: function() {
            this.svgPreview.remove()
        },
        updateParentPreview: function(a, b) {
            this.svgPreviewParent.attr({
                x: a.x,
                y: a.y,
                width: b.width,
                height: b.height
            })
        },
        updateChildPreview: function(a, b) {
            this.svgPreviewChild.attr({
                cx: a.x,
                cy: a.y,
                r: b.width / 2
            })
        },
        updateConnectionPreview: function(a, b, c) {
            this.svgPreviewConnection.attr({
                d: joint.connectors.rounded(a, b, c, {})
            })
        },
        findDirection: function(a, b) {
            var c, d = a.root.get("layout") || a.getType();
            switch (d) {
                case "BL-BR":
                case "TL-TR":
                case "L-R":
                    return c = d.split("-"), b.x > a.rootCX ? c[1] : c[0];
                case "BL-TL":
                case "BR-TR":
                case "B-T":
                    return c = d.split("-"), b.y > a.rootCY ? c[0] : c[1];
                case "L":
                case "R":
                case "T":
                case "B":
                case "TR":
                case "TL":
                case "BR":
                case "BL":
                    return d;
                default:
                    return a.direction
            }
        },
        isConnectionValid: function(a, b, c) {
            if (a.id == b.parentArea.root.id) return !1;
            if (this.model.graph.isSuccessor(a, b.parentArea.root)) return !1;
            var d = this.model.getLayoutArea(a);
            if (d.parentArea && d.parentArea == b.parentArea && d.direction == b.direction) {
                var e = d.siblingRank - c;
                if (0 === e || 1 === e) return !1
            }
            return !0
        },
        canInteract: function(a) {
            return _.bind(function(b) {
                this.options.canInteract(b) && a.apply(this, arguments)
            }, this)
        },
        getEventNamespace: function() {
            return ".tree-layout-" + this.cid
        },
        startDragging: function(a) {
            var b = _.isArray(a) ? a : [a];
            _.isEmpty(b) || (this._registerPointerEvents(), this._moveCounter = 0, this._draggedElements = b)
        },
        onPointerdown: function(a) {
            this.startDragging(a.model)
        },
        onPointermove: function(a) {
            var b = this.options.paper,
                c = b.clientToLocalPoint({
                    x: a.clientX,
                    y: a.clientY
                });
            this._moveCounter === b.options.clickThreshold ? this._startDrag(this._draggedElements, c.x, c.y) : this._moveCounter > b.options.clickThreshold && this._doDrag(this._draggedElements, c.x, c.y), this._moveCounter++
        },
        onPointerup: function(a) {
            var b = this.options.paper;
            if (this._moveCounter >= b.options.clickThreshold) {
                var c = b.clientToLocalPoint({
                    x: a.clientX,
                    y: a.clientY
                });
                this._finishDrag(this._draggedElements, c.x, c.y)
            }
            this._draggedElements = null, this._unregisterPointerEvents()
        },
        _registerPointerEvents: function() {
            var a = this.getEventNamespace();
            $(document).on("mousemove" + a + " touchmove" + a, this.onPointermove).on("mouseup" + a + " touchend" + a, this.onPointerup)
        },
        _unregisterPointerEvents: function() {
            $(document).off(this.getEventNamespace())
        }
    });
    joint.layout.ForceDirected = Backbone.Model.extend({
        defaults: {
            linkDistance: 10,
            linkStrength: 1,
            charge: 10
        },
        initialize: function(a) {
            this.elements = this.get("graph").getElements(), this.links = this.get("graph").getLinks(), this.cells = this.get("graph").get("cells"), this.width = this.get("width"), this.height = this.get("height"), this.gravityCenter = this.get("gravityCenter"), this.t = 1, this.energy = 1 / 0, this.progress = 0
        },
        start: function() {
            var a = this.get("width"),
                b = this.get("height");
            _.each(this.elements, function(c) {
                c.set("position", {
                    x: Math.random() * a,
                    y: Math.random() * b
                }), c.charge = c.get("charge") || this.get("charge"), c.weight = c.get("weight") || 1;
                var d = c.get("position");
                c.x = d.x, c.y = d.y, c.px = c.x, c.py = c.y, c.fx = 0, c.fy = 0
            }, this), _.each(this.links, function(a) {
                a.strength = a.get("strength") || this.get("linkStrength"), a.distance = a.get("distance") || this.get("linkDistance"), a.source = this.cells.get(a.get("source").id), a.target = this.cells.get(a.get("target").id)
            }, this)
        },
        step: function() {
            if (.99 * this.t < .005) return this.notifyEnd();
            var a = this.width,
                b = this.height,
                c = .1,
                d = this.gravityCenter,
                e = this.energy;
            this.energy = 0;
            var f, g, h, i, j, k, l, m, n, o, p, q = 0,
                r = 0,
                s = 0,
                t = 0,
                u = this.elements.length,
                v = this.links.length;
            for (f = 0; f < u - 1; f++)
                for (h = this.elements[f], q += h.x, r += h.y, g = f + 1; g < u; g++) i = this.elements[g], j = i.x - h.x, k = i.y - h.y, l = j * j + k * k, m = Math.sqrt(l), n = this.t * h.charge / l, o = n * j, p = n * k, h.fx -= o, h.fy -= p, i.fx += o, i.fy += p, this.energy += o * o + p * p;
            q += this.elements[u - 1].x, r += this.elements[u - 1].y;
            var w, x, y;
            for (f = 0; f < v; f++) w = this.links[f], h = w.source, i = w.target, j = i.x - h.x, k = i.y - h.y, l = j * j + k * k, m = Math.sqrt(l), x = this.t * w.strength * (m - w.distance) / m, o = x * j, p = x * k, y = h.weight / (h.weight + i.weight), h.x += o * (1 - y), h.y += p * (1 - y), i.x -= o * y, i.y -= p * y, this.energy += o * o + p * p;
            var z, A;
            for (f = 0; f < u; f++) {
                z = this.elements[f], A = {
                    x: z.x,
                    y: z.y
                }, d && (A.x += (d.x - A.x) * this.t * c, A.y += (d.y - A.y) * this.t * c), A.x += z.fx, A.y += z.fy, A.x = Math.max(0, Math.min(a, A.x)), A.y = Math.max(0, Math.min(b, A.y));
                var B = .9;
                A.x += (z.px - A.x) * B, A.y += (z.py - A.y) * B, z.px = A.x, z.py = A.y, z.fx = z.fy = 0, z.x = A.x, z.y = A.y, s += z.x, t += z.y, this.notify(z, f, A)
            }
            this.t = this.cool(this.t, this.energy, e);
            var C = q - s,
                D = r - t,
                E = Math.sqrt(C * C + D * D);
            E < 1 && this.notifyEnd()
        },
        cool: function(a, b, c) {
            return b < c ? (this.progress += 1, this.progress >= 5 ? (this.progress = 0, a / .99) : a) : (this.progress = 0, .99 * a)
        },
        notify: function(a, b, c) {
            a.set("position", c)
        },
        notifyEnd: function() {
            this.trigger("end")
        }
    });
    joint.layout = joint.layout || {}, joint.layout.GridLayout = {
        layout: function(a, b) {
            var c;
            c = a instanceof joint.dia.Graph ? a : (new joint.dia.Graph).resetCells(a, {
                dry: !0
            }), a = null, b = b || {};
            var d = c.getElements(),
                e = b.columns || 1,
                f = b.dx || 0,
                g = b.dy || 0,
                h = b.columnWidth || this._maxDim(d, "width") + f,
                i = b.rowHeight || this._maxDim(d, "height") + g,
                j = _.isUndefined(b.centre) || b.centre !== !1,
                k = !!b.resizeToFit,
                l = b.marginX || 0,
                m = b.marginY || 0;
            c.startBatch("layout"), _.each(d, function(a, b) {
                var c = 0,
                    d = 0,
                    n = a.get("size");
                if (k) {
                    var o = h - 2 * f,
                        p = i - 2 * g,
                        q = n.height * (n.width ? o / n.width : 1),
                        r = n.width * (n.height ? p / n.height : 1);
                    q > i ? o = r : p = q, n = {
                        width: o,
                        height: p
                    }, a.set("size", n)
                }
                j && (c = (h - n.width) / 2, d = (i - n.height) / 2), c += l, d += m, a.set("position", {
                    x: b % e * h + f + c,
                    y: Math.floor(b / e) * i + g + d
                })
            }), c.stopBatch("layout")
        },
        _maxDim: function(a, b) {
            return _.reduce(a, function(a, c) {
                return Math.max(c.get("size")[b], a)
            }, 0)
        }
    };
    ! function(a, b, c, d) {
        function e(a, b, d) {
            d = c.defaults(d || {}, {
                siblingGap: 0
            }), this.width = 0, this.height = 0, this.layoutAreas = this.sortLayoutAreas(a), this.parentArea = b, this.siblingGap = d.siblingGap, this.exists() && this.computeSize(d)
        }

        function f(a, b, d) {
            var e = c.extend({}, d, this.getRootAttributes(a, d.attributeNames)),
                f = d.gap || 0;
            c.defaults(e, {
                parentGap: f,
                siblingGap: f,
                firstChildGap: f
            }), this.root = a, this.childAreas = b, this.siblingRank = e.siblingRank, this.rootOffset = e.rootOffset, this.nextSiblingGap = e.nextSiblingGap, this.prevSiblingGap = e.prevSiblingGap, this.gap = this.parentGap = e.parentGap, this.firstChildGap = e.firstChildGap, this.dx = 0, this.dy = 0, this.width = 0, this.height = 0, c.invoke(b, "addParentReference", this), this.computeRelativePosition(a, b, e)
        }
        c.extend(e.prototype, {
            sortLayoutAreas: function(a) {
                var b = c.sortBy(a, "siblingRank");
                return c.each(b, function(a, b) {
                    a.siblingRank = b
                }), b
            },
            move: function(a, b) {
                c.each(this.layoutAreas, function(c) {
                    c.dx += a, c.dy += b
                })
            },
            exists: function() {
                return this.layoutAreas.length > 0
            },
            sumGaps: function(a) {
                var b = Math.max(this.layoutAreas.length - 1, 0);
                return b * a
            },
            getSiblingRankByPoint: function(a) {
                if (!this.exists()) return -1;
                var b = this.findAreaByPoint(a);
                return b ? b.siblingRank - 1 : this.layoutAreas.length - 1
            },
            getFirstChildConnectionPoints: function() {
                return []
            },
            getConnectionPoints: function(a, b) {
                if (!this.exists()) return this.getFirstChildConnectionPoints(a);
                var c = {
                    dx: a.x - this.parentArea.rootCX,
                    dy: a.y - this.parentArea.rootCY
                };
                return this.layoutAreas[0].getRootVertices(c, b)
            },
            getParentConnectionPoint: function() {
                var a = this.parentArea,
                    b = this.proxyLayoutArea("getConnectionPoint", a.rootSize),
                    c = d.point(a.rootCX, a.rootCY);
                return c.offset(b.x, b.y)
            },
            getChildConnectionPoint: function(a, b) {
                var c = this.proxyLayoutArea("getConnectionPoint", b);
                return d.point(a).difference(c)
            },
            proxyLayoutArea: function(a) {
                var b = Array.prototype.slice.call(arguments, 1);
                return f.fromDirection(this.direction).prototype[a].apply(this.parentArea, b)
            }
        }), e.extend = b.Model.extend;
        var g = e.extend({
                getTopDY: function() {
                    return -this.height / 2
                },
                findAreaByPoint: function(a) {
                    return c.find(this.layoutAreas, function(b) {
                        return b.rootCY > a.y
                    })
                },
                computeSize: function(a) {
                    this.height = this.sumGaps(a.siblingGap), this.height += c.sum(this.layoutAreas, function(a) {
                        return a.height + a.prevSiblingGap + a.nextSiblingGap
                    }), c.reduce(this.layoutAreas, function(b, c) {
                        return this.width = Math.max(this.width, c.getExtendedWidth()), c.dy += b + c.getCY(), b + c.prevSiblingGap + c.height + c.nextSiblingGap + a.siblingGap
                    }, this.getTopDY(), this)
                },
                getYTowardsParent: function() {
                    return this.parentArea.rootCY
                },
                getXTowardsParent: function() {
                    var a = this.parentArea;
                    return a.rootCX + this.LRSign * (a.rootSize.width / 2 + a.gap)
                },
                getNeighborPointFromRank: function(a) {
                    var b, c = this.siblingGap;
                    if (this.exists()) {
                        var d = this.layoutAreas[a],
                            e = this.layoutAreas[a + 1];
                        b = d ? e ? (d.y + d.height + e.y) / 2 : d.y + d.height + c / 2 : e.y - c / 2
                    } else b = this.getYTowardsParent();
                    return {
                        x: this.getXTowardsParent(),
                        y: b
                    }
                }
            }),
            h = g.extend({
                direction: "L",
                LRSign: -1
            }),
            i = g.extend({
                direction: "R",
                LRSign: 1
            }),
            j = {
                getXTowardsParent: function() {
                    var a = this.parentArea;
                    return a.rootCX + this.LRSign * a.gap
                },
                getYTowardsParent: function() {
                    var a = this.parentArea,
                        b = a.getLRHeight(a.siblings) / 2;
                    return b += Math.min(a.firstChildGap, this.siblingGap / 2), a.rootCY + this.TBSign * b
                },
                getFirstChildConnectionPoints: function(a) {
                    return [d.point(this.parentArea.rootCX, a.y)]
                },
                getChildConnectionPoint: function(a, b) {
                    return d.point(a).offset(-this.LRSign * b.width / 2, 0)
                },
                getParentConnectionPoint: function() {
                    var a = this.parentArea,
                        b = d.point(a.rootCX, a.rootCY);
                    return b.offset(0, this.TBSign * a.rootSize.height / 2)
                }
            },
            k = {
                getTopDY: function() {
                    return 0
                }
            },
            l = {
                getTopDY: function() {
                    return -this.height
                }
            },
            m = g.extend({
                direction: "BR",
                LRSign: 1,
                TBSign: 1
            });
        c.extend(m.prototype, j, k);
        var n = g.extend({
            direction: "BL",
            LRSign: -1,
            TBSign: 1
        });
        c.extend(n.prototype, j, k);
        var o = g.extend({
            direction: "TR",
            LRSign: 1,
            TBSign: -1
        });
        c.extend(o.prototype, j, l);
        var p = g.extend({
            direction: "TL",
            LRSign: -1,
            TBSign: -1
        });
        c.extend(p.prototype, j, l);
        var q = e.extend({
                getLeftDX: function() {
                    return -this.width / 2
                },
                findAreaByPoint: function(a) {
                    return c.find(this.layoutAreas, function(b) {
                        return b.rootCX > a.x
                    })
                },
                computeSize: function(a) {
                    this.width = this.sumGaps(a.siblingGap), this.width += c.sum(this.layoutAreas, function(a) {
                        return a.width + a.prevSiblingGap + a.nextSiblingGap
                    }), c.reduce(this.layoutAreas, function(b, c) {
                        return this.height = Math.max(this.height, c.getExtendedHeight()), c.dx += b + c.getCX(), b + c.prevSiblingGap + c.width + c.nextSiblingGap + a.siblingGap
                    }, this.getLeftDX(), this)
                },
                getNeighborPointFromRank: function(a) {
                    var b;
                    if (this.exists()) {
                        var c = this.layoutAreas[a],
                            d = this.layoutAreas[a + 1];
                        b = c ? d ? (c.x + c.width + d.x) / 2 : c.x + c.width + this.siblingGap / 2 : d.x - this.siblingGap / 2
                    } else b = this.parentArea.rootCX;
                    return {
                        x: b,
                        y: this.getYTowardsParent()
                    }
                }
            }),
            r = q.extend({
                direction: "T",
                getYTowardsParent: function() {
                    var a = this.parentArea;
                    return a.rootCY - a.getLRHeight() / 2 - a.gap
                }
            }),
            s = q.extend({
                direction: "B",
                getYTowardsParent: function() {
                    var a = this.parentArea;
                    return a.rootCY + a.getLRHeight() / 2 + a.gap
                }
            });
        c.extend(f, {
            create: function(a, b, c, d) {
                var e = f.fromDirection(a, d);
                return new e(b, c, d)
            },
            fromDirection: function(a, b) {
                var c;
                switch (a) {
                    case "L":
                        c = u;
                        break;
                    case "T":
                        c = v;
                        break;
                    case "R":
                        c = t;
                        break;
                    case "B":
                        c = w;
                        break;
                    case "BR":
                        c = x;
                        break;
                    case "BL":
                        c = y;
                        break;
                    case "TR":
                        c = z;
                        break;
                    case "TL":
                        c = A;
                        break;
                    default:
                        c = f
                }
                return c
            }
        }), c.extend(f.prototype, {
            direction: null,
            getHeight: function(a, b) {
                return this.getTHeight(a) + this.getBHeight(a) + this.getLRHeight()
            },
            getWidth: function(a, b) {
                var c = Math.max(a.T.width, a.B.width) / 2,
                    d = Math.max(this.getLWidth(a, b) + b.width / 2, c),
                    e = Math.max(this.getRWidth(a, b) + b.width / 2, c);
                return d + e
            },
            getLRHeight: function() {
                return Math.max(this.rootSize.height, this.siblings.L.height, this.siblings.R.height)
            },
            getTHeight: function(a) {
                return a.T.height + this.getTXHeight(a)
            },
            getBHeight: function(a) {
                return a.B.height + this.getBXHeight(a)
            },
            getXLRWidth: function(a, b) {
                return this.getLWidth(a, b) + b.width + this.getRWidth(a, b)
            },
            getXRWidth: function(a, b) {
                var c = Math.max(a.BR.width, a.TR.width);
                return c > 0 && (c -= b.width / 2), c
            },
            getTXHeight: function(a) {
                var b = Math.max(a.TR.height, a.TL.height);
                return b > 0 && (b += this.firstChildGap), b
            },
            getBXHeight: function(a) {
                var b = Math.max(a.BR.height, a.BL.height);
                return b > 0 && (b += this.firstChildGap), b
            },
            getXLWidth: function(a, b) {
                var c = Math.max(a.BL.width, a.TL.width);
                return c > 0 && (c -= b.width / 2), c
            },
            getRWidth: function(a, b) {
                return Math.max(a.R.width, this.getXRWidth(a, b))
            },
            getLWidth: function(a, b) {
                return Math.max(a.L.width, this.getXLWidth(a, b))
            },
            getTBOverlap: function(a, b) {
                var c = Math.max(a.T.width, a.B.width);
                return c > 0 && (c -= b.width, c /= 2), c
            },
            getRootDX: function(a, b) {
                var c = this.getTBOverlap(a, b),
                    d = Math.max(this.getLWidth(a, b), c);
                return d -= Math.max(this.getRWidth(a, b), c), d / 2
            },
            getMinimalGap: function(a) {
                return Math.min(a.siblingGap, this.firstChildGap, this.parentGap)
            },
            getBBox: function(a) {
                var b = d.rect(this),
                    c = a && a.expandBy;
                return c && b.moveAndExpand({
                    x: -c,
                    y: -c,
                    width: 2 * c,
                    height: 2 * c
                }), b
            },
            containsPoint: function(a, b) {
                return this.getBBox(b).containsPoint(a)
            },
            getLayoutSiblings: function(a) {
                return this.siblings[a]
            },
            getExtendedWidth: function() {
                return this.width + this.gap + this.rootOffset
            },
            getExtendedHeight: function() {
                return this.height + this.gap + this.rootOffset
            },
            findMinimalAreaByPoint: function(a, b) {
                if (!this.containsPoint(a, b)) return null;
                var d;
                return c.some(this.childAreas, function(c) {
                    return d = c.findMinimalAreaByPoint(a, b), !!d
                }), d || this
            },
            getType: function() {
                return c.reduce(this.siblings, function(a, b, c) {
                    return b.exists() ? a.concat(c) : a
                }, []).sort().join("-")
            },
            addParentReference: function(a) {
                this.parentArea = a
            },
            getRootAttributes: function(a, b) {
                var d = a.get(b.siblingRank || "siblingRank");
                return {
                    siblingRank: c.isNumber(d) ? d : null,
                    rootOffset: a.get(b.offset || "offset") || 0,
                    rootMargin: a.get(b.margin || "margin") || 0,
                    prevSiblingGap: a.get(b.prevSiblingGap || "prevSiblingGap") || 0,
                    nextSiblingGap: a.get(b.nextSiblingGap || "nextSiblingGap") || 0
                }
            },
            getRootSize: function(a, b) {
                var d = c.clone(a.get("size"));
                return d[this.marginDimension] += b, d
            },
            createSiblings: function(a, b) {
                var d = c.groupBy(a, "direction");
                return {
                    L: new h(d.L, this, b),
                    T: new r(d.T, this, b),
                    R: new i(d.R, this, b),
                    B: new s(d.B, this, b),
                    BR: new m(d.BR, this, b),
                    BL: new n(d.BL, this, b),
                    TR: new o(d.TR, this, b),
                    TL: new p(d.TL, this, b)
                }
            },
            computeSize: function(a, b) {
                return {
                    width: this.getWidth(a, b),
                    height: this.getHeight(a, b)
                }
            },
            computeOrigin: function() {
                var a = this.siblings,
                    b = this.rootSize,
                    c = Math.max(this.getLWidth(a, b) + b.width / 2, this.getXLWidth(a, b) + b.width / 2, a.T.width / 2, a.B.width / 2);
                return {
                    x: this.rootCX - c,
                    y: this.rootCY - this.getTHeight(a) - this.getLRHeight() / 2
                }
            },
            moveSiblings: function(a, b) {
                if (this.hasHorizontalSiblings(a)) {
                    var c = b.width / 2;
                    a.L.move(-c, 0), a.R.move(c, 0)
                }
                if (this.hasVerticalSiblings(a)) {
                    var d = this.getLRHeight() / 2;
                    a.T.move(0, -d), a.B.move(0, d), a.BR.move(0, d), a.BL.move(0, d), a.B.move(0, this.getBXHeight(a)), a.TR.move(0, -d), a.TL.move(0, -d), a.T.move(0, -this.getTXHeight(a))
                }
            },
            moveRootToConnectionPoint: function(a) {
                var b = this.getConnectionPoint(a);
                this.dx += b.x, this.dy += b.y
            },
            computeRelativePosition: function(a, b, d) {
                var e = this.siblings = this.createSiblings(b, {
                        siblingGap: d.siblingGap
                    }),
                    f = this.rootSize = this.getRootSize(a, d.rootMargin);
                c.extend(this, this.computeSize(e, f)), this.moveSiblings(e, f), this.moveRootToConnectionPoint(f), this.moveRootBehindSiblings(e, f), this.moveRootFromParent()
            },
            computeAbsolutePosition: function() {
                if (this.parentArea) this.rootCX = this.parentArea.rootCX + this.dx, this.rootCY = this.parentArea.rootCY + this.dy, this.level = this.parentArea.level + 1;
                else {
                    var a = this.root.getBBox().center();
                    this.rootCX = a.x, this.rootCY = a.y, this.level = 0
                }
                c.extend(this, this.computeOrigin())
            },
            hasVerticalSiblings: function(a) {
                return a.T.exists() || a.B.exists() || a.BR.exists() || a.BL.exists() || a.TR.exists() || a.TL.exists()
            },
            hasHorizontalSiblings: function(a) {
                return a.L.exists() || a.R.exists()
            },
            isSourceArea: function() {
                return !this.parentArea
            },
            isSinkArea: function() {
                return 0 === this.childAreas.length
            },
            getRootPosition: function() {
                var a = this.root.get("size");
                return {
                    x: this.rootCX - a.width / 2,
                    y: this.rootCY - a.height / 2
                }
            },
            getRootVertices: function(a, b) {
                if (b = b || {}, a = a || this, 0 === a[this.deltaCoordinate] || !this.parentArea) return [];
                var d, e = this.parentArea.getInnerSize();
                if (!b.ignoreSiblings && this.hasSiblingsBetweenParent()) {
                    var f = this.siblings[this.oppositeDirection];
                    d = this.getRelativeVerticesAvoidingSiblings(e, a, f)
                } else d = this.getRelativeVertices(e, a);
                return c.invoke(d, "offset", this.parentArea.rootCX, this.parentArea.rootCY)
            },
            getInnerSize: function() {
                return {
                    width: this.rootSize.width,
                    height: this.getLRHeight()
                }
            },
            getConnectionPoint: function() {
                return null
            },
            getRelativeVertices: function() {
                return null
            },
            moveRootFromParent: function() {},
            moveRootBehindSiblings: function() {},
            hasSiblingsBetweenParent: function() {
                return !this.isSourceArea() && this.siblings[this.oppositeDirection].exists()
            },
            getCY: function() {
                return this.height / 2 + this.prevSiblingGap
            },
            getCX: function() {
                return this.width / 2 + this.prevSiblingGap
            }
        }), f.extend = b.Model.extend;
        var t = f.extend({
                direction: "R",
                oppositeDirection: "L",
                deltaCoordinate: "dx",
                marginDimension: "height",
                getConnectionPoint: function(a) {
                    return d.point(a.width / 2, 0)
                },
                moveRootBehindSiblings: function(a, b) {
                    this.dx += Math.max(this.getLWidth(a, b), this.getTBOverlap(a, b)), this.dy += (this.getTHeight(a) - this.getBHeight(a)) / 2
                },
                moveRootFromParent: function() {
                    this.dx += this.parentGap + this.rootOffset
                },
                getRelativeVertices: function(a, b) {
                    var c = this.getConnectionPoint(a),
                        d = this.parentGap / 2;
                    return [c.clone().offset(d, 0), c.clone().offset(d, b.dy)]
                },
                getRelativeVerticesAvoidingSiblings: function(a, b, c) {
                    var d = this.getConnectionPoint(a),
                        e = c.siblingGap / 2,
                        f = this.dx > 0 ? -1 : 1,
                        g = b.dy + f * (c.height + e) / 2,
                        h = b.dy + f * this.rootSize.height / 4,
                        i = this.gap / 2,
                        j = 1.5 * i + Math.max(this.getLWidth(this.siblings, this.rootSize), this.getTBOverlap(this.siblings, this.rootSize));
                    return [d.clone().offset(i, 0), d.clone().offset(i, g), d.clone().offset(j, g), d.clone().offset(j, h)]
                }
            }),
            u = f.extend({
                direction: "L",
                oppositeDirection: "R",
                deltaCoordinate: "dx",
                marginDimension: "height",
                getConnectionPoint: function(a) {
                    return d.point(-a.width / 2, 0)
                },
                moveRootBehindSiblings: function(a, b) {
                    this.dx -= Math.max(this.getRWidth(a, b), this.getTBOverlap(a, b)), this.dy += (this.getTHeight(a) - this.getBHeight(a)) / 2
                },
                moveRootFromParent: function() {
                    this.dx -= this.parentGap + this.rootOffset
                },
                getRelativeVertices: function(a, b) {
                    var c = this.getConnectionPoint(a),
                        d = -this.parentGap / 2;
                    return [c.clone().offset(d, 0), c.clone().offset(d, b.dy)]
                },
                getRelativeVerticesAvoidingSiblings: function(a, b, c) {
                    var d = this.getConnectionPoint(a),
                        e = this.dx > 0 ? -1 : 1,
                        f = b.dy + e * (c.height + c.siblingGap / 2) / 2,
                        g = b.dy + e * this.rootSize.height / 4,
                        h = this.gap / 2,
                        i = 1.5 * h + Math.max(this.getRWidth(this.siblings, this.rootSize), this.getTBOverlap(this.siblings, this.rootSize));
                    return [d.clone().offset(-h, 0), d.clone().offset(-h, f), d.clone().offset(-i, f), d.clone().offset(-i, g)]
                }
            }),
            v = f.extend({
                direction: "T",
                oppositeDirection: "B",
                deltaCoordinate: "dy",
                marginDimension: "width",
                getConnectionPoint: function(a) {
                    return d.point(0, -a.height / 2)
                },
                moveRootBehindSiblings: function(a, b) {
                    this.dx += this.getRootDX(a, b), this.hasHorizontalSiblings(a) && (this.dy -= (this.getLRHeight() - b.height) / 2), this.dy -= this.getBHeight(a)
                },
                moveRootFromParent: function() {
                    this.dy -= this.parentGap + this.rootOffset
                },
                getRelativeVertices: function(a, b) {
                    var c = this.getConnectionPoint(a),
                        d = -this.getTXHeight(this.parentArea.siblings) - this.parentGap / 2;
                    return [c.clone().offset(0, d), c.clone().offset(b.dx, d)]
                },
                getRelativeVerticesAvoidingSiblings: function(a, b) {
                    var c = this.getConnectionPoint(a),
                        d = this.siblings,
                        e = d.B,
                        f = this.getTXHeight(this.parentArea.siblings) + this.parentGap / 2,
                        g = f + e.height;
                    g += this.getBXHeight(this.siblings) + this.parentGap / 4;
                    var h = this.dy < 0 ? -1 : 1,
                        i = d[h > 0 ? "BR" : "BL"].width,
                        j = b.dx;
                    j += h * (Math.max(i, e.width / 2) + e.siblingGap / 4);
                    var k = b.dx + h * this.rootSize.width / 4;
                    return [c.clone().offset(0, -f), c.clone().offset(j, -f), c.clone().offset(j, -g), c.clone().offset(k, -g)]
                }
            }),
            w = f.extend({
                direction: "B",
                oppositeDirection: "T",
                deltaCoordinate: "dy",
                marginDimension: "width",
                getConnectionPoint: function(a) {
                    return d.point(0, a.height / 2)
                },
                moveRootBehindSiblings: function(a, b) {
                    this.dx += this.getRootDX(a, b), this.dy += this.getTHeight(a), this.hasHorizontalSiblings(a) && (this.dy += (this.getLRHeight() - b.height) / 2)
                },
                moveRootFromParent: function() {
                    this.dy += this.parentGap + this.rootOffset
                },
                getRelativeVertices: function(a, b) {
                    var c = this.getConnectionPoint(a),
                        d = this.getBXHeight(this.parentArea.siblings) + this.parentGap / 2;
                    return [c.clone().offset(0, d), c.clone().offset(b.dx, d)]
                },
                getRelativeVerticesAvoidingSiblings: function(a, b) {
                    var c = this.getConnectionPoint(a),
                        d = this.siblings,
                        e = d.T,
                        f = this.getBXHeight(this.parentArea.siblings) + this.parentGap / 2,
                        g = f + e.height;
                    g += this.getTXHeight(d) + this.parentGap / 4;
                    var h = this.dy < 0 ? -1 : 1,
                        i = d[h > 0 ? "TR" : "TL"].width,
                        j = b.dx;
                    j += h * (Math.max(i, e.width / 2) + e.siblingGap / 4);
                    var k = b.dx + h * this.rootSize.width / 4;
                    return [c.clone().offset(0, f), c.clone().offset(j, f), c.clone().offset(j, g), c.clone().offset(k, g)]
                }
            }),
            x = f.extend({
                direction: "BR",
                oppositeDirection: "L",
                deltaCoordinate: "dy",
                marginDimension: "height",
                getConnectionPoint: function(a) {
                    return d.point(0, a.height / 2)
                },
                getCY: function() {
                    return this.prevSiblingGap
                },
                moveRootBehindSiblings: function(a, b) {
                    var c = Math.max(a.T.width, a.B.width);
                    this.dx += Math.max(this.getLWidth(a, b), (c - b.width) / 2), this.dy += this.getTHeight(a), this.hasHorizontalSiblings(a) && (this.dy += (this.getLRHeight() - b.height) / 2)
                },
                moveRootFromParent: function() {
                    this.dy += this.firstChildGap, this.dx += this.rootSize.width / 2 + this.rootOffset + this.parentGap
                },
                getRelativeVertices: function(a, b) {
                    var c = this.getConnectionPoint(a);
                    return [c.clone().offset(0, b.dy - a.height / 2)]
                },
                getRelativeVerticesAvoidingSiblings: function(a, b, c) {
                    var e = b.dx - this.rootSize.width / 4,
                        f = b.dy;
                    return f += Math.max(c.height, this.rootSize.height) / 2, f += this.getMinimalGap(c) / 2, [d.point(0, f), d.point(e, f)]
                }
            }),
            y = f.extend({
                direction: "BL",
                oppositeDirection: "R",
                deltaCoordinate: "dy",
                marginDimension: "height",
                getConnectionPoint: function(a) {
                    return d.point(0, a.height / 2)
                },
                getCY: function() {
                    return this.prevSiblingGap
                },
                moveRootBehindSiblings: function(a, b) {
                    var c = Math.max(a.T.width, a.B.width);
                    this.dx -= Math.max(this.getRWidth(a, b), (c - b.width) / 2), this.dy += this.getTHeight(a), this.hasHorizontalSiblings(a) && (this.dy += (this.getLRHeight() - b.height) / 2)
                },
                moveRootFromParent: function() {
                    this.dy += this.firstChildGap, this.dx -= this.rootSize.width / 2 + this.rootOffset + this.parentGap
                },
                getRelativeVertices: function(a, b) {
                    var c = this.getConnectionPoint(a);
                    return [c.clone().offset(0, b.dy - a.height / 2)]
                },
                getRelativeVerticesAvoidingSiblings: function(a, b, c) {
                    var e = b.dx + this.rootSize.width / 4,
                        f = b.dy;
                    return f += Math.max(c.height, this.rootSize.height) / 2, f += this.getMinimalGap(c) / 2, [d.point(0, f), d.point(e, f)]
                }
            }),
            z = f.extend({
                direction: "TR",
                oppositeDirection: "L",
                deltaCoordinate: "dy",
                marginDimension: "height",
                getConnectionPoint: function(a) {
                    return d.point(0, a.height / 2)
                },
                getCY: function() {
                    return this.height - this.rootSize.height + this.prevSiblingGap
                },
                moveRootBehindSiblings: function(a, b) {
                    this.dx += Math.max(this.getLWidth(a, b), this.getTBOverlap(a, b)), this.dy -= this.getBHeight(a), this.hasHorizontalSiblings(a) && (this.dy -= (this.getLRHeight() - b.height) / 2)
                },
                moveRootFromParent: function() {
                    this.dy -= this.firstChildGap, this.dx += this.rootSize.width / 2 + this.rootOffset + this.parentGap
                },
                getRelativeVertices: function(a, b) {
                    var c = this.getConnectionPoint(a);
                    return [c.clone().offset(0, b.dy - a.height / 2)]
                },
                getRelativeVerticesAvoidingSiblings: function(a, b, c) {
                    var e = b.dx - this.rootSize.width / 4,
                        f = b.dy;
                    return f -= Math.max(c.height, this.rootSize.height) / 2, f -= this.getMinimalGap(c) / 2, [d.point(0, f), d.point(e, f)]
                }
            }),
            A = f.extend({
                direction: "TL",
                oppositeDirection: "R",
                deltaCoordinate: "dy",
                marginDimension: "height",
                getConnectionPoint: function(a) {
                    return d.point(0, a.height / 2)
                },
                getCY: function() {
                    return this.height - this.rootSize.height + this.prevSiblingGap
                },
                moveRootBehindSiblings: function(a, b) {
                    this.dx -= Math.max(this.getRWidth(a, b), this.getTBOverlap(a, b)), this.dy -= this.getBHeight(a), this.hasHorizontalSiblings(a) && (this.dy -= (this.getLRHeight() - b.height) / 2)
                },
                moveRootFromParent: function() {
                    this.dy -= this.firstChildGap, this.dx -= this.rootSize.width / 2 + this.rootOffset + this.parentGap
                },
                getRelativeVertices: function(a, b) {
                    var c = this.getConnectionPoint(a);
                    return [c.clone().offset(0, b.dy - a.height / 2)]
                },
                getRelativeVerticesAvoidingSiblings: function(a, b, c) {
                    var e = b.dx + this.rootSize.width / 4,
                        f = b.dy;
                    return f -= Math.max(c.height, this.rootSize.height) / 2, f -= this.getMinimalGap(c) / 2, [d.point(0, f), d.point(e, f)]
                }
            }),
            B = {
                rotate: function(a) {
                    var b = "LRBT",
                        c = b.indexOf(a[0]) - b.indexOf(a[1]);
                    return function(a) {
                        var d = b.indexOf(a);
                        return d >= 0 ? b[(4 + d - c) % 4] : a
                    }
                },
                flip: function(a) {
                    var b = a[0],
                        c = a[1];
                    return function(a) {
                        return a === b ? c : a === c ? b : a
                    }
                },
                straighten: function(a) {
                    return c.constant(a[1])
                }
            },
            C = b.Model.extend({
                defaults: {
                    graph: void 0,
                    gap: 20,
                    parentGap: 20,
                    siblingGap: 20,
                    firstChildGap: 20,
                    direction: "R",
                    directionRule: B.straighten,
                    updatePosition: function(a, b, c) {
                        a.set("position", b, c)
                    },
                    updateVertices: function(a, b, c) {
                        a.set("vertices", b, c)
                    },
                    updateAttributes: null,
                    filter: null,
                    attributeNames: {}
                },
                initialize: function() {
                    this._cacheOptions(this.attributes), this.layoutAreas = {}
                },
                layout: function(a) {
                    return this.layoutAreas = {}, c.each(this.getGraphSources(a), c.partial(this.layoutTree, c, a), this), this.trigger("layout:done", a), this
                },
                layoutTree: function(a, b) {
                    b = b || {}, b.treeLayout = !0;
                    var c = this._computeLayoutAreas(a, this.get("direction"), b);
                    return this._computeAbsolutePositions(c), this._updateCells(c, b), this
                },
                getLayoutArea: function(a) {
                    return this.layoutAreas[a.id || a] || null
                },
                getRootLayoutAreas: function() {
                    return c.map(this.getGraphSources(), this.getLayoutArea, this)
                },
                getGraphSources: function(a) {
                    var b = this.graph.getSources();
                    return this.filter && b.length > 0 && (b = this.filter(b, null, a) || b), b
                },
                getMinimalRootAreaByPoint: function(a) {
                    var b = c.filter(this.getRootLayoutAreas(), function(b) {
                        return b.containsPoint(a)
                    });
                    return c.isEmpty(b) ? null : c.min(b, function(a) {
                        return a.width * a.height
                    })
                },
                _computeLayoutAreas: function(a, b, d) {
                    var e = a.get(this.getAttributeName("direction")) || b,
                        g = this._getChildren(a, d),
                        h = c.map(g, c.partial(this._computeLayoutAreas, c, e, d), this),
                        i = f.create(e, a, h, this.attributes);
                    return i.link = this.graph.getConnectedLinks(a, {
                        inbound: !0
                    })[0], this.layoutAreas[a.id] = i, i
                },
                _cacheOptions: function(a) {
                    var b = ["updateAttributes", "updateVertices", "updatePosition", "filter"];
                    c.each(b, function(b) {
                        this[b] = c.isFunction(a[b]) ? a[b] : null
                    }, this), this.graph = a.graph
                },
                _getChildren: function(a, b) {
                    var c = this.graph.getNeighbors(a, {
                        outbound: !0
                    });
                    return this.filter && c.length > 0 && (c = this.filter(c, a, b) || c), c
                },
                _computeAbsolutePositions: function(a) {
                    a.computeAbsolutePosition(a), c.each(a.childAreas, this._computeAbsolutePositions, this)
                },
                _updateCells: function(a, b) {
                    var d = a.root,
                        e = a.link || null;
                    e && (this.updatePosition && this.updatePosition(d, a.getRootPosition(), b), this.updateVertices && this.updateVertices(e, a.getRootVertices(), b)), this.changeSiblingRank(d, a.siblingRank, b), this.updateAttributes && this.updateAttributes(a, d, e, b), c.each(a.childAreas, c.partial(this._updateCells, c, b), this)
                },
                updateDirections: function(a, b, d) {
                    d = d || {};
                    var e = this.getAttributeName("direction"),
                        f = this.get("directionRule")(b);
                    this.graph.search(a, c.bind(function(a, b) {
                        if (0 !== b) {
                            var c = f(a.get(e));
                            this.changeDirection(a, c, d)
                        }
                    }, this), {
                        outbound: !0
                    })
                },
                reconnectElement: function(a, b, c) {
                    c = c || {};
                    var d = this.getLayoutArea(a),
                        e = d.link;
                    if (e) {
                        e.set("source", {
                            id: b.id || b
                        }, c);
                        var f = d.direction,
                            g = c.direction || f,
                            h = c.siblingRank || void 0;
                        return this.changeSiblingRank(a, h, c), this.changeDirection(a, g, c), f !== g && this.updateDirections(a, [f, c.direction], c), !0
                    }
                    return !1
                },
                changeSiblingRank: function(a, b, c) {
                    a.set(this.getAttributeName("siblingRank"), b, c)
                },
                changeDirection: function(a, b, c) {
                    a.set(this.getAttributeName("direction"), b, c)
                },
                getAttributeName: function(a) {
                    return this.get("attributeNames")[a] || a
                },
                getAttribute: function(a, b) {
                    return a.get(this.getAttributeName(b))
                },
                prepare: function() {
                    return this
                }
            }, {
                directionRules: B
            });
        a.layout.TreeLayout = C
    }(joint, Backbone, _, g);
    joint.format.gexf = {}, joint.format.gexf.toCellsArray = function(a, b, c) {
        var d = new DOMParser,
            e = d.parseFromString(a, "text/xml");
        if ("parsererror" == e.documentElement.nodeName) throw new Error("Error while parsing GEXF file.");
        var f = e.documentElement.querySelectorAll("node"),
            g = e.documentElement.querySelectorAll("edge"),
            h = [];
        return _.each(f, function(a) {
            var c = parseFloat(a.querySelector("size").getAttribute("value")),
                d = b({
                    id: a.getAttribute("id"),
                    width: c,
                    height: c,
                    label: a.getAttribute("label")
                });
            h.push(d)
        }), _.each(g, function(a) {
            var b = c({
                source: a.getAttribute("source"),
                target: a.getAttribute("target")
            });
            h.unshift(b)
        }), h
    };
    joint.dia.Paper.prototype.toSVG = function(a, b) {
        function c() {
            return (new XMLSerializer).serializeToString(f).replace(/&nbsp;/g, "Â ")
        }

        function d(a) {
            var b = V(m.shift());
            if (!b) return a();
            var c = b.attr("xlink:href") || b.attr("href");
            joint.util.imageToDataUri(c, function(c, e) {
                b.attr("xlink:href", e), d(a)
            })
        }
        b = b || {}, this.trigger("beforeexport", b);
        var e = b.area ? b.area : V.transformRect(this.getContentBBox(), this.viewport.getCTM().inverse()),
            f = this.svg.cloneNode(!0);
        f.removeAttribute("style"), b.preserveDimensions ? V(f).attr({
            width: e.width,
            height: e.height
        }) : V(f).attr({
            width: "100%",
            height: "100%"
        }), V(f).findOne(".joint-viewport").removeAttr("transform"), V(f).attr("viewBox", e.x + " " + e.y + " " + e.width + " " + e.height);
        for (var g = document.styleSheets.length, h = [], i = g - 1; i >= 0; i--) h[i] = document.styleSheets[i], document.styleSheets[i].disabled = !0;
        var j = {};
        $(this.svg).find("*").each(function(a) {
            var b = window.getComputedStyle(this, null),
                c = {};
            _.each(b, function(a) {
                c[a] = b.getPropertyValue(a)
            }), j[a] = c
        }), g != document.styleSheets.length && _.each(h, function(a, b) {
            document.styleSheets[b] = a
        });
        for (var k = 0; k < g; k++) document.styleSheets[k].disabled = !1;
        var l = {};
        $(this.svg).find("*").each(function(a) {
            var b = window.getComputedStyle(this, null),
                c = j[a],
                d = {};
            _.each(b, function(a) {
                b.getPropertyValue(a) !== c[a] && (d[a] = b.getPropertyValue(a))
            }), l[a] = d
        });
        var m = [];
        return $(f).find("*").each(function(a) {
            $(this).css(l[a]), "image" === this.tagName.toLowerCase() && m.push(this)
        }), this.trigger("afterexport", b), b.convertImagesToDataUris && m.length ? void d(function() {
            a(c())
        }) : a(c())
    }, joint.dia.Paper.prototype.openAsSVG = function(a) {
        var b = "menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes",
            c = _.uniqueId("svg_output");
        this.toSVG(function(a) {
            var d = window.open("", c, b),
                e = "data:image/svg+xml," + encodeURIComponent(a);
            d.document.write('<img src="' + e + '" style="max-height:100%" />')
        }, _.extend({
            convertImagesToDataUris: !0
        }, a))
    };

    function RGBColor(a) {
        this.ok = !1, "#" == a.charAt(0) && (a = a.substr(1, 6)), a = a.replace(/ /g, ""), a = a.toLowerCase();
        var b = {
            aliceblue: "f0f8ff",
            antiquewhite: "faebd7",
            aqua: "00ffff",
            aquamarine: "7fffd4",
            azure: "f0ffff",
            beige: "f5f5dc",
            bisque: "ffe4c4",
            black: "000000",
            blanchedalmond: "ffebcd",
            blue: "0000ff",
            blueviolet: "8a2be2",
            brown: "a52a2a",
            burlywood: "deb887",
            cadetblue: "5f9ea0",
            chartreuse: "7fff00",
            chocolate: "d2691e",
            coral: "ff7f50",
            cornflowerblue: "6495ed",
            cornsilk: "fff8dc",
            crimson: "dc143c",
            cyan: "00ffff",
            darkblue: "00008b",
            darkcyan: "008b8b",
            darkgoldenrod: "b8860b",
            darkgray: "a9a9a9",
            darkgreen: "006400",
            darkkhaki: "bdb76b",
            darkmagenta: "8b008b",
            darkolivegreen: "556b2f",
            darkorange: "ff8c00",
            darkorchid: "9932cc",
            darkred: "8b0000",
            darksalmon: "e9967a",
            darkseagreen: "8fbc8f",
            darkslateblue: "483d8b",
            darkslategray: "2f4f4f",
            darkturquoise: "00ced1",
            darkviolet: "9400d3",
            deeppink: "ff1493",
            deepskyblue: "00bfff",
            dimgray: "696969",
            dodgerblue: "1e90ff",
            feldspar: "d19275",
            firebrick: "b22222",
            floralwhite: "fffaf0",
            forestgreen: "228b22",
            fuchsia: "ff00ff",
            gainsboro: "dcdcdc",
            ghostwhite: "f8f8ff",
            gold: "ffd700",
            goldenrod: "daa520",
            gray: "808080",
            green: "008000",
            greenyellow: "adff2f",
            honeydew: "f0fff0",
            hotpink: "ff69b4",
            indianred: "cd5c5c",
            indigo: "4b0082",
            ivory: "fffff0",
            khaki: "f0e68c",
            lavender: "e6e6fa",
            lavenderblush: "fff0f5",
            lawngreen: "7cfc00",
            lemonchiffon: "fffacd",
            lightblue: "add8e6",
            lightcoral: "f08080",
            lightcyan: "e0ffff",
            lightgoldenrodyellow: "fafad2",
            lightgrey: "d3d3d3",
            lightgreen: "90ee90",
            lightpink: "ffb6c1",
            lightsalmon: "ffa07a",
            lightseagreen: "20b2aa",
            lightskyblue: "87cefa",
            lightslateblue: "8470ff",
            lightslategray: "778899",
            lightsteelblue: "b0c4de",
            lightyellow: "ffffe0",
            lime: "00ff00",
            limegreen: "32cd32",
            linen: "faf0e6",
            magenta: "ff00ff",
            maroon: "800000",
            mediumaquamarine: "66cdaa",
            mediumblue: "0000cd",
            mediumorchid: "ba55d3",
            mediumpurple: "9370d8",
            mediumseagreen: "3cb371",
            mediumslateblue: "7b68ee",
            mediumspringgreen: "00fa9a",
            mediumturquoise: "48d1cc",
            mediumvioletred: "c71585",
            midnightblue: "191970",
            mintcream: "f5fffa",
            mistyrose: "ffe4e1",
            moccasin: "ffe4b5",
            navajowhite: "ffdead",
            navy: "000080",
            oldlace: "fdf5e6",
            olive: "808000",
            olivedrab: "6b8e23",
            orange: "ffa500",
            orangered: "ff4500",
            orchid: "da70d6",
            palegoldenrod: "eee8aa",
            palegreen: "98fb98",
            paleturquoise: "afeeee",
            palevioletred: "d87093",
            papayawhip: "ffefd5",
            peachpuff: "ffdab9",
            peru: "cd853f",
            pink: "ffc0cb",
            plum: "dda0dd",
            powderblue: "b0e0e6",
            purple: "800080",
            red: "ff0000",
            rosybrown: "bc8f8f",
            royalblue: "4169e1",
            saddlebrown: "8b4513",
            salmon: "fa8072",
            sandybrown: "f4a460",
            seagreen: "2e8b57",
            seashell: "fff5ee",
            sienna: "a0522d",
            silver: "c0c0c0",
            skyblue: "87ceeb",
            slateblue: "6a5acd",
            slategray: "708090",
            snow: "fffafa",
            springgreen: "00ff7f",
            steelblue: "4682b4",
            tan: "d2b48c",
            teal: "008080",
            thistle: "d8bfd8",
            tomato: "ff6347",
            turquoise: "40e0d0",
            violet: "ee82ee",
            violetred: "d02090",
            wheat: "f5deb3",
            white: "ffffff",
            whitesmoke: "f5f5f5",
            yellow: "ffff00",
            yellowgreen: "9acd32"
        };
        for (var c in b) a == c && (a = b[c]);
        for (var d = [{
                re: /^rgb\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})\)$/,
                example: ["rgb(123, 234, 45)", "rgb(255,234,245)"],
                process: function(a) {
                    return [parseInt(a[1]), parseInt(a[2]), parseInt(a[3])]
                }
            }, {
                re: /^(\w{2})(\w{2})(\w{2})$/,
                example: ["#00ff00", "336699"],
                process: function(a) {
                    return [parseInt(a[1], 16), parseInt(a[2], 16), parseInt(a[3], 16)]
                }
            }, {
                re: /^(\w{1})(\w{1})(\w{1})$/,
                example: ["#fb0", "f0f"],
                process: function(a) {
                    return [parseInt(a[1] + a[1], 16), parseInt(a[2] + a[2], 16), parseInt(a[3] + a[3], 16)]
                }
            }], e = 0; e < d.length; e++) {
            var f = d[e].re,
                g = d[e].process,
                h = f.exec(a);
            h && (channels = g(h), this.r = channels[0], this.g = channels[1], this.b = channels[2], this.ok = !0)
        }
        this.r = this.r < 0 || isNaN(this.r) ? 0 : this.r > 255 ? 255 : this.r, this.g = this.g < 0 || isNaN(this.g) ? 0 : this.g > 255 ? 255 : this.g, this.b = this.b < 0 || isNaN(this.b) ? 0 : this.b > 255 ? 255 : this.b, this.toRGB = function() {
            return "rgb(" + this.r + ", " + this.g + ", " + this.b + ")"
        }, this.toHex = function() {
            var a = this.r.toString(16),
                b = this.g.toString(16),
                c = this.b.toString(16);
            return 1 == a.length && (a = "0" + a), 1 == b.length && (b = "0" + b), 1 == c.length && (c = "0" + c), "#" + a + b + c
        }, this.getHelpXML = function() {
            for (var a = new Array, c = 0; c < d.length; c++)
                for (var e = d[c].example, f = 0; f < e.length; f++) a[a.length] = e[f];
            for (var g in b) a[a.length] = g;
            var h = document.createElement("ul");
            h.setAttribute("id", "rgbcolor-examples");
            for (var c = 0; c < a.length; c++) try {
                var i = document.createElement("li"),
                    j = new RGBColor(a[c]),
                    k = document.createElement("div");
                k.style.cssText = "margin: 3px; border: 1px solid black; background:" + j.toHex() + "; color:" + j.toHex(), k.appendChild(document.createTextNode("test"));
                var l = document.createTextNode(" " + a[c] + " -> " + j.toRGB() + " -> " + j.toHex());
                i.appendChild(k), i.appendChild(l), h.appendChild(i)
            } catch (m) {}
            return h
        }
    }

    function stackBlurImage(a, b, c, d) {
        var e = document.getElementById(a),
            f = e.naturalWidth,
            g = e.naturalHeight,
            h = document.getElementById(b);
        h.style.width = f + "px", h.style.height = g + "px", h.width = f, h.height = g;
        var i = h.getContext("2d");
        i.clearRect(0, 0, f, g), i.drawImage(e, 0, 0), isNaN(c) || c < 1 || (d ? stackBlurCanvasRGBA(b, 0, 0, f, g, c) : stackBlurCanvasRGB(b, 0, 0, f, g, c))
    }

    function stackBlurCanvasRGBA(a, b, c, d, e, f) {
        if (!(isNaN(f) || f < 1)) {
            f |= 0;
            var g, h = document.getElementById(a),
                i = h.getContext("2d");
            try {
                try {
                    g = i.getImageData(b, c, d, e)
                } catch (j) {
                    try {
                        netscape.security.PrivilegeManager.enablePrivilege("UniversalBrowserRead"), g = i.getImageData(b, c, d, e)
                    } catch (j) {
                        throw alert("Cannot access local image"), new Error("unable to access local image data: " + j)
                    }
                }
            } catch (j) {
                throw alert("Cannot access image"), new Error("unable to access image data: " + j)
            }
            var k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, A, B, C, D, E, F, G, H, I = g.data,
                J = f + f + 1,
                K = d - 1,
                L = e - 1,
                M = f + 1,
                N = M * (M + 1) / 2,
                O = new BlurStack,
                P = O;
            for (m = 1; m < J; m++)
                if (P = P.next = new BlurStack, m == M) var Q = P;
            P.next = O;
            var R = null,
                S = null;
            q = p = 0;
            var T = mul_table[f],
                U = shg_table[f];
            for (l = 0; l < e; l++) {
                for (z = A = B = C = r = s = t = u = 0, v = M * (D = I[p]), w = M * (E = I[p + 1]), x = M * (F = I[p + 2]), y = M * (G = I[p + 3]), r += N * D, s += N * E, t += N * F, u += N * G, P = O, m = 0; m < M; m++) P.r = D, P.g = E, P.b = F, P.a = G, P = P.next;
                for (m = 1; m < M; m++) n = p + ((K < m ? K : m) << 2), r += (P.r = D = I[n]) * (H = M - m), s += (P.g = E = I[n + 1]) * H, t += (P.b = F = I[n + 2]) * H, u += (P.a = G = I[n + 3]) * H, z += D, A += E, B += F, C += G, P = P.next;
                for (R = O, S = Q, k = 0; k < d; k++) I[p + 3] = G = u * T >> U, 0 != G ? (G = 255 / G, I[p] = (r * T >> U) * G, I[p + 1] = (s * T >> U) * G, I[p + 2] = (t * T >> U) * G) : I[p] = I[p + 1] = I[p + 2] = 0, r -= v, s -= w, t -= x, u -= y, v -= R.r, w -= R.g, x -= R.b, y -= R.a, n = q + ((n = k + f + 1) < K ? n : K) << 2, z += R.r = I[n], A += R.g = I[n + 1], B += R.b = I[n + 2], C += R.a = I[n + 3], r += z, s += A, t += B, u += C, R = R.next, v += D = S.r, w += E = S.g, x += F = S.b, y += G = S.a, z -= D, A -= E, B -= F, C -= G, S = S.next, p += 4;
                q += d
            }
            for (k = 0; k < d; k++) {
                for (A = B = C = z = s = t = u = r = 0, p = k << 2, v = M * (D = I[p]), w = M * (E = I[p + 1]), x = M * (F = I[p + 2]), y = M * (G = I[p + 3]), r += N * D, s += N * E, t += N * F, u += N * G, P = O, m = 0; m < M; m++) P.r = D, P.g = E, P.b = F, P.a = G, P = P.next;
                for (o = d, m = 1; m <= f; m++) p = o + k << 2, r += (P.r = D = I[p]) * (H = M - m), s += (P.g = E = I[p + 1]) * H, t += (P.b = F = I[p + 2]) * H, u += (P.a = G = I[p + 3]) * H, z += D, A += E, B += F, C += G, P = P.next, m < L && (o += d);
                for (p = k, R = O, S = Q, l = 0; l < e; l++) n = p << 2, I[n + 3] = G = u * T >> U, G > 0 ? (G = 255 / G, I[n] = (r * T >> U) * G, I[n + 1] = (s * T >> U) * G, I[n + 2] = (t * T >> U) * G) : I[n] = I[n + 1] = I[n + 2] = 0, r -= v, s -= w, t -= x, u -= y, v -= R.r, w -= R.g, x -= R.b, y -= R.a, n = k + ((n = l + M) < L ? n : L) * d << 2, r += z += R.r = I[n], s += A += R.g = I[n + 1], t += B += R.b = I[n + 2], u += C += R.a = I[n + 3], R = R.next, v += D = S.r, w += E = S.g, x += F = S.b, y += G = S.a, z -= D, A -= E, B -= F, C -= G, S = S.next, p += d
            }
            i.putImageData(g, b, c)
        }
    }

    function stackBlurCanvasRGB(a, b, c, d, e, f) {
        if (!(isNaN(f) || f < 1)) {
            f |= 0;
            var g, h = document.getElementById(a),
                i = h.getContext("2d");
            try {
                try {
                    g = i.getImageData(b, c, d, e)
                } catch (j) {
                    try {
                        netscape.security.PrivilegeManager.enablePrivilege("UniversalBrowserRead"), g = i.getImageData(b, c, d, e)
                    } catch (j) {
                        throw alert("Cannot access local image"), new Error("unable to access local image data: " + j)
                    }
                }
            } catch (j) {
                throw alert("Cannot access image"), new Error("unable to access image data: " + j)
            }
            var k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, A, B, C, D, E = g.data,
                F = f + f + 1,
                G = d - 1,
                H = e - 1,
                I = f + 1,
                J = I * (I + 1) / 2,
                K = new BlurStack,
                L = K;
            for (m = 1; m < F; m++)
                if (L = L.next = new BlurStack, m == I) var M = L;
            L.next = K;
            var N = null,
                O = null;
            q = p = 0;
            var P = mul_table[f],
                Q = shg_table[f];
            for (l = 0; l < e; l++) {
                for (x = y = z = r = s = t = 0, u = I * (A = E[p]), v = I * (B = E[p + 1]), w = I * (C = E[p + 2]), r += J * A, s += J * B, t += J * C, L = K, m = 0; m < I; m++) L.r = A, L.g = B, L.b = C, L = L.next;
                for (m = 1; m < I; m++) n = p + ((G < m ? G : m) << 2), r += (L.r = A = E[n]) * (D = I - m), s += (L.g = B = E[n + 1]) * D, t += (L.b = C = E[n + 2]) * D, x += A, y += B, z += C, L = L.next;
                for (N = K, O = M, k = 0; k < d; k++) E[p] = r * P >> Q, E[p + 1] = s * P >> Q, E[p + 2] = t * P >> Q, r -= u, s -= v, t -= w, u -= N.r, v -= N.g, w -= N.b, n = q + ((n = k + f + 1) < G ? n : G) << 2, x += N.r = E[n], y += N.g = E[n + 1], z += N.b = E[n + 2], r += x, s += y, t += z, N = N.next, u += A = O.r, v += B = O.g, w += C = O.b, x -= A, y -= B, z -= C, O = O.next, p += 4;
                q += d
            }
            for (k = 0; k < d; k++) {
                for (y = z = x = s = t = r = 0, p = k << 2, u = I * (A = E[p]), v = I * (B = E[p + 1]), w = I * (C = E[p + 2]), r += J * A, s += J * B, t += J * C, L = K, m = 0; m < I; m++) L.r = A, L.g = B, L.b = C, L = L.next;
                for (o = d, m = 1; m <= f; m++) p = o + k << 2, r += (L.r = A = E[p]) * (D = I - m), s += (L.g = B = E[p + 1]) * D, t += (L.b = C = E[p + 2]) * D, x += A, y += B, z += C, L = L.next, m < H && (o += d);
                for (p = k, N = K, O = M, l = 0; l < e; l++) n = p << 2, E[n] = r * P >> Q, E[n + 1] = s * P >> Q, E[n + 2] = t * P >> Q, r -= u, s -= v, t -= w, u -= N.r, v -= N.g, w -= N.b, n = k + ((n = l + I) < H ? n : H) * d << 2, r += x += N.r = E[n], s += y += N.g = E[n + 1], t += z += N.b = E[n + 2], N = N.next, u += A = O.r, v += B = O.g, w += C = O.b, x -= A, y -= B, z -= C, O = O.next, p += d
            }
            i.putImageData(g, b, c)
        }
    }

    function BlurStack() {
        this.r = 0, this.g = 0, this.b = 0, this.a = 0, this.next = null
    }
    var mul_table = [512, 512, 456, 512, 328, 456, 335, 512, 405, 328, 271, 456, 388, 335, 292, 512, 454, 405, 364, 328, 298, 271, 496, 456, 420, 388, 360, 335, 312, 292, 273, 512, 482, 454, 428, 405, 383, 364, 345, 328, 312, 298, 284, 271, 259, 496, 475, 456, 437, 420, 404, 388, 374, 360, 347, 335, 323, 312, 302, 292, 282, 273, 265, 512, 497, 482, 468, 454, 441, 428, 417, 405, 394, 383, 373, 364, 354, 345, 337, 328, 320, 312, 305, 298, 291, 284, 278, 271, 265, 259, 507, 496, 485, 475, 465, 456, 446, 437, 428, 420, 412, 404, 396, 388, 381, 374, 367, 360, 354, 347, 341, 335, 329, 323, 318, 312, 307, 302, 297, 292, 287, 282, 278, 273, 269, 265, 261, 512, 505, 497, 489, 482, 475, 468, 461, 454, 447, 441, 435, 428, 422, 417, 411, 405, 399, 394, 389, 383, 378, 373, 368, 364, 359, 354, 350, 345, 341, 337, 332, 328, 324, 320, 316, 312, 309, 305, 301, 298, 294, 291, 287, 284, 281, 278, 274, 271, 268, 265, 262, 259, 257, 507, 501, 496, 491, 485, 480, 475, 470, 465, 460, 456, 451, 446, 442, 437, 433, 428, 424, 420, 416, 412, 408, 404, 400, 396, 392, 388, 385, 381, 377, 374, 370, 367, 363, 360, 357, 354, 350, 347, 344, 341, 338, 335, 332, 329, 326, 323, 320, 318, 315, 312, 310, 307, 304, 302, 299, 297, 294, 292, 289, 287, 285, 282, 280, 278, 275, 273, 271, 269, 267, 265, 263, 261, 259],
        shg_table = [9, 11, 12, 13, 13, 14, 14, 15, 15, 15, 15, 16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24];
    ! function() {
        function a() {
            var a = {};
            return a.FRAMERATE = 30, a.MAX_VIRTUAL_PIXELS = 3e4, a.init = function(b) {
                var c = 0;
                a.UniqueId = function() {
                    return c++, "canvg" + c
                }, a.Definitions = {}, a.Styles = {}, a.Animations = [], a.Images = [], a.ctx = b, a.ViewPort = new function() {
                    this.viewPorts = [], this.Clear = function() {
                        this.viewPorts = []
                    }, this.SetCurrent = function(a, b) {
                        this.viewPorts.push({
                            width: a,
                            height: b
                        })
                    }, this.RemoveCurrent = function() {
                        this.viewPorts.pop()
                    }, this.Current = function() {
                        return this.viewPorts[this.viewPorts.length - 1]
                    }, this.width = function() {
                        return this.Current().width
                    }, this.height = function() {
                        return this.Current().height
                    }, this.ComputeSize = function(a) {
                        return null != a && "number" == typeof a ? a : "x" == a ? this.width() : "y" == a ? this.height() : Math.sqrt(Math.pow(this.width(), 2) + Math.pow(this.height(), 2)) / Math.sqrt(2)
                    }
                }
            }, a.init(), a.ImagesLoaded = function() {
                for (var b = 0; b < a.Images.length; b++)
                    if (!a.Images[b].loaded) return !1;
                return !0
            }, a.trim = function(a) {
                return a.replace(/^\s+|\s+$/g, "")
            }, a.compressSpaces = function(a) {
                return a.replace(/[\s\r\t\n]+/gm, " ")
            }, a.ajax = function(a) {
                var b;
                return b = window.XMLHttpRequest ? new XMLHttpRequest : new ActiveXObject("Microsoft.XMLHTTP"), b ? (b.open("GET", a, !1), b.send(null), b.responseText) : null
            }, a.parseXml = function(a) {
                if (window.DOMParser) {
                    var b = new DOMParser;
                    return b.parseFromString(a, "text/xml")
                }
                a = a.replace(/<!DOCTYPE svg[^>]*>/, "");
                var c = new ActiveXObject("Microsoft.XMLDOM");
                return c.async = "false", c.loadXML(a), c
            }, a.Property = function(a, b) {
                this.name = a, this.value = b
            }, a.Property.prototype.getValue = function() {
                return this.value
            }, a.Property.prototype.hasValue = function() {
                return null != this.value && "" !== this.value
            }, a.Property.prototype.numValue = function() {
                if (!this.hasValue()) return 0;
                var a = parseFloat(this.value);
                return (this.value + "").match(/%$/) && (a /= 100), a
            }, a.Property.prototype.valueOrDefault = function(a) {
                return this.hasValue() ? this.value : a
            }, a.Property.prototype.numValueOrDefault = function(a) {
                return this.hasValue() ? this.numValue() : a
            }, a.Property.prototype.addOpacity = function(b) {
                var c = this.value;
                if (null != b && "" != b && "string" == typeof this.value) {
                    var d = new RGBColor(this.value);
                    d.ok && (c = "rgba(" + d.r + ", " + d.g + ", " + d.b + ", " + b + ")")
                }
                return new a.Property(this.name, c)
            }, a.Property.prototype.getDefinition = function() {
                var b = this.value.match(/#([^\)'"]+)/);
                return b && (b = b[1]), b || (b = this.value), a.Definitions[b]
            }, a.Property.prototype.isUrlDefinition = function() {
                return 0 == this.value.indexOf("url(")
            }, a.Property.prototype.getFillStyleDefinition = function(b, c) {
                var d = this.getDefinition();
                if (null != d && d.createGradient) return d.createGradient(a.ctx, b, c);
                if (null != d && d.createPattern) {
                    if (d.getHrefAttribute().hasValue()) {
                        var e = d.attribute("patternTransform");
                        d = d.getHrefAttribute().getDefinition(), e.hasValue() && (d.attribute("patternTransform", !0).value = e.value)
                    }
                    return d.createPattern(a.ctx, b)
                }
                return null
            }, a.Property.prototype.getDPI = function(a) {
                return 96
            }, a.Property.prototype.getEM = function(b) {
                var c = 12,
                    d = new a.Property("fontSize", a.Font.Parse(a.ctx.font).fontSize);
                return d.hasValue() && (c = d.toPixels(b)), c
            }, a.Property.prototype.getUnits = function() {
                var a = this.value + "";
                return a.replace(/[0-9\.\-]/g, "")
            }, a.Property.prototype.toPixels = function(b, c) {
                if (!this.hasValue()) return 0;
                var d = this.value + "";
                if (d.match(/em$/)) return this.numValue() * this.getEM(b);
                if (d.match(/ex$/)) return this.numValue() * this.getEM(b) / 2;
                if (d.match(/px$/)) return this.numValue();
                if (d.match(/pt$/)) return this.numValue() * this.getDPI(b) * (1 / 72);
                if (d.match(/pc$/)) return 15 * this.numValue();
                if (d.match(/cm$/)) return this.numValue() * this.getDPI(b) / 2.54;
                if (d.match(/mm$/)) return this.numValue() * this.getDPI(b) / 25.4;
                if (d.match(/in$/)) return this.numValue() * this.getDPI(b);
                if (d.match(/%$/)) return this.numValue() * a.ViewPort.ComputeSize(b);
                var e = this.numValue();
                return c && e < 1 ? e * a.ViewPort.ComputeSize(b) : e
            }, a.Property.prototype.toMilliseconds = function() {
                if (!this.hasValue()) return 0;
                var a = this.value + "";
                return a.match(/s$/) ? 1e3 * this.numValue() : a.match(/ms$/) ? this.numValue() : this.numValue()
            }, a.Property.prototype.toRadians = function() {
                if (!this.hasValue()) return 0;
                var a = this.value + "";
                return a.match(/deg$/) ? this.numValue() * (Math.PI / 180) : a.match(/grad$/) ? this.numValue() * (Math.PI / 200) : a.match(/rad$/) ? this.numValue() : this.numValue() * (Math.PI / 180)
            }, a.Font = new function() {
                this.Styles = "normal|italic|oblique|inherit", this.Variants = "normal|small-caps|inherit", this.Weights = "normal|bold|bolder|lighter|100|200|300|400|500|600|700|800|900|inherit", this.CreateFont = function(b, c, d, e, f, g) {
                    var h = null != g ? this.Parse(g) : this.CreateFont("", "", "", "", "", a.ctx.font);
                    return {
                        fontFamily: f || h.fontFamily,
                        fontSize: e || h.fontSize,
                        fontStyle: b || h.fontStyle,
                        fontWeight: d || h.fontWeight,
                        fontVariant: c || h.fontVariant,
                        toString: function() {
                            return [this.fontStyle, this.fontVariant, this.fontWeight, this.fontSize, this.fontFamily].join(" ")
                        }
                    }
                };
                var b = this;
                this.Parse = function(c) {
                    for (var d = {}, e = a.trim(a.compressSpaces(c || "")).split(" "), f = {
                            fontSize: !1,
                            fontStyle: !1,
                            fontWeight: !1,
                            fontVariant: !1
                        }, g = "", h = 0; h < e.length; h++) f.fontStyle || b.Styles.indexOf(e[h]) == -1 ? f.fontVariant || b.Variants.indexOf(e[h]) == -1 ? f.fontWeight || b.Weights.indexOf(e[h]) == -1 ? f.fontSize ? "inherit" != e[h] && (g += e[h]) : ("inherit" != e[h] && (d.fontSize = e[h].split("/")[0]), f.fontStyle = f.fontVariant = f.fontWeight = f.fontSize = !0) : ("inherit" != e[h] && (d.fontWeight = e[h]), f.fontStyle = f.fontVariant = f.fontWeight = !0) : ("inherit" != e[h] && (d.fontVariant = e[h]), f.fontStyle = f.fontVariant = !0) : ("inherit" != e[h] && (d.fontStyle = e[h]), f.fontStyle = !0);
                    return "" != g && (d.fontFamily = g), d
                }
            }, a.ToNumberArray = function(b) {
                for (var c = a.trim(a.compressSpaces((b || "").replace(/,/g, " "))).split(" "), d = 0; d < c.length; d++) c[d] = parseFloat(c[d]);
                return c
            }, a.Point = function(a, b) {
                this.x = a, this.y = b
            }, a.Point.prototype.angleTo = function(a) {
                return Math.atan2(a.y - this.y, a.x - this.x)
            }, a.Point.prototype.applyTransform = function(a) {
                var b = this.x * a[0] + this.y * a[2] + a[4],
                    c = this.x * a[1] + this.y * a[3] + a[5];
                this.x = b, this.y = c
            }, a.CreatePoint = function(b) {
                var c = a.ToNumberArray(b);
                return new a.Point(c[0], c[1])
            }, a.CreatePath = function(b) {
                for (var c = a.ToNumberArray(b), d = [], e = 0; e < c.length; e += 2) d.push(new a.Point(c[e], c[e + 1]));
                return d
            }, a.BoundingBox = function(a, b, c, d) {
                this.x1 = Number.NaN, this.y1 = Number.NaN, this.x2 = Number.NaN, this.y2 = Number.NaN, this.x = function() {
                    return this.x1
                }, this.y = function() {
                    return this.y1
                }, this.width = function() {
                    return this.x2 - this.x1
                }, this.height = function() {
                    return this.y2 - this.y1
                }, this.addPoint = function(a, b) {
                    null != a && ((isNaN(this.x1) || isNaN(this.x2)) && (this.x1 = a, this.x2 = a), a < this.x1 && (this.x1 = a), a > this.x2 && (this.x2 = a)), null != b && ((isNaN(this.y1) || isNaN(this.y2)) && (this.y1 = b, this.y2 = b), b < this.y1 && (this.y1 = b), b > this.y2 && (this.y2 = b))
                }, this.addX = function(a) {
                    this.addPoint(a, null)
                }, this.addY = function(a) {
                    this.addPoint(null, a)
                }, this.addBoundingBox = function(a) {
                    this.addPoint(a.x1, a.y1), this.addPoint(a.x2, a.y2)
                }, this.addQuadraticCurve = function(a, b, c, d, e, f) {
                    var g = a + 2 / 3 * (c - a),
                        h = b + 2 / 3 * (d - b),
                        i = g + 1 / 3 * (e - a),
                        j = h + 1 / 3 * (f - b);
                    this.addBezierCurve(a, b, g, i, h, j, e, f)
                }, this.addBezierCurve = function(a, b, c, d, e, f, g, h) {
                    var j = [a, b],
                        k = [c, d],
                        l = [e, f],
                        m = [g, h];
                    for (this.addPoint(j[0], j[1]), this.addPoint(m[0], m[1]), i = 0; i <= 1; i++) {
                        var n = function(a) {
                                return Math.pow(1 - a, 3) * j[i] + 3 * Math.pow(1 - a, 2) * a * k[i] + 3 * (1 - a) * Math.pow(a, 2) * l[i] + Math.pow(a, 3) * m[i]
                            },
                            o = 6 * j[i] - 12 * k[i] + 6 * l[i],
                            p = -3 * j[i] + 9 * k[i] - 9 * l[i] + 3 * m[i],
                            q = 3 * k[i] - 3 * j[i];
                        if (0 != p) {
                            var r = Math.pow(o, 2) - 4 * q * p;
                            if (!(r < 0)) {
                                var s = (-o + Math.sqrt(r)) / (2 * p);
                                0 < s && s < 1 && (0 == i && this.addX(n(s)), 1 == i && this.addY(n(s)));
                                var t = (-o - Math.sqrt(r)) / (2 * p);
                                0 < t && t < 1 && (0 == i && this.addX(n(t)), 1 == i && this.addY(n(t)))
                            }
                        } else {
                            if (0 == o) continue;
                            var u = -q / o;
                            0 < u && u < 1 && (0 == i && this.addX(n(u)), 1 == i && this.addY(n(u)))
                        }
                    }
                }, this.isPointInBox = function(a, b) {
                    return this.x1 <= a && a <= this.x2 && this.y1 <= b && b <= this.y2
                }, this.addPoint(a, b), this.addPoint(c, d)
            }, a.Transform = function(b) {
                var c = this;
                this.Type = {}, this.Type.translate = function(b) {
                    this.p = a.CreatePoint(b), this.apply = function(a) {
                        a.translate(this.p.x || 0, this.p.y || 0)
                    }, this.unapply = function(a) {
                        a.translate(-1 * this.p.x || 0, -1 * this.p.y || 0)
                    }, this.applyToPoint = function(a) {
                        a.applyTransform([1, 0, 0, 1, this.p.x || 0, this.p.y || 0])
                    }
                }, this.Type.rotate = function(b) {
                    var c = a.ToNumberArray(b);
                    this.angle = new a.Property("angle", c[0]), this.cx = c[1] || 0, this.cy = c[2] || 0, this.apply = function(a) {
                        a.translate(this.cx, this.cy), a.rotate(this.angle.toRadians()), a.translate(-this.cx, -this.cy)
                    }, this.unapply = function(a) {
                        a.translate(this.cx, this.cy), a.rotate(-1 * this.angle.toRadians()), a.translate(-this.cx, -this.cy)
                    }, this.applyToPoint = function(a) {
                        var b = this.angle.toRadians();
                        a.applyTransform([1, 0, 0, 1, this.p.x || 0, this.p.y || 0]), a.applyTransform([Math.cos(b), Math.sin(b), -Math.sin(b), Math.cos(b), 0, 0]), a.applyTransform([1, 0, 0, 1, -this.p.x || 0, -this.p.y || 0])
                    }
                }, this.Type.scale = function(b) {
                    this.p = a.CreatePoint(b), this.apply = function(a) {
                        a.scale(this.p.x || 1, this.p.y || this.p.x || 1)
                    }, this.unapply = function(a) {
                        a.scale(1 / this.p.x || 1, 1 / this.p.y || this.p.x || 1)
                    }, this.applyToPoint = function(a) {
                        a.applyTransform([this.p.x || 0, 0, 0, this.p.y || 0, 0, 0])
                    }
                }, this.Type.matrix = function(b) {
                    this.m = a.ToNumberArray(b), this.apply = function(a) {
                        a.transform(this.m[0], this.m[1], this.m[2], this.m[3], this.m[4], this.m[5])
                    }, this.applyToPoint = function(a) {
                        a.applyTransform(this.m)
                    }
                }, this.Type.SkewBase = function(b) {
                    this.base = c.Type.matrix, this.base(b), this.angle = new a.Property("angle", b)
                }, this.Type.SkewBase.prototype = new this.Type.matrix, this.Type.skewX = function(a) {
                    this.base = c.Type.SkewBase, this.base(a), this.m = [1, 0, Math.tan(this.angle.toRadians()), 1, 0, 0]
                }, this.Type.skewX.prototype = new this.Type.SkewBase, this.Type.skewY = function(a) {
                    this.base = c.Type.SkewBase, this.base(a), this.m = [1, Math.tan(this.angle.toRadians()), 0, 1, 0, 0]
                }, this.Type.skewY.prototype = new this.Type.SkewBase, this.transforms = [], this.apply = function(a) {
                    for (var b = 0; b < this.transforms.length; b++) this.transforms[b].apply(a)
                }, this.unapply = function(a) {
                    for (var b = this.transforms.length - 1; b >= 0; b--) this.transforms[b].unapply(a)
                }, this.applyToPoint = function(a) {
                    for (var b = 0; b < this.transforms.length; b++) this.transforms[b].applyToPoint(a)
                };
                for (var d = a.trim(a.compressSpaces(b)).replace(/\)(\s?,\s?)/g, ") ").split(/\s(?=[a-z])/), e = 0; e < d.length; e++) {
                    var f = a.trim(d[e].split("(")[0]),
                        g = d[e].split("(")[1].replace(")", ""),
                        h = new this.Type[f](g);
                    h.type = f, this.transforms.push(h)
                }
            }, a.AspectRatio = function(b, c, d, e, f, g, h, i, j, k) {
                c = a.compressSpaces(c), c = c.replace(/^defer\s/, "");
                var l = c.split(" ")[0] || "xMidYMid",
                    m = c.split(" ")[1] || "meet",
                    n = d / e,
                    o = f / g,
                    p = Math.min(n, o),
                    q = Math.max(n, o);
                "meet" == m && (e *= p, g *= p), "slice" == m && (e *= q, g *= q), j = new a.Property("refX", j), k = new a.Property("refY", k), j.hasValue() && k.hasValue() ? b.translate(-p * j.toPixels("x"), -p * k.toPixels("y")) : (l.match(/^xMid/) && ("meet" == m && p == o || "slice" == m && q == o) && b.translate(d / 2 - e / 2, 0), l.match(/YMid$/) && ("meet" == m && p == n || "slice" == m && q == n) && b.translate(0, f / 2 - g / 2), l.match(/^xMax/) && ("meet" == m && p == o || "slice" == m && q == o) && b.translate(d - e, 0), l.match(/YMax$/) && ("meet" == m && p == n || "slice" == m && q == n) && b.translate(0, f - g)), "none" == l ? b.scale(n, o) : "meet" == m ? b.scale(p, p) : "slice" == m && b.scale(q, q), b.translate(null == h ? 0 : -h, null == i ? 0 : -i)
            }, a.Element = {}, a.EmptyProperty = new a.Property("EMPTY", ""), a.Element.ElementBase = function(b) {
                if (this.attributes = {}, this.styles = {}, this.children = [], this.attribute = function(b, c) {
                        var d = this.attributes[b];
                        return null != d ? d : (1 == c && (d = new a.Property(b, ""), this.attributes[b] = d), d || a.EmptyProperty)
                    }, this.getHrefAttribute = function() {
                        for (var b in this.attributes)
                            if (b.match(/:href$/)) return this.attributes[b];
                        return a.EmptyProperty
                    }, this.style = function(b, c) {
                        var d = this.styles[b];
                        if (null != d) return d;
                        var e = this.attribute(b);
                        if (null != e && e.hasValue()) return this.styles[b] = e, e;
                        var f = this.parent;
                        if (null != f) {
                            var g = f.style(b);
                            if (null != g && g.hasValue()) return g
                        }
                        return 1 == c && (d = new a.Property(b, ""), this.styles[b] = d), d || a.EmptyProperty
                    }, this.render = function(a) {
                        if ("none" != this.style("display").value && "hidden" != this.attribute("visibility").value) {
                            if (a.save(), this.attribute("mask").hasValue()) {
                                var b = this.attribute("mask").getDefinition();
                                null != b && b.apply(a, this)
                            } else if (this.style("filter").hasValue()) {
                                var c = this.style("filter").getDefinition();
                                null != c && c.apply(a, this)
                            } else this.setContext(a), this.renderChildren(a), this.clearContext(a);
                            a.restore()
                        }
                    }, this.setContext = function(a) {}, this.clearContext = function(a) {}, this.renderChildren = function(a) {
                        for (var b = 0; b < this.children.length; b++) this.children[b].render(a)
                    }, this.addChild = function(b, c) {
                        var d = b;
                        c && (d = a.CreateElement(b)), d.parent = this, this.children.push(d)
                    }, null != b && 1 == b.nodeType) {
                    for (var c = 0; c < b.childNodes.length; c++) {
                        var d = b.childNodes[c];
                        if (1 == d.nodeType && this.addChild(d, !0), this.captureTextNodes && 3 == d.nodeType) {
                            var e = d.nodeValue || d.text || "";
                            "" != a.trim(a.compressSpaces(e)) && this.addChild(new a.Element.tspan(d), !1)
                        }
                    }
                    for (var c = 0; c < b.attributes.length; c++) {
                        var f = b.attributes[c];
                        this.attributes[f.nodeName] = new a.Property(f.nodeName, f.nodeValue)
                    }
                    var g = a.Styles[b.nodeName];
                    if (null != g)
                        for (var h in g) this.styles[h] = g[h];
                    if (this.attribute("class").hasValue())
                        for (var i = a.compressSpaces(this.attribute("class").value).split(" "), j = 0; j < i.length; j++) {
                            if (g = a.Styles["." + i[j]], null != g)
                                for (var h in g) this.styles[h] = g[h];
                            if (g = a.Styles[b.nodeName + "." + i[j]], null != g)
                                for (var h in g) this.styles[h] = g[h]
                        }
                    if (this.attribute("id").hasValue()) {
                        var g = a.Styles["#" + this.attribute("id").value];
                        if (null != g)
                            for (var h in g) this.styles[h] = g[h]
                    }
                    if (this.attribute("style").hasValue())
                        for (var g = this.attribute("style").value.split(";"), c = 0; c < g.length; c++)
                            if ("" != a.trim(g[c])) {
                                var k = g[c].split(":"),
                                    h = a.trim(k[0]),
                                    l = a.trim(k[1]);
                                this.styles[h] = new a.Property(h, l)
                            }
                    this.attribute("id").hasValue() && null == a.Definitions[this.attribute("id").value] && (a.Definitions[this.attribute("id").value] = this)
                }
            }, a.Element.RenderedElementBase = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.setContext = function(b) {
                    if (this.style("fill").isUrlDefinition()) {
                        var c = this.style("fill").getFillStyleDefinition(this, this.style("fill-opacity"));
                        null != c && (b.fillStyle = c)
                    } else if (this.style("fill").hasValue()) {
                        var d = this.style("fill");
                        "currentColor" == d.value && (d.value = this.style("color").value), b.fillStyle = "none" == d.value ? "rgba(0,0,0,0)" : d.value
                    }
                    if (this.style("fill-opacity").hasValue()) {
                        var d = new a.Property("fill", b.fillStyle);
                        d = d.addOpacity(this.style("fill-opacity").value), b.fillStyle = d.value
                    }
                    if (this.style("stroke").isUrlDefinition()) {
                        var c = this.style("stroke").getFillStyleDefinition(this, this.style("stroke-opacity"));
                        null != c && (b.strokeStyle = c)
                    } else if (this.style("stroke").hasValue()) {
                        var e = this.style("stroke");
                        "currentColor" == e.value && (e.value = this.style("color").value), b.strokeStyle = "none" == e.value ? "rgba(0,0,0,0)" : e.value
                    }
                    if (this.style("stroke-opacity").hasValue()) {
                        var e = new a.Property("stroke", b.strokeStyle);
                        e = e.addOpacity(this.style("stroke-opacity").value), b.strokeStyle = e.value
                    }
                    if (this.style("stroke-width").hasValue()) {
                        var f = this.style("stroke-width").toPixels();
                        b.lineWidth = 0 == f ? .001 : f
                    }
                    if (this.style("stroke-linecap").hasValue() && (b.lineCap = this.style("stroke-linecap").value), this.style("stroke-linejoin").hasValue() && (b.lineJoin = this.style("stroke-linejoin").value), this.style("stroke-miterlimit").hasValue() && (b.miterLimit = this.style("stroke-miterlimit").value), this.style("stroke-dasharray").hasValue()) {
                        var g = a.ToNumberArray(this.style("stroke-dasharray").value);
                        "undefined" != typeof b.setLineDash ? b.setLineDash(g) : "undefined" != typeof b.webkitLineDash ? b.webkitLineDash = g : "undefined" != typeof b.mozDash && (b.mozDash = g);
                        var h = this.style("stroke-dashoffset").numValueOrDefault(1);
                        "undefined" != typeof b.lineDashOffset ? b.lineDashOffset = h : "undefined" != typeof b.webkitLineDashOffset ? b.webkitLineDashOffset = h : "undefined" != typeof b.mozDashOffset && (b.mozDashOffset = h)
                    }
                    if ("undefined" != typeof b.font && (b.font = a.Font.CreateFont(this.style("font-style").value, this.style("font-variant").value, this.style("font-weight").value, this.style("font-size").hasValue() ? this.style("font-size").toPixels() + "px" : "", this.style("font-family").value).toString()), this.attribute("transform").hasValue()) {
                        var i = new a.Transform(this.attribute("transform").value);
                        i.apply(b)
                    }
                    if (this.style("clip-path").hasValue()) {
                        var j = this.style("clip-path").getDefinition();
                        null != j && j.apply(b)
                    }
                    this.style("opacity").hasValue() && (b.globalAlpha = this.style("opacity").numValue())
                }
            }, a.Element.RenderedElementBase.prototype = new a.Element.ElementBase, a.Element.PathElementBase = function(b) {
                this.base = a.Element.RenderedElementBase, this.base(b), this.path = function(b) {
                    return null != b && b.beginPath(), new a.BoundingBox
                }, this.renderChildren = function(b) {
                    this.path(b), a.Mouse.checkPath(this, b), "" != b.fillStyle && (this.attribute("fill-rule").hasValue() ? b.fill(this.attribute("fill-rule").value) : b.fill()), "" != b.strokeStyle && b.stroke();
                    var c = this.getMarkers();
                    if (null != c) {
                        if (this.style("marker-start").isUrlDefinition()) {
                            var d = this.style("marker-start").getDefinition();
                            d.render(b, c[0][0], c[0][1])
                        }
                        if (this.style("marker-mid").isUrlDefinition())
                            for (var d = this.style("marker-mid").getDefinition(), e = 1; e < c.length - 1; e++) d.render(b, c[e][0], c[e][1]);
                        if (this.style("marker-end").isUrlDefinition()) {
                            var d = this.style("marker-end").getDefinition();
                            d.render(b, c[c.length - 1][0], c[c.length - 1][1])
                        }
                    }
                }, this.getBoundingBox = function() {
                    return this.path()
                }, this.getMarkers = function() {
                    return null
                }
            }, a.Element.PathElementBase.prototype = new a.Element.RenderedElementBase, a.Element.svg = function(b) {
                this.base = a.Element.RenderedElementBase, this.base(b), this.baseClearContext = this.clearContext, this.clearContext = function(b) {
                    this.baseClearContext(b), a.ViewPort.RemoveCurrent()
                }, this.baseSetContext = this.setContext, this.setContext = function(b) {
                    b.strokeStyle = "rgba(0,0,0,0)", b.lineCap = "butt", b.lineJoin = "miter", b.miterLimit = 4, this.baseSetContext(b), this.attribute("x").hasValue() || (this.attribute("x", !0).value = 0), this.attribute("y").hasValue() || (this.attribute("y", !0).value = 0), b.translate(this.attribute("x").toPixels("x"), this.attribute("y").toPixels("y"));
                    var c = a.ViewPort.width(),
                        d = a.ViewPort.height();
                    if (this.attribute("width").hasValue() || (this.attribute("width", !0).value = "100%"), this.attribute("height").hasValue() || (this.attribute("height", !0).value = "100%"), "undefined" == typeof this.root) {
                        c = this.attribute("width").toPixels("x"), d = this.attribute("height").toPixels("y");
                        var e = 0,
                            f = 0;
                        this.attribute("refX").hasValue() && this.attribute("refY").hasValue() && (e = -this.attribute("refX").toPixels("x"), f = -this.attribute("refY").toPixels("y")), b.beginPath(), b.moveTo(e, f), b.lineTo(c, f), b.lineTo(c, d), b.lineTo(e, d), b.closePath(), b.clip()
                    }
                    if (a.ViewPort.SetCurrent(c, d), this.attribute("viewBox").hasValue()) {
                        var g = a.ToNumberArray(this.attribute("viewBox").value),
                            h = g[0],
                            i = g[1];
                        c = g[2], d = g[3], a.AspectRatio(b, this.attribute("preserveAspectRatio").value, a.ViewPort.width(), c, a.ViewPort.height(), d, h, i, this.attribute("refX").value, this.attribute("refY").value), a.ViewPort.RemoveCurrent(), a.ViewPort.SetCurrent(g[2], g[3])
                    }
                }
            }, a.Element.svg.prototype = new a.Element.RenderedElementBase, a.Element.rect = function(b) {
                this.base = a.Element.PathElementBase, this.base(b), this.path = function(b) {
                    var c = this.attribute("x").toPixels("x"),
                        d = this.attribute("y").toPixels("y"),
                        e = this.attribute("width").toPixels("x"),
                        f = this.attribute("height").toPixels("y"),
                        g = this.attribute("rx").toPixels("x"),
                        h = this.attribute("ry").toPixels("y");
                    return this.attribute("rx").hasValue() && !this.attribute("ry").hasValue() && (h = g), this.attribute("ry").hasValue() && !this.attribute("rx").hasValue() && (g = h), g = Math.min(g, e / 2), h = Math.min(h, f / 2), null != b && (b.beginPath(), b.moveTo(c + g, d), b.lineTo(c + e - g, d), b.quadraticCurveTo(c + e, d, c + e, d + h), b.lineTo(c + e, d + f - h), b.quadraticCurveTo(c + e, d + f, c + e - g, d + f), b.lineTo(c + g, d + f), b.quadraticCurveTo(c, d + f, c, d + f - h), b.lineTo(c, d + h), b.quadraticCurveTo(c, d, c + g, d), b.closePath()), new a.BoundingBox(c, d, c + e, d + f)
                }
            }, a.Element.rect.prototype = new a.Element.PathElementBase, a.Element.circle = function(b) {
                this.base = a.Element.PathElementBase, this.base(b), this.path = function(b) {
                    var c = this.attribute("cx").toPixels("x"),
                        d = this.attribute("cy").toPixels("y"),
                        e = this.attribute("r").toPixels();
                    return null != b && (b.beginPath(), b.arc(c, d, e, 0, 2 * Math.PI, !0), b.closePath()), new a.BoundingBox(c - e, d - e, c + e, d + e)
                }
            }, a.Element.circle.prototype = new a.Element.PathElementBase, a.Element.ellipse = function(b) {
                this.base = a.Element.PathElementBase, this.base(b), this.path = function(b) {
                    var c = 4 * ((Math.sqrt(2) - 1) / 3),
                        d = this.attribute("rx").toPixels("x"),
                        e = this.attribute("ry").toPixels("y"),
                        f = this.attribute("cx").toPixels("x"),
                        g = this.attribute("cy").toPixels("y");
                    return null != b && (b.beginPath(), b.moveTo(f, g - e), b.bezierCurveTo(f + c * d, g - e, f + d, g - c * e, f + d, g), b.bezierCurveTo(f + d, g + c * e, f + c * d, g + e, f, g + e), b.bezierCurveTo(f - c * d, g + e, f - d, g + c * e, f - d, g), b.bezierCurveTo(f - d, g - c * e, f - c * d, g - e, f, g - e), b.closePath()), new a.BoundingBox(f - d, g - e, f + d, g + e)
                }
            }, a.Element.ellipse.prototype = new a.Element.PathElementBase, a.Element.line = function(b) {
                this.base = a.Element.PathElementBase, this.base(b), this.getPoints = function() {
                    return [new a.Point(this.attribute("x1").toPixels("x"), this.attribute("y1").toPixels("y")), new a.Point(this.attribute("x2").toPixels("x"), this.attribute("y2").toPixels("y"))]
                }, this.path = function(b) {
                    var c = this.getPoints();
                    return null != b && (b.beginPath(), b.moveTo(c[0].x, c[0].y), b.lineTo(c[1].x, c[1].y)), new a.BoundingBox(c[0].x, c[0].y, c[1].x, c[1].y)
                }, this.getMarkers = function() {
                    var a = this.getPoints(),
                        b = a[0].angleTo(a[1]);
                    return [
                        [a[0], b],
                        [a[1], b]
                    ]
                }
            }, a.Element.line.prototype = new a.Element.PathElementBase, a.Element.polyline = function(b) {
                this.base = a.Element.PathElementBase, this.base(b), this.points = a.CreatePath(this.attribute("points").value), this.path = function(b) {
                    var c = new a.BoundingBox(this.points[0].x, this.points[0].y);
                    null != b && (b.beginPath(), b.moveTo(this.points[0].x, this.points[0].y));
                    for (var d = 1; d < this.points.length; d++) c.addPoint(this.points[d].x, this.points[d].y), null != b && b.lineTo(this.points[d].x, this.points[d].y);
                    return c
                }, this.getMarkers = function() {
                    for (var a = [], b = 0; b < this.points.length - 1; b++) a.push([this.points[b], this.points[b].angleTo(this.points[b + 1])]);
                    return a.push([this.points[this.points.length - 1], a[a.length - 1][1]]), a
                }
            }, a.Element.polyline.prototype = new a.Element.PathElementBase, a.Element.polygon = function(b) {
                this.base = a.Element.polyline, this.base(b), this.basePath = this.path, this.path = function(a) {
                    var b = this.basePath(a);
                    return null != a && (a.lineTo(this.points[0].x, this.points[0].y), a.closePath()), b
                }
            }, a.Element.polygon.prototype = new a.Element.polyline, a.Element.path = function(b) {
                this.base = a.Element.PathElementBase, this.base(b);
                var c = this.attribute("d").value;
                c = c.replace(/,/gm, " "), c = c.replace(/([MmZzLlHhVvCcSsQqTtAa])([MmZzLlHhVvCcSsQqTtAa])/gm, "$1 $2"), c = c.replace(/([MmZzLlHhVvCcSsQqTtAa])([MmZzLlHhVvCcSsQqTtAa])/gm, "$1 $2"), c = c.replace(/([MmZzLlHhVvCcSsQqTtAa])([^\s])/gm, "$1 $2"), c = c.replace(/([^\s])([MmZzLlHhVvCcSsQqTtAa])/gm, "$1 $2"), c = c.replace(/([0-9])([+\-])/gm, "$1 $2"), c = c.replace(/(\.[0-9]*)(\.)/gm, "$1 $2"), c = c.replace(/([Aa](\s+[0-9]+){3})\s+([01])\s*([01])/gm, "$1 $3 $4 "), c = a.compressSpaces(c), c = a.trim(c), this.PathParser = new function(b) {
                    this.tokens = b.split(" "), this.reset = function() {
                        this.i = -1, this.command = "", this.previousCommand = "", this.start = new a.Point(0, 0), this.control = new a.Point(0, 0), this.current = new a.Point(0, 0), this.points = [], this.angles = []
                    }, this.isEnd = function() {
                        return this.i >= this.tokens.length - 1
                    }, this.isCommandOrEnd = function() {
                        return !!this.isEnd() || null != this.tokens[this.i + 1].match(/^[A-Za-z]$/)
                    }, this.isRelativeCommand = function() {
                        switch (this.command) {
                            case "m":
                            case "l":
                            case "h":
                            case "v":
                            case "c":
                            case "s":
                            case "q":
                            case "t":
                            case "a":
                            case "z":
                                return !0
                        }
                        return !1
                    }, this.getToken = function() {
                        return this.i++, this.tokens[this.i]
                    }, this.getScalar = function() {
                        return parseFloat(this.getToken())
                    }, this.nextCommand = function() {
                        this.previousCommand = this.command, this.command = this.getToken()
                    }, this.getPoint = function() {
                        var b = new a.Point(this.getScalar(), this.getScalar());
                        return this.makeAbsolute(b)
                    }, this.getAsControlPoint = function() {
                        var a = this.getPoint();
                        return this.control = a, a
                    }, this.getAsCurrentPoint = function() {
                        var a = this.getPoint();
                        return this.current = a, a
                    }, this.getReflectedControlPoint = function() {
                        if ("c" != this.previousCommand.toLowerCase() && "s" != this.previousCommand.toLowerCase() && "q" != this.previousCommand.toLowerCase() && "t" != this.previousCommand.toLowerCase()) return this.current;
                        var b = new a.Point(2 * this.current.x - this.control.x, 2 * this.current.y - this.control.y);
                        return b
                    }, this.makeAbsolute = function(a) {
                        return this.isRelativeCommand() && (a.x += this.current.x, a.y += this.current.y), a
                    }, this.addMarker = function(a, b, c) {
                        null != c && this.angles.length > 0 && null == this.angles[this.angles.length - 1] && (this.angles[this.angles.length - 1] = this.points[this.points.length - 1].angleTo(c)), this.addMarkerAngle(a, null == b ? null : b.angleTo(a))
                    }, this.addMarkerAngle = function(a, b) {
                        this.points.push(a), this.angles.push(b)
                    }, this.getMarkerPoints = function() {
                        return this.points
                    }, this.getMarkerAngles = function() {
                        for (var a = 0; a < this.angles.length; a++)
                            if (null == this.angles[a])
                                for (var b = a + 1; b < this.angles.length; b++)
                                    if (null != this.angles[b]) {
                                        this.angles[a] = this.angles[b];
                                        break
                                    }
                        return this.angles
                    }
                }(c), this.path = function(b) {
                    var c = this.PathParser;
                    c.reset();
                    var d = new a.BoundingBox;
                    for (null != b && b.beginPath(); !c.isEnd();) switch (c.nextCommand(), c.command) {
                        case "M":
                        case "m":
                            var e = c.getAsCurrentPoint();
                            for (c.addMarker(e), d.addPoint(e.x, e.y), null != b && b.moveTo(e.x, e.y), c.start = c.current; !c.isCommandOrEnd();) {
                                var e = c.getAsCurrentPoint();
                                c.addMarker(e, c.start), d.addPoint(e.x, e.y), null != b && b.lineTo(e.x, e.y)
                            }
                            break;
                        case "L":
                        case "l":
                            for (; !c.isCommandOrEnd();) {
                                var f = c.current,
                                    e = c.getAsCurrentPoint();
                                c.addMarker(e, f), d.addPoint(e.x, e.y), null != b && b.lineTo(e.x, e.y)
                            }
                            break;
                        case "H":
                        case "h":
                            for (; !c.isCommandOrEnd();) {
                                var g = new a.Point((c.isRelativeCommand() ? c.current.x : 0) + c.getScalar(), c.current.y);
                                c.addMarker(g, c.current), c.current = g, d.addPoint(c.current.x, c.current.y), null != b && b.lineTo(c.current.x, c.current.y)
                            }
                            break;
                        case "V":
                        case "v":
                            for (; !c.isCommandOrEnd();) {
                                var g = new a.Point(c.current.x, (c.isRelativeCommand() ? c.current.y : 0) + c.getScalar());
                                c.addMarker(g, c.current), c.current = g, d.addPoint(c.current.x, c.current.y), null != b && b.lineTo(c.current.x, c.current.y)
                            }
                            break;
                        case "C":
                        case "c":
                            for (; !c.isCommandOrEnd();) {
                                var h = c.current,
                                    i = c.getPoint(),
                                    j = c.getAsControlPoint(),
                                    k = c.getAsCurrentPoint();
                                c.addMarker(k, j, i), d.addBezierCurve(h.x, h.y, i.x, i.y, j.x, j.y, k.x, k.y), null != b && b.bezierCurveTo(i.x, i.y, j.x, j.y, k.x, k.y)
                            }
                            break;
                        case "S":
                        case "s":
                            for (; !c.isCommandOrEnd();) {
                                var h = c.current,
                                    i = c.getReflectedControlPoint(),
                                    j = c.getAsControlPoint(),
                                    k = c.getAsCurrentPoint();
                                c.addMarker(k, j, i), d.addBezierCurve(h.x, h.y, i.x, i.y, j.x, j.y, k.x, k.y), null != b && b.bezierCurveTo(i.x, i.y, j.x, j.y, k.x, k.y)
                            }
                            break;
                        case "Q":
                        case "q":
                            for (; !c.isCommandOrEnd();) {
                                var h = c.current,
                                    j = c.getAsControlPoint(),
                                    k = c.getAsCurrentPoint();
                                c.addMarker(k, j, j), d.addQuadraticCurve(h.x, h.y, j.x, j.y, k.x, k.y), null != b && b.quadraticCurveTo(j.x, j.y, k.x, k.y)
                            }
                            break;
                        case "T":
                        case "t":
                            for (; !c.isCommandOrEnd();) {
                                var h = c.current,
                                    j = c.getReflectedControlPoint();
                                c.control = j;
                                var k = c.getAsCurrentPoint();
                                c.addMarker(k, j, j), d.addQuadraticCurve(h.x, h.y, j.x, j.y, k.x, k.y), null != b && b.quadraticCurveTo(j.x, j.y, k.x, k.y)
                            }
                            break;
                        case "A":
                        case "a":
                            for (; !c.isCommandOrEnd();) {
                                var h = c.current,
                                    l = c.getScalar(),
                                    m = c.getScalar(),
                                    n = c.getScalar() * (Math.PI / 180),
                                    o = c.getScalar(),
                                    p = c.getScalar(),
                                    k = c.getAsCurrentPoint(),
                                    q = new a.Point(Math.cos(n) * (h.x - k.x) / 2 + Math.sin(n) * (h.y - k.y) / 2, -Math.sin(n) * (h.x - k.x) / 2 + Math.cos(n) * (h.y - k.y) / 2),
                                    r = Math.pow(q.x, 2) / Math.pow(l, 2) + Math.pow(q.y, 2) / Math.pow(m, 2);
                                r > 1 && (l *= Math.sqrt(r), m *= Math.sqrt(r));
                                var s = (o == p ? -1 : 1) * Math.sqrt((Math.pow(l, 2) * Math.pow(m, 2) - Math.pow(l, 2) * Math.pow(q.y, 2) - Math.pow(m, 2) * Math.pow(q.x, 2)) / (Math.pow(l, 2) * Math.pow(q.y, 2) + Math.pow(m, 2) * Math.pow(q.x, 2)));
                                isNaN(s) && (s = 0);
                                var t = new a.Point(s * l * q.y / m, s * -m * q.x / l),
                                    u = new a.Point((h.x + k.x) / 2 + Math.cos(n) * t.x - Math.sin(n) * t.y, (h.y + k.y) / 2 + Math.sin(n) * t.x + Math.cos(n) * t.y),
                                    v = function(a) {
                                        return Math.sqrt(Math.pow(a[0], 2) + Math.pow(a[1], 2))
                                    },
                                    w = function(a, b) {
                                        return (a[0] * b[0] + a[1] * b[1]) / (v(a) * v(b))
                                    },
                                    x = function(a, b) {
                                        return (a[0] * b[1] < a[1] * b[0] ? -1 : 1) * Math.acos(w(a, b))
                                    },
                                    y = x([1, 0], [(q.x - t.x) / l, (q.y - t.y) / m]),
                                    z = [(q.x - t.x) / l, (q.y - t.y) / m],
                                    A = [(-q.x - t.x) / l, (-q.y - t.y) / m],
                                    B = x(z, A);
                                w(z, A) <= -1 && (B = Math.PI), w(z, A) >= 1 && (B = 0);
                                var C = 1 - p ? 1 : -1,
                                    D = y + C * (B / 2),
                                    E = new a.Point(u.x + l * Math.cos(D), u.y + m * Math.sin(D));
                                if (c.addMarkerAngle(E, D - C * Math.PI / 2), c.addMarkerAngle(k, D - C * Math.PI), d.addPoint(k.x, k.y), null != b) {
                                    var w = l > m ? l : m,
                                        F = l > m ? 1 : l / m,
                                        G = l > m ? m / l : 1;
                                    b.translate(u.x, u.y), b.rotate(n), b.scale(F, G), b.arc(0, 0, w, y, y + B, 1 - p), b.scale(1 / F, 1 / G), b.rotate(-n), b.translate(-u.x, -u.y)
                                }
                            }
                            break;
                        case "Z":
                        case "z":
                            null != b && b.closePath(), c.current = c.start
                    }
                    return d
                }, this.getMarkers = function() {
                    for (var a = this.PathParser.getMarkerPoints(), b = this.PathParser.getMarkerAngles(), c = [], d = 0; d < a.length; d++) c.push([a[d], b[d]]);
                    return c
                }
            }, a.Element.path.prototype = new a.Element.PathElementBase, a.Element.pattern = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.createPattern = function(b, c) {
                    var d = this.attribute("width").toPixels("x", !0),
                        e = this.attribute("height").toPixels("y", !0),
                        f = new a.Element.svg;
                    f.attributes.viewBox = new a.Property("viewBox", this.attribute("viewBox").value), f.attributes.width = new a.Property("width", d + "px"), f.attributes.height = new a.Property("height", e + "px"), f.attributes.transform = new a.Property("transform", this.attribute("patternTransform").value), f.children = this.children;
                    var g = document.createElement("canvas");
                    g.width = d, g.height = e;
                    var h = g.getContext("2d");
                    this.attribute("x").hasValue() && this.attribute("y").hasValue() && h.translate(this.attribute("x").toPixels("x", !0), this.attribute("y").toPixels("y", !0));
                    for (var i = -1; i <= 1; i++)
                        for (var j = -1; j <= 1; j++) h.save(), h.translate(i * g.width, j * g.height), f.render(h), h.restore();
                    var k = b.createPattern(g, "repeat");
                    return k
                }
            }, a.Element.pattern.prototype = new a.Element.ElementBase, a.Element.marker = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.baseRender = this.render, this.render = function(b, c, d) {
                    b.translate(c.x, c.y), "auto" == this.attribute("orient").valueOrDefault("auto") && b.rotate(d), "strokeWidth" == this.attribute("markerUnits").valueOrDefault("strokeWidth") && b.scale(b.lineWidth, b.lineWidth), b.save();
                    var e = new a.Element.svg;
                    e.attributes.viewBox = new a.Property("viewBox", this.attribute("viewBox").value), e.attributes.refX = new a.Property("refX", this.attribute("refX").value), e.attributes.refY = new a.Property("refY", this.attribute("refY").value), e.attributes.width = new a.Property("width", this.attribute("markerWidth").value), e.attributes.height = new a.Property("height", this.attribute("markerHeight").value), e.attributes.fill = new a.Property("fill", this.attribute("fill").valueOrDefault("black")), e.attributes.stroke = new a.Property("stroke", this.attribute("stroke").valueOrDefault("none")), e.children = this.children, e.render(b), b.restore(), "strokeWidth" == this.attribute("markerUnits").valueOrDefault("strokeWidth") && b.scale(1 / b.lineWidth, 1 / b.lineWidth), "auto" == this.attribute("orient").valueOrDefault("auto") && b.rotate(-d), b.translate(-c.x, -c.y)
                }
            }, a.Element.marker.prototype = new a.Element.ElementBase, a.Element.defs = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.render = function(a) {}
            }, a.Element.defs.prototype = new a.Element.ElementBase, a.Element.GradientBase = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.gradientUnits = this.attribute("gradientUnits").valueOrDefault("objectBoundingBox"), this.stops = [];
                for (var c = 0; c < this.children.length; c++) {
                    var d = this.children[c];
                    "stop" == d.type && this.stops.push(d)
                }
                this.getGradient = function() {}, this.createGradient = function(b, c, d) {
                    var e = this;
                    this.getHrefAttribute().hasValue() && (e = this.getHrefAttribute().getDefinition());
                    var f = function(b) {
                            if (d.hasValue()) {
                                var c = new a.Property("color", b);
                                return c.addOpacity(d.value).value
                            }
                            return b
                        },
                        g = this.getGradient(b, c);
                    if (null == g) return f(e.stops[e.stops.length - 1].color);
                    for (var h = 0; h < e.stops.length; h++) g.addColorStop(e.stops[h].offset, f(e.stops[h].color));
                    if (this.attribute("gradientTransform").hasValue()) {
                        var i = a.ViewPort.viewPorts[0],
                            j = new a.Element.rect;
                        j.attributes.x = new a.Property("x", -a.MAX_VIRTUAL_PIXELS / 3), j.attributes.y = new a.Property("y", -a.MAX_VIRTUAL_PIXELS / 3), j.attributes.width = new a.Property("width", a.MAX_VIRTUAL_PIXELS), j.attributes.height = new a.Property("height", a.MAX_VIRTUAL_PIXELS);
                        var k = new a.Element.g;
                        k.attributes.transform = new a.Property("transform", this.attribute("gradientTransform").value), k.children = [j];
                        var l = new a.Element.svg;
                        l.attributes.x = new a.Property("x", 0), l.attributes.y = new a.Property("y", 0), l.attributes.width = new a.Property("width", i.width), l.attributes.height = new a.Property("height", i.height), l.children = [k];
                        var m = document.createElement("canvas");
                        m.width = i.width, m.height = i.height;
                        var n = m.getContext("2d");
                        return n.fillStyle = g, l.render(n), n.createPattern(m, "no-repeat")
                    }
                    return g
                }
            }, a.Element.GradientBase.prototype = new a.Element.ElementBase, a.Element.linearGradient = function(b) {
                this.base = a.Element.GradientBase, this.base(b), this.getGradient = function(a, b) {
                    var c = b.getBoundingBox();
                    this.attribute("x1").hasValue() || this.attribute("y1").hasValue() || this.attribute("x2").hasValue() || this.attribute("y2").hasValue() || (this.attribute("x1", !0).value = 0, this.attribute("y1", !0).value = 0, this.attribute("x2", !0).value = 1, this.attribute("y2", !0).value = 0);
                    var d = "objectBoundingBox" == this.gradientUnits ? c.x() + c.width() * this.attribute("x1").numValue() : this.attribute("x1").toPixels("x"),
                        e = "objectBoundingBox" == this.gradientUnits ? c.y() + c.height() * this.attribute("y1").numValue() : this.attribute("y1").toPixels("y"),
                        f = "objectBoundingBox" == this.gradientUnits ? c.x() + c.width() * this.attribute("x2").numValue() : this.attribute("x2").toPixels("x"),
                        g = "objectBoundingBox" == this.gradientUnits ? c.y() + c.height() * this.attribute("y2").numValue() : this.attribute("y2").toPixels("y");
                    return d == f && e == g ? null : a.createLinearGradient(d, e, f, g)
                }
            }, a.Element.linearGradient.prototype = new a.Element.GradientBase, a.Element.radialGradient = function(b) {
                this.base = a.Element.GradientBase, this.base(b), this.getGradient = function(a, b) {
                    var c = b.getBoundingBox();
                    this.attribute("cx").hasValue() || (this.attribute("cx", !0).value = "50%"), this.attribute("cy").hasValue() || (this.attribute("cy", !0).value = "50%"), this.attribute("r").hasValue() || (this.attribute("r", !0).value = "50%");
                    var d = "objectBoundingBox" == this.gradientUnits ? c.x() + c.width() * this.attribute("cx").numValue() : this.attribute("cx").toPixels("x"),
                        e = "objectBoundingBox" == this.gradientUnits ? c.y() + c.height() * this.attribute("cy").numValue() : this.attribute("cy").toPixels("y"),
                        f = d,
                        g = e;
                    this.attribute("fx").hasValue() && (f = "objectBoundingBox" == this.gradientUnits ? c.x() + c.width() * this.attribute("fx").numValue() : this.attribute("fx").toPixels("x")), this.attribute("fy").hasValue() && (g = "objectBoundingBox" == this.gradientUnits ? c.y() + c.height() * this.attribute("fy").numValue() : this.attribute("fy").toPixels("y"));
                    var h = "objectBoundingBox" == this.gradientUnits ? (c.width() + c.height()) / 2 * this.attribute("r").numValue() : this.attribute("r").toPixels();
                    return a.createRadialGradient(f, g, 0, d, e, h)
                }
            }, a.Element.radialGradient.prototype = new a.Element.GradientBase, a.Element.stop = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.offset = this.attribute("offset").numValue(), this.offset < 0 && (this.offset = 0), this.offset > 1 && (this.offset = 1);
                var c = this.style("stop-color");
                this.style("stop-opacity").hasValue() && (c = c.addOpacity(this.style("stop-opacity").value)), this.color = c.value
            }, a.Element.stop.prototype = new a.Element.ElementBase, a.Element.AnimateBase = function(b) {
                this.base = a.Element.ElementBase, this.base(b), a.Animations.push(this), this.duration = 0, this.begin = this.attribute("begin").toMilliseconds(), this.maxDuration = this.begin + this.attribute("dur").toMilliseconds(), this.getProperty = function() {
                    var a = this.attribute("attributeType").value,
                        b = this.attribute("attributeName").value;
                    return "CSS" == a ? this.parent.style(b, !0) : this.parent.attribute(b, !0)
                }, this.initialValue = null, this.initialUnits = "", this.removed = !1, this.calcValue = function() {
                    return ""
                }, this.update = function(a) {
                    if (null == this.initialValue && (this.initialValue = this.getProperty().value, this.initialUnits = this.getProperty().getUnits()), this.duration > this.maxDuration) {
                        if ("indefinite" != this.attribute("repeatCount").value && "indefinite" != this.attribute("repeatDur").value) return "remove" == this.attribute("fill").valueOrDefault("remove") && !this.removed && (this.removed = !0, this.getProperty().value = this.initialValue, !0);
                        this.duration = 0
                    }
                    this.duration = this.duration + a;
                    var b = !1;
                    if (this.begin < this.duration) {
                        var c = this.calcValue();
                        if (this.attribute("type").hasValue()) {
                            var d = this.attribute("type").value;
                            c = d + "(" + c + ")"
                        }
                        this.getProperty().value = c, b = !0
                    }
                    return b
                }, this.from = this.attribute("from"), this.to = this.attribute("to"), this.values = this.attribute("values"), this.values.hasValue() && (this.values.value = this.values.value.split(";")), this.progress = function() {
                    var b = {
                        progress: (this.duration - this.begin) / (this.maxDuration - this.begin)
                    };
                    if (this.values.hasValue()) {
                        var c = b.progress * (this.values.value.length - 1),
                            d = Math.floor(c),
                            e = Math.ceil(c);
                        b.from = new a.Property("from", parseFloat(this.values.value[d])), b.to = new a.Property("to", parseFloat(this.values.value[e])), b.progress = (c - d) / (e - d)
                    } else b.from = this.from, b.to = this.to;
                    return b
                }
            }, a.Element.AnimateBase.prototype = new a.Element.ElementBase, a.Element.animate = function(b) {
                this.base = a.Element.AnimateBase, this.base(b), this.calcValue = function() {
                    var a = this.progress(),
                        b = a.from.numValue() + (a.to.numValue() - a.from.numValue()) * a.progress;
                    return b + this.initialUnits
                }
            }, a.Element.animate.prototype = new a.Element.AnimateBase, a.Element.animateColor = function(b) {
                this.base = a.Element.AnimateBase, this.base(b), this.calcValue = function() {
                    var a = this.progress(),
                        b = new RGBColor(a.from.value),
                        c = new RGBColor(a.to.value);
                    if (b.ok && c.ok) {
                        var d = b.r + (c.r - b.r) * a.progress,
                            e = b.g + (c.g - b.g) * a.progress,
                            f = b.b + (c.b - b.b) * a.progress;
                        return "rgb(" + parseInt(d, 10) + "," + parseInt(e, 10) + "," + parseInt(f, 10) + ")"
                    }
                    return this.attribute("from").value
                }
            }, a.Element.animateColor.prototype = new a.Element.AnimateBase, a.Element.animateTransform = function(b) {
                this.base = a.Element.AnimateBase, this.base(b), this.calcValue = function() {
                    for (var b = this.progress(), c = a.ToNumberArray(b.from.value), d = a.ToNumberArray(b.to.value), e = "", f = 0; f < c.length; f++) e += c[f] + (d[f] - c[f]) * b.progress + " ";
                    return e
                }
            }, a.Element.animateTransform.prototype = new a.Element.animate, a.Element.font = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.horizAdvX = this.attribute("horiz-adv-x").numValue(), this.isRTL = !1, this.isArabic = !1, this.fontFace = null, this.missingGlyph = null, this.glyphs = [];
                for (var c = 0; c < this.children.length; c++) {
                    var d = this.children[c];
                    "font-face" == d.type ? (this.fontFace = d, d.style("font-family").hasValue() && (a.Definitions[d.style("font-family").value] = this)) : "missing-glyph" == d.type ? this.missingGlyph = d : "glyph" == d.type && ("" != d.arabicForm ? (this.isRTL = !0, this.isArabic = !0, "undefined" == typeof this.glyphs[d.unicode] && (this.glyphs[d.unicode] = []), this.glyphs[d.unicode][d.arabicForm] = d) : this.glyphs[d.unicode] = d)
                }
            }, a.Element.font.prototype = new a.Element.ElementBase, a.Element.fontface = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.ascent = this.attribute("ascent").value, this.descent = this.attribute("descent").value, this.unitsPerEm = this.attribute("units-per-em").numValue()
            }, a.Element.fontface.prototype = new a.Element.ElementBase, a.Element.missingglyph = function(b) {
                this.base = a.Element.path, this.base(b), this.horizAdvX = 0
            }, a.Element.missingglyph.prototype = new a.Element.path, a.Element.glyph = function(b) {
                this.base = a.Element.path, this.base(b), this.horizAdvX = this.attribute("horiz-adv-x").numValue(), this.unicode = this.attribute("unicode").value, this.arabicForm = this.attribute("arabic-form").value
            }, a.Element.glyph.prototype = new a.Element.path, a.Element.text = function(b) {
                this.captureTextNodes = !0, this.base = a.Element.RenderedElementBase, this.base(b), this.baseSetContext = this.setContext, this.setContext = function(a) {
                    this.baseSetContext(a), this.style("dominant-baseline").hasValue() && (a.textBaseline = this.style("dominant-baseline").value), this.style("alignment-baseline").hasValue() && (a.textBaseline = this.style("alignment-baseline").value)
                }, this.getBoundingBox = function() {
                    return new a.BoundingBox(this.attribute("x").toPixels("x"), this.attribute("y").toPixels("y"), 0, 0)
                }, this.renderChildren = function(a) {
                    this.x = this.attribute("x").toPixels("x"), this.y = this.attribute("y").toPixels("y"), this.x += this.getAnchorDelta(a, this, 0);
                    for (var b = 0; b < this.children.length; b++) this.renderChild(a, this, b)
                }, this.getAnchorDelta = function(a, b, c) {
                    var d = this.style("text-anchor").valueOrDefault("start");
                    if ("start" != d) {
                        for (var e = 0, f = c; f < b.children.length; f++) {
                            var g = b.children[f];
                            if (f > c && g.attribute("x").hasValue()) break;
                            e += g.measureTextRecursive(a)
                        }
                        return -1 * ("end" == d ? e : e / 2)
                    }
                    return 0
                }, this.renderChild = function(a, b, c) {
                    var d = b.children[c];
                    d.attribute("x").hasValue() ? d.x = d.attribute("x").toPixels("x") + this.getAnchorDelta(a, b, c) : (this.attribute("dx").hasValue() && (this.x += this.attribute("dx").toPixels("x")), d.attribute("dx").hasValue() && (this.x += d.attribute("dx").toPixels("x")), d.x = this.x), this.x = d.x + d.measureText(a), d.attribute("y").hasValue() ? d.y = d.attribute("y").toPixels("y") : (this.attribute("dy").hasValue() && (this.y += this.attribute("dy").toPixels("y")), d.attribute("dy").hasValue() && (this.y += d.attribute("dy").toPixels("y")), d.y = this.y), this.y = d.y, d.render(a);
                    for (var c = 0; c < d.children.length; c++) this.renderChild(a, d, c)
                }
            }, a.Element.text.prototype = new a.Element.RenderedElementBase, a.Element.TextElementBase = function(b) {
                this.base = a.Element.RenderedElementBase, this.base(b), this.getGlyph = function(a, b, c) {
                    var d = b[c],
                        e = null;
                    if (a.isArabic) {
                        var f = "isolated";
                        (0 == c || " " == b[c - 1]) && c < b.length - 2 && " " != b[c + 1] && (f = "terminal"), c > 0 && " " != b[c - 1] && c < b.length - 2 && " " != b[c + 1] && (f = "medial"), c > 0 && " " != b[c - 1] && (c == b.length - 1 || " " == b[c + 1]) && (f = "initial"), "undefined" != typeof a.glyphs[d] && (e = a.glyphs[d][f], null == e && "glyph" == a.glyphs[d].type && (e = a.glyphs[d]))
                    } else e = a.glyphs[d];
                    return null == e && (e = a.missingGlyph), e
                }, this.renderChildren = function(b) {
                    var c = this.parent.style("font-family").getDefinition();
                    if (null == c) "" != b.fillStyle && b.fillText(a.compressSpaces(this.getText()), this.x, this.y), "" != b.strokeStyle && b.strokeText(a.compressSpaces(this.getText()), this.x, this.y);
                    else {
                        var d = this.parent.style("font-size").numValueOrDefault(a.Font.Parse(a.ctx.font).fontSize),
                            e = this.parent.style("font-style").valueOrDefault(a.Font.Parse(a.ctx.font).fontStyle),
                            f = this.getText();
                        c.isRTL && (f = f.split("").reverse().join(""));
                        for (var g = a.ToNumberArray(this.parent.attribute("dx").value), h = 0; h < f.length; h++) {
                            var i = this.getGlyph(c, f, h),
                                j = d / c.fontFace.unitsPerEm;
                            b.translate(this.x, this.y), b.scale(j, -j);
                            var k = b.lineWidth;
                            b.lineWidth = b.lineWidth * c.fontFace.unitsPerEm / d, "italic" == e && b.transform(1, 0, .4, 1, 0, 0), i.render(b), "italic" == e && b.transform(1, 0, -.4, 1, 0, 0), b.lineWidth = k, b.scale(1 / j, -1 / j), b.translate(-this.x, -this.y), this.x += d * (i.horizAdvX || c.horizAdvX) / c.fontFace.unitsPerEm, "undefined" == typeof g[h] || isNaN(g[h]) || (this.x += g[h])
                        }
                    }
                }, this.getText = function() {}, this.measureTextRecursive = function(a) {
                    for (var b = this.measureText(a), c = 0; c < this.children.length; c++) b += this.children[c].measureTextRecursive(a);
                    return b
                }, this.measureText = function(b) {
                    var c = this.parent.style("font-family").getDefinition();
                    if (null != c) {
                        var d = this.parent.style("font-size").numValueOrDefault(a.Font.Parse(a.ctx.font).fontSize),
                            e = 0,
                            f = this.getText();
                        c.isRTL && (f = f.split("").reverse().join(""));
                        for (var g = a.ToNumberArray(this.parent.attribute("dx").value), h = 0; h < f.length; h++) {
                            var i = this.getGlyph(c, f, h);
                            e += (i.horizAdvX || c.horizAdvX) * d / c.fontFace.unitsPerEm, "undefined" == typeof g[h] || isNaN(g[h]) || (e += g[h])
                        }
                        return e
                    }
                    var j = a.compressSpaces(this.getText());
                    if (!b.measureText) return 10 * j.length;
                    b.save(), this.setContext(b);
                    var k = b.measureText(j).width;
                    return b.restore(), k
                }
            }, a.Element.TextElementBase.prototype = new a.Element.RenderedElementBase, a.Element.tspan = function(b) {
                this.captureTextNodes = !0, this.base = a.Element.TextElementBase, this.base(b), this.text = b.nodeValue || b.text || "", this.getText = function() {
                    return this.text
                }
            }, a.Element.tspan.prototype = new a.Element.TextElementBase, a.Element.tref = function(b) {
                this.base = a.Element.TextElementBase, this.base(b), this.getText = function() {
                    var a = this.getHrefAttribute().getDefinition();
                    if (null != a) return a.children[0].getText()
                }
            }, a.Element.tref.prototype = new a.Element.TextElementBase, a.Element.a = function(b) {
                this.base = a.Element.TextElementBase, this.base(b), this.hasText = !0;
                for (var c = 0; c < b.childNodes.length; c++) 3 != b.childNodes[c].nodeType && (this.hasText = !1);
                this.text = this.hasText ? b.childNodes[0].nodeValue : "", this.getText = function() {
                    return this.text
                }, this.baseRenderChildren = this.renderChildren, this.renderChildren = function(b) {
                    if (this.hasText) {
                        this.baseRenderChildren(b);
                        var c = new a.Property("fontSize", a.Font.Parse(a.ctx.font).fontSize);
                        a.Mouse.checkBoundingBox(this, new a.BoundingBox(this.x, this.y - c.toPixels("y"), this.x + this.measureText(b), this.y))
                    } else {
                        var d = new a.Element.g;
                        d.children = this.children, d.parent = this, d.render(b)
                    }
                }, this.onclick = function() {
                    window.open(this.getHrefAttribute().value)
                }, this.onmousemove = function() {
                    a.ctx.canvas.style.cursor = "pointer"
                }
            }, a.Element.a.prototype = new a.Element.TextElementBase, a.Element.image = function(b) {
                this.base = a.Element.RenderedElementBase, this.base(b);
                var c = this.getHrefAttribute().value,
                    d = c.match(/\.svg$/);
                if (a.Images.push(this), this.loaded = !1, d) this.img = a.ajax(c), this.loaded = !0;
                else {
                    this.img = document.createElement("img");
                    var e = this;
                    this.img.onload = function() {
                        e.loaded = !0
                    }, this.img.onerror = function() {
                        "undefined" != typeof console && (console.log('ERROR: image "' + c + '" not found'), e.loaded = !0)
                    }, this.img.src = c
                }
                this.renderChildren = function(b) {
                    var c = this.attribute("x").toPixels("x"),
                        e = this.attribute("y").toPixels("y"),
                        f = this.attribute("width").toPixels("x"),
                        g = this.attribute("height").toPixels("y");
                    0 != f && 0 != g && (b.save(), d ? b.drawSvg(this.img, c, e, f, g) : (b.translate(c, e), a.AspectRatio(b, this.attribute("preserveAspectRatio").value, f, this.img.width, g, this.img.height, 0, 0), b.drawImage(this.img, 0, 0)), b.restore())
                }, this.getBoundingBox = function() {
                    var b = this.attribute("x").toPixels("x"),
                        c = this.attribute("y").toPixels("y"),
                        d = this.attribute("width").toPixels("x"),
                        e = this.attribute("height").toPixels("y");
                    return new a.BoundingBox(b, c, b + d, c + e)
                }
            }, a.Element.image.prototype = new a.Element.RenderedElementBase, a.Element.g = function(b) {
                this.base = a.Element.RenderedElementBase, this.base(b), this.getBoundingBox = function() {
                    for (var b = new a.BoundingBox, c = 0; c < this.children.length; c++) b.addBoundingBox(this.children[c].getBoundingBox());
                    return b
                }
            }, a.Element.g.prototype = new a.Element.RenderedElementBase, a.Element.symbol = function(b) {
                this.base = a.Element.RenderedElementBase, this.base(b), this.baseSetContext = this.setContext, this.setContext = function(b) {
                    if (this.baseSetContext(b), this.attribute("viewBox").hasValue()) {
                        var c = a.ToNumberArray(this.attribute("viewBox").value),
                            d = c[0],
                            e = c[1];
                        width = c[2], height = c[3], a.AspectRatio(b, this.attribute("preserveAspectRatio").value, this.attribute("width").toPixels("x"), width, this.attribute("height").toPixels("y"), height, d, e), a.ViewPort.SetCurrent(c[2], c[3])
                    }
                }
            }, a.Element.symbol.prototype = new a.Element.RenderedElementBase, a.Element.style = function(b) {
                this.base = a.Element.ElementBase, this.base(b);
                for (var c = "", d = 0; d < b.childNodes.length; d++) c += b.childNodes[d].nodeValue;
                c = c.replace(/(\/\*([^*]|[\r\n]|(\*+([^*\/]|[\r\n])))*\*+\/)|(^[\s]*\/\/.*)/gm, ""), c = a.compressSpaces(c);
                for (var e = c.split("}"), d = 0; d < e.length; d++)
                    if ("" != a.trim(e[d]))
                        for (var f = e[d].split("{"), g = f[0].split(","), h = f[1].split(";"), i = 0; i < g.length; i++) {
                            var j = a.trim(g[i]);
                            if ("" != j) {
                                for (var k = {}, l = 0; l < h.length; l++) {
                                    var m = h[l].indexOf(":"),
                                        n = h[l].substr(0, m),
                                        o = h[l].substr(m + 1, h[l].length - m);
                                    null != n && null != o && (k[a.trim(n)] = new a.Property(a.trim(n), a.trim(o)))
                                }
                                if (a.Styles[j] = k, "@font-face" == j)
                                    for (var p = k["font-family"].value.replace(/"/g, ""), q = k.src.value.split(","), r = 0; r < q.length; r++)
                                        if (q[r].indexOf('format("svg")') > 0)
                                            for (var s = q[r].indexOf("url"), t = q[r].indexOf(")", s), u = q[r].substr(s + 5, t - s - 6), v = a.parseXml(a.ajax(u)), w = v.getElementsByTagName("font"), x = 0; x < w.length; x++) {
                                                var y = a.CreateElement(w[x]);
                                                a.Definitions[p] = y
                                            }
                            }
                        }
            }, a.Element.style.prototype = new a.Element.ElementBase, a.Element.use = function(b) {
                this.base = a.Element.RenderedElementBase, this.base(b), this.baseSetContext = this.setContext, this.setContext = function(a) {
                    this.baseSetContext(a), this.attribute("x").hasValue() && a.translate(this.attribute("x").toPixels("x"), 0), this.attribute("y").hasValue() && a.translate(0, this.attribute("y").toPixels("y"))
                }, this.getDefinition = function() {
                    var a = this.getHrefAttribute().getDefinition();
                    return this.attribute("width").hasValue() && (a.attribute("width", !0).value = this.attribute("width").value), this.attribute("height").hasValue() && (a.attribute("height", !0).value = this.attribute("height").value), a
                }, this.path = function(a) {
                    var b = this.getDefinition();
                    null != b && b.path(a)
                }, this.getBoundingBox = function() {
                    var a = this.getDefinition();
                    if (null != a) return a.getBoundingBox()
                }, this.renderChildren = function(a) {
                    var b = this.getDefinition();
                    if (null != b) {
                        var c = b.parent;
                        b.parent = null, b.render(a), b.parent = c
                    }
                }
            }, a.Element.use.prototype = new a.Element.RenderedElementBase, a.Element.mask = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.apply = function(b, c) {
                    var d = this.attribute("x").toPixels("x"),
                        e = this.attribute("y").toPixels("y"),
                        f = this.attribute("width").toPixels("x"),
                        g = this.attribute("height").toPixels("y");
                    if (0 == f && 0 == g) {
                        for (var h = new a.BoundingBox, i = 0; i < this.children.length; i++) h.addBoundingBox(this.children[i].getBoundingBox());
                        var d = Math.floor(h.x1),
                            e = Math.floor(h.y1),
                            f = Math.floor(h.width()),
                            g = Math.floor(h.height())
                    }
                    var j = c.attribute("mask").value;
                    c.attribute("mask").value = "";
                    var k = document.createElement("canvas");
                    k.width = d + f, k.height = e + g;
                    var l = k.getContext("2d");
                    this.renderChildren(l);
                    var m = document.createElement("canvas");
                    m.width = d + f, m.height = e + g;
                    var n = m.getContext("2d");
                    c.render(n), n.globalCompositeOperation = "destination-in", n.fillStyle = l.createPattern(k, "no-repeat"), n.fillRect(0, 0, d + f, e + g), b.fillStyle = n.createPattern(m, "no-repeat"), b.fillRect(0, 0, d + f, e + g), c.attribute("mask").value = j
                }, this.render = function(a) {}
            }, a.Element.mask.prototype = new a.Element.ElementBase, a.Element.clipPath = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.apply = function(b) {
                    for (var c = 0; c < this.children.length; c++) {
                        var d = this.children[c];
                        if ("undefined" != typeof d.path) {
                            var e = null;
                            d.attribute("transform").hasValue() && (e = new a.Transform(d.attribute("transform").value), e.apply(b)), d.path(b), b.clip(), e && e.unapply(b)
                        }
                    }
                }, this.render = function(a) {}
            }, a.Element.clipPath.prototype = new a.Element.ElementBase, a.Element.filter = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.apply = function(a, b) {
                    var c = b.getBoundingBox(),
                        d = Math.floor(c.x1),
                        e = Math.floor(c.y1),
                        f = Math.floor(c.width()),
                        g = Math.floor(c.height()),
                        h = b.style("filter").value;
                    b.style("filter").value = "";
                    for (var i = 0, j = 0, k = 0; k < this.children.length; k++) {
                        var l = this.children[k].extraFilterDistance || 0;
                        i = Math.max(i, l), j = Math.max(j, l)
                    }
                    var m = document.createElement("canvas");
                    m.width = f + 2 * i, m.height = g + 2 * j;
                    var n = m.getContext("2d");
                    n.translate(-d + i, -e + j), b.render(n);
                    for (var k = 0; k < this.children.length; k++) this.children[k].apply(n, 0, 0, f + 2 * i, g + 2 * j);
                    a.drawImage(m, 0, 0, f + 2 * i, g + 2 * j, d - i, e - j, f + 2 * i, g + 2 * j), b.style("filter", !0).value = h
                }, this.render = function(a) {}
            }, a.Element.filter.prototype = new a.Element.ElementBase, a.Element.feMorphology = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.apply = function(a, b, c, d, e) {}
            }, a.Element.feMorphology.prototype = new a.Element.ElementBase, a.Element.feColorMatrix = function(b) {
                function c(a, b, c, d, e, f) {
                    return a[c * d * 4 + 4 * b + f]
                }

                function d(a, b, c, d, e, f, g) {
                    a[c * d * 4 + 4 * b + f] = g
                }
                this.base = a.Element.ElementBase, this.base(b), this.apply = function(a, b, e, f, g) {
                    for (var h = a.getImageData(0, 0, f, g), e = 0; e < g; e++)
                        for (var b = 0; b < f; b++) {
                            var i = c(h.data, b, e, f, g, 0),
                                j = c(h.data, b, e, f, g, 1),
                                k = c(h.data, b, e, f, g, 2),
                                l = (i + j + k) / 3;
                            d(h.data, b, e, f, g, 0, l), d(h.data, b, e, f, g, 1, l), d(h.data, b, e, f, g, 2, l)
                        }
                    a.clearRect(0, 0, f, g), a.putImageData(h, 0, 0)
                }
            }, a.Element.feColorMatrix.prototype = new a.Element.ElementBase, a.Element.feGaussianBlur = function(b) {
                this.base = a.Element.ElementBase, this.base(b), this.blurRadius = Math.floor(this.attribute("stdDeviation").numValue()), this.extraFilterDistance = this.blurRadius, this.apply = function(b, c, d, e, f) {
                    return "undefined" == typeof stackBlurCanvasRGBA ? void("undefined" != typeof console && console.log("ERROR: StackBlur.js must be included for blur to work")) : (b.canvas.id = a.UniqueId(), b.canvas.style.display = "none", document.body.appendChild(b.canvas), stackBlurCanvasRGBA(b.canvas.id, c, d, e, f, this.blurRadius), void document.body.removeChild(b.canvas))
                }
            }, a.Element.feGaussianBlur.prototype = new a.Element.ElementBase, a.Element.title = function(a) {}, a.Element.title.prototype = new a.Element.ElementBase, a.Element.desc = function(a) {}, a.Element.desc.prototype = new a.Element.ElementBase, a.Element.MISSING = function(a) {
                "undefined" != typeof console && console.log("ERROR: Element '" + a.nodeName + "' not yet implemented.")
            }, a.Element.MISSING.prototype = new a.Element.ElementBase, a.CreateElement = function(b) {
                var c = b.nodeName.replace(/^[^:]+:/, "");
                c = c.replace(/\-/g, "");
                var d = null;
                return d = "undefined" != typeof a.Element[c] ? new a.Element[c](b) : new a.Element.MISSING(b), d.type = b.nodeName, d
            }, a.load = function(b, c) {
                a.loadXml(b, a.ajax(c))
            }, a.loadXml = function(b, c) {
                a.loadXmlDoc(b, a.parseXml(c))
            }, a.loadXmlDoc = function(b, c) {
                a.init(b);
                var d = function(a) {
                    for (var c = b.canvas; c;) a.x -= c.offsetLeft, a.y -= c.offsetTop, c = c.offsetParent;
                    return window.scrollX && (a.x += window.scrollX), window.scrollY && (a.y += window.scrollY), a
                };
                1 != a.opts.ignoreMouse && (b.canvas.onclick = function(b) {
                    var c = d(new a.Point(null != b ? b.clientX : event.clientX, null != b ? b.clientY : event.clientY));
                    a.Mouse.onclick(c.x, c.y)
                }, b.canvas.onmousemove = function(b) {
                    var c = d(new a.Point(null != b ? b.clientX : event.clientX, null != b ? b.clientY : event.clientY));
                    a.Mouse.onmousemove(c.x, c.y);
                });
                var e = a.CreateElement(c.documentElement);
                e.root = !0;
                var f = !0,
                    g = function() {
                        a.ViewPort.Clear(), b.canvas.parentNode && a.ViewPort.SetCurrent(b.canvas.parentNode.clientWidth, b.canvas.parentNode.clientHeight), 1 != a.opts.ignoreDimensions && (e.style("width").hasValue() && (b.canvas.width = e.style("width").toPixels("x"), b.canvas.style.width = b.canvas.width + "px"), e.style("height").hasValue() && (b.canvas.height = e.style("height").toPixels("y"), b.canvas.style.height = b.canvas.height + "px"));
                        var d = b.canvas.clientWidth || b.canvas.width,
                            g = b.canvas.clientHeight || b.canvas.height;
                        if (1 == a.opts.ignoreDimensions && e.style("width").hasValue() && e.style("height").hasValue() && (d = e.style("width").toPixels("x"), g = e.style("height").toPixels("y")), a.ViewPort.SetCurrent(d, g), null != a.opts.offsetX && (e.attribute("x", !0).value = a.opts.offsetX), null != a.opts.offsetY && (e.attribute("y", !0).value = a.opts.offsetY), null != a.opts.scaleWidth && null != a.opts.scaleHeight) {
                            var h = 1,
                                i = 1,
                                j = a.ToNumberArray(e.attribute("viewBox").value);
                            e.attribute("width").hasValue() ? h = e.attribute("width").toPixels("x") / a.opts.scaleWidth : isNaN(j[2]) || (h = j[2] / a.opts.scaleWidth), e.attribute("height").hasValue() ? i = e.attribute("height").toPixels("y") / a.opts.scaleHeight : isNaN(j[3]) || (i = j[3] / a.opts.scaleHeight), e.attribute("width", !0).value = a.opts.scaleWidth, e.attribute("height", !0).value = a.opts.scaleHeight, e.attribute("viewBox", !0).value = "0 0 " + d * h + " " + g * i, e.attribute("preserveAspectRatio", !0).value = "none"
                        }
                        1 != a.opts.ignoreClear && b.clearRect(0, 0, d, g), e.render(b), f && (f = !1, "function" == typeof a.opts.renderCallback && a.opts.renderCallback(c))
                    },
                    h = !0;
                a.ImagesLoaded() && (h = !1, g()), a.intervalID = setInterval(function() {
                    var b = !1;
                    if (h && a.ImagesLoaded() && (h = !1, b = !0), 1 != a.opts.ignoreMouse && (b |= a.Mouse.hasEvents()), 1 != a.opts.ignoreAnimation)
                        for (var c = 0; c < a.Animations.length; c++) b |= a.Animations[c].update(1e3 / a.FRAMERATE);
                    "function" == typeof a.opts.forceRedraw && 1 == a.opts.forceRedraw() && (b = !0), b && (g(), a.Mouse.runEvents())
                }, 1e3 / a.FRAMERATE)
            }, a.stop = function() {
                a.intervalID && clearInterval(a.intervalID)
            }, a.Mouse = new function() {
                this.events = [], this.hasEvents = function() {
                    return 0 != this.events.length
                }, this.onclick = function(a, b) {
                    this.events.push({
                        type: "onclick",
                        x: a,
                        y: b,
                        run: function(a) {
                            a.onclick && a.onclick()
                        }
                    })
                }, this.onmousemove = function(a, b) {
                    this.events.push({
                        type: "onmousemove",
                        x: a,
                        y: b,
                        run: function(a) {
                            a.onmousemove && a.onmousemove()
                        }
                    })
                }, this.eventElements = [], this.checkPath = function(a, b) {
                    for (var c = 0; c < this.events.length; c++) {
                        var d = this.events[c];
                        b.isPointInPath && b.isPointInPath(d.x, d.y) && (this.eventElements[c] = a)
                    }
                }, this.checkBoundingBox = function(a, b) {
                    for (var c = 0; c < this.events.length; c++) {
                        var d = this.events[c];
                        b.isPointInBox(d.x, d.y) && (this.eventElements[c] = a)
                    }
                }, this.runEvents = function() {
                    a.ctx.canvas.style.cursor = "";
                    for (var b = 0; b < this.events.length; b++)
                        for (var c = this.events[b], d = this.eventElements[b]; d;) c.run(d), d = d.parent;
                    this.events = [], this.eventElements = []
                }
            }, a
        }
        this.canvg = function(b, c, d) {
            if (null != b || null != c || null != d) {
                d = d || {}, "string" == typeof b && (b = document.getElementById(b)), null != b.svg && b.svg.stop();
                var e = a();
                1 == b.childNodes.length && "OBJECT" == b.childNodes[0].nodeName || (b.svg = e), e.opts = d;
                var f = b.getContext("2d");
                "undefined" != typeof c.documentElement ? e.loadXmlDoc(f, c) : "<" == c.substr(0, 1) ? e.loadXml(f, c) : e.load(f, c)
            } else
                for (var g = document.getElementsByTagName("svg"), h = 0; h < g.length; h++) {
                    var i = g[h],
                        j = document.createElement("canvas");
                    j.width = i.clientWidth, j.height = i.clientHeight, i.parentNode.insertBefore(j, i), i.parentNode.removeChild(i);
                    var k = document.createElement("div");
                    k.appendChild(i), canvg(j, k.innerHTML)
                }
        }
    }(), "undefined" != typeof CanvasRenderingContext2D && (CanvasRenderingContext2D.prototype.drawSvg = function(a, b, c, d, e) {
            canvg(this.canvas, a, {
                ignoreMouse: !0,
                ignoreAnimation: !0,
                ignoreDimensions: !0,
                ignoreClear: !0,
                offsetX: b,
                offsetY: c,
                scaleWidth: d,
                scaleHeight: e
            })
        }),
        function(a, b) {
            "use strict";

            function c(a, b) {
                var c = f(b),
                    d = g.rect({
                        x: -c.left,
                        y: -c.top,
                        width: c.left + c.right,
                        height: c.top + c.bottom
                    });
                if (b.width && b.height) {
                    var e = a.width + c.left + c.right,
                        h = a.height + c.top + c.bottom;
                    d.scale(e / b.width, h / b.height)
                }
                return g.Rect(a).moveAndExpand(d)
            }

            function d(a) {
                var c = 1;
                if (!b.isUndefined(a) && (c = parseFloat(a), !b.isFinite(c) || 0 === c)) throw new Error("dia.Paper: invalid raster size (" + a + ")");
                return c
            }

            function e(a, b) {
                return {
                    width: (a.width || 1) * b,
                    height: (a.height || 1) * b
                }
            }

            function f(b) {
                var c = a.util.normalizeSides(b.padding);
                return b.width && b.height && (c.left + c.right >= b.width && (c.left = c.right = 0), c.top + c.bottom >= b.height && (c.top = c.bottom = 0)), c
            }

            function h(a) {
                return a.replace(/\<image[^>]*>/g, function(a) {
                    var b = a.match(/href="([^"]*)"/)[1],
                        c = "data:image/svg+xml";
                    if (b.substr(0, c.length) === c) {
                        var d = atob(b.substr(b.indexOf(",") + 1));
                        return d.substr(d.indexOf("<svg"))
                    }
                    return a
                })
            }
            a.dia.Paper.prototype.toDataURL = function(a, f) {
                if ("function" != typeof this.toSVG) throw new Error("The joint.format.svg.js plugin must be loaded.");
                f = f || {};
                var g, i = V.transformRect(this.getContentBBox(), this.viewport.getCTM().inverse()),
                    j = c(i, f),
                    k = f.width && f.height ? f : j,
                    l = e(k, d(f.size)),
                    m = new Image;
                m.onload = function() {
                    function c() {
                        j = document.createElement("canvas"), j.width = l.width, j.height = l.height, i = j.getContext("2d"), i.fillStyle = f.backgroundColor || "white", i.fillRect(0, 0, l.width, l.height)
                    }

                    function d() {
                        e = j.toDataURL(f.type, f.quality), a(e), j.svg && b.isFunction(j.svg.stop) && b.defer(j.svg.stop)
                    }
                    var e, i, j;
                    c();
                    try {
                        i.drawImage(m, 0, 0, l.width, l.height), d()
                    } catch (k) {
                        if ("undefined" == typeof canvg) return void console.error("Canvas tainted. Canvg library required.");
                        c();
                        var n = {
                            ignoreDimensions: !0,
                            ignoreClear: !0,
                            ignoreMouse: !0,
                            ignoreAnimation: !0,
                            offsetX: 0,
                            offsetY: 0,
                            useCORS: !0
                        };
                        canvg(j, g, b.extend(n, {
                            forceRedraw: b.once(function() {
                                return !0
                            }),
                            renderCallback: function() {
                                try {
                                    d()
                                } catch (a) {
                                    g = h(g), c(), canvg(j, g, b.extend(n, {
                                        renderCallback: d
                                    }))
                                }
                            }
                        }))
                    }
                }, this.toSVG(function(a) {
                    g = a = a.replace('width="100%"', 'width="' + l.width + '"').replace('height="100%"', 'height="' + l.height + '"'), m.src = "data:image/svg+xml," + encodeURIComponent(a)
                }, {
                    convertImagesToDataUris: !0,
                    area: j
                })
            }, a.dia.Paper.prototype.toPNG = function(a, b) {
                b = b || {}, b.type = "image/png", this.toDataURL(a, b)
            }, a.dia.Paper.prototype.toJPEG = function(a, b) {
                b = b || {}, b.type = "image/jpeg", this.toDataURL(a, b)
            }, a.dia.Paper.prototype.openAsPNG = function(a) {
                var c = "menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes",
                    d = b.uniqueId("png_output");
                this.toPNG(function(a) {
                    var b = window.open("", d, c);
                    b.document.write('<img src="' + a + '"/>')
                }, b.extend({
                    padding: 10
                }, a))
            }
        }(joint, _);
    ! function(a, b, c, d) {
        function e(b) {
            b = b || {}, this.trigger("beforeprint", b), this.$printArea = a("<div/>").addClass("printarea"), b.size && this.$printArea.addClass("printarea-size-" + b.size);
            var e = this.$el.clone().appendTo(this.$printArea),
                f = d.util.normalizeSides(b.padding),
                g = this.getContentBBox().moveAndExpand({
                    x: -f.left,
                    y: -f.top,
                    width: f.left + f.right,
                    height: f.top + f.bottom
                });
            c(e.find("svg")[0]).attr({
                width: "100%",
                height: "100%",
                viewBox: [g.x, g.y, g.width, g.height].join(" ")
            }), this.$detachedChildren = this.$el.children().detach(), this.$printArea.prependTo(document.body)
        }

        function f(a) {
            a = a || {}, this.$printArea.remove(), this.$el.append(this.$detachedChildren), this.$detachedChildren = null, this.$printArea = null, this.trigger("afterprint", a)
        }
        d.dia.Paper.prototype.print = function(c) {
            c = c || {}, b.defaults(c, {
                size: "a4",
                padding: 5
            });
            var d = b.bind(e, this, c),
                g = b.bind(f, this, c),
                h = b.once(function() {
                    g(), a(window).off("afterprint", h)
                });
            a(window).one("afterprint", h), b.delay(h, 200), d(), window.print()
        }
    }($, _, V, joint);
    if ("object" == typeof exports) var WebSocketServer = require("ws").Server,
        WebSocket = require("ws"),
        url = require("url");
    WebSocket = WebSocket || "undefined" != typeof window && window.WebSocket, joint.com = joint.com || {}, joint.com.Channel = function(a) {
        if (this.options = a, !this.options || !this.options.graph) throw new Error("Channel: missing a graph.");
        this.options.ttl = this.options.ttl || 60, this.options.healthCheckInterval = this.options.healthCheckInterval || 36e5, this.options.reconnectInterval = this.options.reconnectInterval || 1e4, this.options.serverShouldSendGraph = !!_.isUndefined(this.options.serverShouldSendGraph) || this.options.serverShouldSendGraph, this._isClient = !!this.options.url, this._clients = [], this.messageQueue = [], this.id = this.options.id || (this._isClient ? "c_" : "s_") + joint.util.uuid(), this.state = {}, this.state[this.id] = 0, this.sites = {}, this.sites[this.id] = {
            socket: void 0,
            outgoing: [],
            ttl: this.options.ttl
        }, this.initialize()
    }, _.extend(joint.com.Channel.prototype, Backbone.Events), joint.com.Channel.prototype.initialize = function() {
        this.options.graph.on("all", this.onGraphChange.bind(this)), this._isClient ? this.connectClient() : this.options.port && (this.server = new WebSocketServer({
            port: this.options.port
        }), this.server.on("connection", this.onConnection.bind(this))), this._isClient || (this._healthCheckInterval = setInterval(this.healthCheck.bind(this), this.options.healthCheckInterval))
    }, joint.com.Channel.prototype.connectClient = function() {
        var a = this.options.url + "/?channelId=" + this.id + "&state=" + JSON.stringify(this.state) + (this.options.query ? "&query=" + JSON.stringify(this.options.query) : "");
        this.options.debugLevel > 0 && this.log("connectClient", a);
        var b = new WebSocket(a);
        b.onopen = this.onConnection.bind(this, b), b.onclose = this.onClose.bind(this, b)
    }, joint.com.Channel.prototype.close = function() {
        this._reconnectTimeout && clearTimeout(this._reconnectTimeout), this._healthCheckInterval && clearInterval(this._healthCheckInterval), this._closed = !0, _.each(this.sites, function(a) {
            a.socket && a.socket.close()
        }), this.server && this.server.close()
    }, joint.com.Channel.prototype.healthCheck = function() {
        this.options.debugLevel > 0 && this.log("healthCheck", _.object(_.keys(this.sites), _.pluck(this.sites, "ttl"))), _.each(this.sites, function(a, b) {
            b !== this.id && (a.socket && 1 === a.socket.readyState ? a.ttl = this.options.ttl : a.ttl -= 1, a.ttl <= 0 && (this.sites = _.omit(this.sites, b), this.state = _.omit(this.state, b)))
        }, this)
    }, joint.com.Channel.prototype.onConnection = function(a) {
        if (this._clients.push(a), this.trigger("open", a), this._isClient) this.sites[this.id].socket = a, a.onmessage = function(b) {
            this.onMessage(a, b.data)
        }.bind(this);
        else {
            var b = url.parse(a.upgradeReq.url, !0),
                c = b.query.channelId;
            if (this.sites[c]) this.sites[c].socket = a;
            else if (this.debugLevel > 1 && this.log("new_site", c), this.sites[c] = {
                    socket: a,
                    outgoing: [],
                    ttl: this.options.ttl
                }, this.state[c] = 0, this.options.serverShouldSendGraph) {
                var d = {
                    channelId: this.id,
                    state: JSON.parse(JSON.stringify(this.state)),
                    action: "graph",
                    graph: this.options.graph.toJSON()
                };
                this.messageQueue.push({
                    type: "op",
                    data: d,
                    source: this.id,
                    target: [c]
                }), this.send()
            }
            a.on("message", this.onMessage.bind(this, a)), a.on("close", this.onClose.bind(this, a))
        }
    }, joint.com.Channel.prototype.onClose = function(a) {
        var b = this._clients.indexOf(a);
        b !== -1 && this._clients.splice(b, 1), this._isClient && !this._closed && (this._reconnectTimeout && clearTimeout(this._reconnectTimeout), this._reconnectTimeout = setTimeout(this.connectClient.bind(this), this.options.reconnectInterval)), this.trigger("close", a)
    }, joint.com.Channel.prototype.onMessage = function(a, b) {
        this.trigger("message:received", b), this.options.debugLevel > 1 && this.log("message", b);
        try {
            b = JSON.parse(b)
        } catch (c) {
            return console.error("Channel: message parsing failed.", c)
        }
        if ("notification" == b.type) return this.trigger(b.data.event, b.data.data), this.sendNotification(b);
        var d, e, f = b.data;
        this._isClient ? (d = this.sites[this.id], f = this.receive(d, this.id, f)) : (e = this.sites[f.channelId], f = this.receive(e, f.channelId, f), d = this.sites[this.id], f = this.receive(d, this.id, f)), "graph" === f.action ? this.state[f.channelId] = f.state[f.channelId] : this.state[f.channelId] = (this.state[f.channelId] || 0) + 1, this.options.debugLevel > 1 && this.log("new state", this.state), this.execute(f), _.each(this.sites, function(a, b) {
            b !== this.id && b !== f.channelId && this.receive(a, b, f)
        }, this), this._isClient || (b.op = f, this.messageQueue.push(b), this.broadcast(b)), this.trigger("message:processed", b)
    }, joint.com.Channel.prototype.receive = function(a, b, c) {
        if (!a) return c;
        this.options.debugLevel > 1 && this.log("receive", b, c), this.options.debugLevel > 1 && this.log("outgoing", a.outgoing), a.outgoing = _.filter(a.outgoing, function(a) {
            return a.state[a.channelId] >= (c.state[a.channelId] || 0)
        }), this.options.debugLevel > 1 && this.log("outgoing.length", a.outgoing.length);
        for (var d = 0; d < a.outgoing.length; d++) {
            var e = a.outgoing[d],
                f = this.transform(c, e);
            c = f[0], a.outgoing[d] = f[1]
        }
        return c
    }, joint.com.Channel.prototype.transform = function(a, b) {
        return this.options.debugLevel > 1 && this.log("transform", a, b), "change:target" === a.action && "remove" === b.action && a.cell.target.id === b.cell.id && (a.cell.target = {
            x: 0,
            y: 0
        }), "change:source" === a.action && "remove" === b.action && a.cell.source.id === b.cell.id && (a.cell.source = {
            x: 0,
            y: 0
        }), [a, b]
    }, joint.com.Channel.prototype.execute = function(a) {
        var b;
        switch (a.action) {
            case "add":
                this.options.graph.addCell(a.cell, {
                    remote: !0
                });
                break;
            case "remove":
                b = this.options.graph.getCell(a.cell.id), b && b.remove({
                    remote: !0,
                    disconnectLinks: !0
                });
                break;
            case "graph":
                this.options.graph.fromJSON(a.graph);
                break;
            default:
                var c = a.action.substr("change:".length);
                b = this.options.graph.getCell(a.cell.id), b && b.set(c, a.cell[c], {
                    remote: !0
                })
        }
    }, joint.com.Channel.prototype.broadcast = function(a) {
        this._isClient ? a.target = _.keys(this.sites) : a.target = _.keys(_.omit(this.sites, this.id, a.source)), this.send()
    }, joint.com.Channel.prototype.send = function() {
        if (!this._paused) {
            for (var a = [], b = 0; b < this.messageQueue.length; b++) {
                var c = this.messageQueue[b];
                this.sendMessage(c) && a.push(b)
            }
            a.forEach(_.bind(function(a) {
                this.messageQueue.splice(a, 1)
            }, this))
        }
    }, joint.com.Channel.prototype.sendMessage = function(a) {
        this.debugLevel > 1 && this.log("sendMessage", a);
        var b = [];
        return a.target.forEach(function(c, d) {
            var e = this.sites[c];
            return e ? void(e.socket && 1 === e.socket.readyState && (this.debugLevel > 1 && this.log("sendMessage", c, a), e.socket.send(JSON.stringify(a)), b.push(d))) : b.push(d)
        }, this), b.forEach(function(b) {
            a.target.splice(b, 1)
        }), !a.target.length
    }, joint.com.Channel.prototype.log = function(a, b) {
        var c = "Channel [" + this.id + "] " + a.toUpperCase() + ": ";
        console.log.apply(console, [c].concat(Array.prototype.slice.call(arguments, 1)))
    }, joint.com.Channel.prototype.pause = function() {
        this._paused = !0
    }, joint.com.Channel.prototype.unpause = function() {
        this._paused = !1, this.send()
    }, joint.com.Channel.prototype.notify = function(a, b) {
        var c = {
            type: "notification",
            source: this.id,
            data: {
                event: a,
                data: b
            }
        };
        this.sendNotification(c)
    }, joint.com.Channel.prototype.sendNotification = function(a) {
        this._isClient ? a.target = _.keys(this.sites) : a.target = _.keys(_.omit(this.sites, this.id, a.source)), this.sendMessage(a)
    }, joint.com.Channel.prototype.onGraphChange = function(a, b, c, d) {
        if (!d || !d.remote) {
            var e = "add" === a || "remove" === a || "change:" === a.substr(0, "change:".length);
            if (e) {
                var f = {
                        channelId: this.id,
                        state: JSON.parse(JSON.stringify(this.state)),
                        action: a,
                        cell: b.toJSON()
                    },
                    g = {
                        type: "op",
                        data: f,
                        source: this.id
                    };
                this.options.debugLevel > 1 && this.log("generate", g), this.messageQueue.push(g), this.broadcast(g), this.sites[this.id].outgoing.push(f), this.state[this.id]++
            }
        }
    }, joint.com.ChannelHub = function(a) {
        if (this.options = a, !this.options.port) throw new Error("ChannelHub: missing a port.");
        this.initialize()
    }, _.extend(joint.com.ChannelHub.prototype, Backbone.Events), joint.com.ChannelHub.prototype.initialize = function() {
        this.server = new WebSocketServer({
            port: this.options.port
        }), this.server.on("connection", this.onConnection.bind(this))
    }, joint.com.ChannelHub.prototype.onConnection = function(a) {
        var b = url.parse(a.upgradeReq.url, !0),
            c = {
                query: b.query
            };
        if (!this.router) throw new Error("ChannelHub: missing a router.");
        var d = !1,
            e = this.router(c, function(b, c) {
                if (b) throw new Error(b);
                c && !d && (c.onConnection(a), d = !0)
            });
        e instanceof joint.com.Channel && (e.onConnection(a), d = !0)
    }, joint.com.ChannelHub.prototype.route = function(a) {
        this.router = a
    }, joint.com.ChannelHub.prototype.close = function() {
        this.server.close()
    };
    joint.alg = joint.alg || {}, joint.alg.Dijkstra = function(a, b, c) {
        c = c || function(a, b) {
            return 1
        };
        var d = {};
        d[b] = 0;
        var e = {},
            f = new joint.alg.PriorityQueue;
        for (var g in a) g !== b && (d[g] = 1 / 0), f.insert(d[g], g, g);
        for (var h, i, j, k, l = {}; !f.isEmpty();)
            for (h = f.remove(), l[h] = !0, i = a[h] || [], j = 0; j < i.length; j++) g = i[j], l[g] || (k = d[h] + c(h, g), k < d[g] && (d[g] = k, e[g] = h, f.updatePriority(g, k)));
        return e
    };
    joint.alg = joint.alg || {}, joint.alg.PriorityQueue = function(a) {
        a = a || {}, this.comparator = a.comparator || function(a, b) {
            return a - b
        }, this.index = {}, this.data = a.data || [], this.heapify()
    }, joint.alg.PriorityQueue.prototype.isEmpty = function() {
        return 0 === this.data.length
    }, joint.alg.PriorityQueue.prototype.insert = function(a, b, c) {
        var d = {
            priority: a,
            value: b
        };
        this.data.push(d);
        var e = this.data.length - 1;
        c && (d.id = c, this.index[c] = e), this.bubbleUp(e)
    }, joint.alg.PriorityQueue.prototype.peek = function() {
        return this.data[0] && this.data[0].value
    }, joint.alg.PriorityQueue.prototype.peekPriority = function() {
        return this.data[0] && this.data[0].priority
    }, joint.alg.PriorityQueue.prototype.updatePriority = function(a, b) {
        var c = this.index[a];
        if (null === c || "undefined" == typeof c) throw new Error("Node with id " + a + " was not found in the heap.");
        var d = this.data,
            e = d[c].priority,
            f = this.comparator(b, e);
        f < 0 ? (d[c].priority = b, this.bubbleUp(c)) : f > 0 && (d[c].priority = b, this.bubbleDown(c))
    }, joint.alg.PriorityQueue.prototype.remove = function() {
        var a = this.data,
            b = a[0],
            c = a.pop();
        return this.index[a.length] = null, a.length > 0 && (a[0] = c, c.id && (this.index[c.id] = 0), this.bubbleDown(0)), b && b.value
    }, joint.alg.PriorityQueue.prototype.heapify = function() {
        for (var a = 0; a < this.data.length; a++) this.bubbleUp(a)
    }, joint.alg.PriorityQueue.prototype.bubbleUp = function(a) {
        for (var b, c, d = this.data; a > 0 && (b = a - 1 >>> 1, this.comparator(d[a].priority, d[b].priority) < 0);) c = d[b], d[b] = d[a], d[a].id && (this.index[d[a].id] = b), d[a] = c, d[a].id && (this.index[d[a].id] = a), a = b
    }, joint.alg.PriorityQueue.prototype.bubbleDown = function(a) {
        for (var b = this.data, c = b.length - 1;;) {
            var d = (a << 1) + 1,
                e = d + 1,
                f = a;
            if (d <= c && this.comparator(b[d].priority, b[f].priority) < 0 && (f = d), e <= c && this.comparator(b[e].priority, b[f].priority) < 0 && (f = e), f === a) break;
            var g = b[f];
            b[f] = b[a], b[a].id && (this.index[b[a].id] = f), b[a] = g, b[a].id && (this.index[b[a].id] = a), a = f
        }
    };
    joint.storage = joint.storage || {}, joint.storage.Local = {
        prefix: "joint.storage",
        insert: function(a, b, c) {
            var d = b.id || _.uniqueId("doc-"),
                e = this.loadIndex(a);
            e.keys.push(d), this.setItem(this.docKey(a, d), b), this.setItem(this.indexKey(a), e), this.callback(c, null, _.extend({}, b, {
                id: d
            }))
        },
        find: function(a, b, c) {
            var d = this.loadIndex(a),
                e = [];
            if (_.isEmpty(b)) _.each(d.keys, function(b) {
                var d = this.getItem(this.docKey(a, b));
                d || this.callback(c, new Error("Storage incosistency. No document found for an ID " + b + " from index.")), e.push(d)
            }, this), this.callback(c, null, e);
            else if (b.id) {
                var f = this.getItem(this.docKey(a, b.id));
                this.callback(c, null, f ? [f] : [])
            } else this.callback(c, null, [])
        },
        remove: function(a, b, c) {
            var d = this.loadIndex(a);
            _.isEmpty(b) ? (_.each(d.keys, function(b) {
                localStorage.removeItem(this.docKey(a, b))
            }, this), localStorage.removeItem(this.indexKey(a)), this.callback(c, null)) : b.id && (_.remove(d.keys, function(a) {
                return a === b.id
            }), localStorage.removeItem(this.docKey(a, b.id)), this.setItem(this.indexKey(a), d), this.callback(c, null))
        },
        callback: function(a, b, c) {
            a && _.defer(function() {
                a(b, c)
            })
        },
        setItem: function(a, b) {
            localStorage.setItem(a, JSON.stringify(b))
        },
        getItem: function(a) {
            var b = localStorage.getItem(a);
            return b ? JSON.parse(b) : b
        },
        loadIndex: function(a) {
            var b = this.getItem(this.indexKey(a)) || {};
            return b.keys = b.keys || [], b
        },
        docKey: function(a, b) {
            return this.prefix + "." + a + ".docs." + b
        },
        indexKey: function(a) {
            return this.prefix + "." + a + ".index"
        }
    };

    joint.g = g;
    joint.V = joint.Vectorizer = V;

    return joint;

}));