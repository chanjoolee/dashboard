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
        var a = {}, b = Math,
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
            m = b.random,
            n = b.pow;
        a.bezier = {
            curveThroughPoints: function(a) {
                for (var b = this.getCurveControlPoints(a), c = ["M", a[0].x, a[0].y], d = 0; d < b[0].length; d++) c.push("C", b[0][d].x, b[0][d].y, b[1][d].x, b[1][d].y, a[d + 1].x, a[d + 1].y);
                return c
            },
            getCurveControlPoints: function(a) {
                var b, c = [],
                    d = [],
                    e = a.length - 1;
                if (1 == e) return c[0] = q((2 * a[0].x + a[1].x) / 3, (2 * a[0].y + a[1].y) / 3), d[0] = q(2 * c[0].x - a[0].x, 2 * c[0].y - a[0].y), [c, d];
                var f = [];
                for (b = 1; b < e - 1; b++) f[b] = 4 * a[b].x + 2 * a[b + 1].x;
                f[0] = a[0].x + 2 * a[1].x, f[e - 1] = (8 * a[e - 1].x + a[e].x) / 2;
                var g = this.getFirstControlPoints(f);
                for (b = 1; b < e - 1; ++b) f[b] = 4 * a[b].y + 2 * a[b + 1].y;
                f[0] = a[0].y + 2 * a[1].y, f[e - 1] = (8 * a[e - 1].y + a[e].y) / 2;
                var h = this.getFirstControlPoints(f);
                for (b = 0; b < e; b++) c.push(q(g[b], h[b])), b < e - 1 ? d.push(q(2 * a[b + 1].x - g[b + 1], 2 * a[b + 1].y - h[b + 1])) : d.push(q((a[e].x + g[e - 1]) / 2, (a[e].y + h[e - 1]) / 2));
                return [c, d]
            },
            getCurveDivider: function(a, b, c, d) {
                return function(e) {
                    var f = p(a, b).pointAt(e),
                        g = p(b, c).pointAt(e),
                        h = p(c, d).pointAt(e),
                        i = p(f, g).pointAt(e),
                        j = p(g, h).pointAt(e),
                        k = p(i, j).pointAt(e);
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
        var o = a.Ellipse = function(a, b, c) {
            return this instanceof o ? a instanceof o ? new o(q(a), a.a, a.b) : (a = q(a), this.x = a.x, this.y = a.y, this.a = b, void(this.b = c)) : new o(a, b, c)
        };
        a.Ellipse.fromRect = function(a) {
            return a = r(a), o(a.center(), a.width / 2, a.height / 2)
        }, a.Ellipse.prototype = {
            bbox: function() {
                return r(this.x - this.a, this.y - this.b, 2 * this.a, 2 * this.b)
            },
            clone: function() {
                return o(this)
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
            inflate: function(a, b) {
                return void 0 === a && (a = 0), void 0 === b && (b = a), this.a += 2 * a, this.b += 2 * b, this
            },
            containsPoint: function(a) {
                return this.normalizedDistance(a) <= 1
            },
            center: function() {
                return q(this.x, this.y)
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
                return a = o(a), a.x === this.x && a.y === this.y && a.a === this.a && a.b === this.b
            },
            intersectionWithLineFromCenterToPoint: function(a, b) {
                a = q(a), b && a.rotate(q(this.x, this.y), b);
                var c, d = a.x - this.x,
                    e = a.y - this.y;
                if (0 === d) return c = this.bbox().pointNearestToPoint(a), b ? c.rotate(q(this.x, this.y), -b) : c;
                var g = e / d,
                    h = g * g,
                    i = this.a * this.a,
                    j = this.b * this.b,
                    k = f(1 / (1 / i + h / j));
                k = d < 0 ? -k : k;
                var l = g * k;
                return c = q(this.x + k, this.y + l), b ? c.rotate(q(this.x, this.y), -b) : c
            },
            toString: function() {
                return q(this.x, this.y).toString() + " " + this.a + " " + this.b
            }
        };
        var p = a.Line = function(a, b) {
            return this instanceof p ? (this.start = q(a), void(this.end = q(b))) : new p(a, b)
        };
        a.Line.prototype = {
            bearing: function() {
                var a = v(this.start.y),
                    b = v(this.end.y),
                    c = this.start.x,
                    f = this.end.x,
                    g = v(f - c),
                    h = e(g) * d(b),
                    j = d(a) * e(b) - e(a) * d(b) * d(g),
                    k = u(i(h, j)),
                    l = ["NE", "E", "SE", "S", "SW", "W", "NW", "N"],
                    m = k - 22.5;
                return m < 0 && (m += 360), m = parseInt(m / 45), l[m]
            },
            clone: function() {
                return p(this)
            },
            equals: function(a) {
                return this.start.x === a.start.x && this.start.y === a.start.y && this.end.x === a.end.x && this.end.y === a.end.y
            },
            intersect: function(a) {
                if (a instanceof p) {
                    var b = q(this.end.x - this.start.x, this.end.y - this.start.y),
                        c = q(a.end.x - a.start.x, a.end.y - a.start.y),
                        d = b.x * c.y - b.y * c.x,
                        e = q(a.start.x - this.start.x, a.start.y - this.start.y),
                        f = e.x * c.y - e.y * c.x,
                        g = e.x * b.y - e.y * b.x;
                    if (0 === d || f * d < 0 || g * d < 0) return null;
                    if (d > 0) {
                        if (f > d || g > d) return null
                    } else if (f < d || g < d) return null;
                    return q(this.start.x + f * b.x / d, this.start.y + f * b.y / d)
                }
                if (a instanceof r) {
                    var h, i, j = a,
                        k = [j.topLine(), j.rightLine(), j.bottomLine(), j.leftLine()],
                        l = [],
                        m = [];
                    for (i = 0; i < k.length; i++) h = this.intersect(k[i]), null !== h && m.indexOf(h.toString()) < 0 && (l.push(h), m.push(h.toString()));
                    return l.length > 0 ? l : null
                }
                return null
            },
            length: function() {
                return f(this.squaredLength())
            },
            midpoint: function() {
                return q((this.start.x + this.end.x) / 2, (this.start.y + this.end.y) / 2)
            },
            pointAt: function(a) {
                var b = (1 - a) * this.start.x + a * this.end.x,
                    c = (1 - a) * this.start.y + a * this.end.y;
                return q(b, c)
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
        }, a.Line.prototype.intersection = a.Line.prototype.intersect;
        var q = a.Point = function(a, b) {
            if (!(this instanceof q)) return new q(a, b);
            if ("string" == typeof a) {
                var c = a.split(a.indexOf("@") === -1 ? " " : "@");
                a = parseInt(c[0], 10), b = parseInt(c[1], 10)
            } else Object(a) === a && (b = a.y, a = a.x);
            this.x = void 0 === a ? 0 : a, this.y = void 0 === b ? 0 : b
        };
        a.Point.fromPolar = function(a, b, f) {
            f = f && q(f) || q(0, 0);
            var g = c(a * d(b)),
                h = c(a * e(b)),
                i = s(u(b));
            return i < 90 ? h = -h : i < 180 ? (g = -g, h = -h) : i < 270 && (g = -g), q(f.x + g, f.y + h)
        }, a.Point.random = function(a, b, c, d) {
            return q(k(m() * (b - a + 1) + a), k(m() * (d - c + 1) + c))
        }, a.Point.prototype = {
            adhereToRect: function(a) {
                return a.containsPoint(this) ? this : (this.x = g(h(this.x, a.x), a.x + a.width), this.y = g(h(this.y, a.y), a.y + a.height), this)
            },
            bearing: function(a) {
                return p(this, a).bearing()
            },
            changeInAngle: function(a, b, c) {
                return q(this).offset(-a, -b).theta(c) - this.theta(c)
            },
            clone: function() {
                return q(this)
            },
            difference: function(a, b) {
                return Object(a) === a && (b = a.y, a = a.x), q(this.x - (a || 0), this.y - (b || 0))
            },
            distance: function(a) {
                return p(this, a).length()
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
                var c = v(q(a).theta(this));
                return this.offset(d(c) * b, -e(c) * b)
            },
            normalize: function(a) {
                var b = (a || 1) / this.magnitude();
                return this.scale(b, b)
            },
            offset: function(a, b) {
                return Object(a) === a && (b = a.y, a = a.x), this.x += a || 0, this.y += b || 0, this
            },
            reflection: function(a) {
                return q(a).move(this, this.distance(a))
            },
            rotate: function(a, b) {
                b = (b + 360) % 360, this.toPolar(a), this.y += v(b);
                var c = q.fromPolar(this.x, this.y, a);
                return this.x = c.x, this.y = c.y, this
            },
            round: function(a) {
                var b = n(10, a || 0);
                return this.x = j(this.x * b) / b, this.y = j(this.y * b) / b, this
            },
            scale: function(a, b, c) {
                return c = c && q(c) || q(0, 0), this.x = c.x + a * (this.x - c.x), this.y = c.y + b * (this.y - c.y), this
            },
            snapToGrid: function(a, b) {
                return this.x = t(this.x, a), this.y = t(this.y, b || a), this
            },
            theta: function(a) {
                a = q(a);
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
                a = a && q(a) || q(0, 0);
                var b = this.x,
                    c = this.y;
                return this.x = f((b - a.x) * (b - a.x) + (c - a.y) * (c - a.y)), this.y = v(a.theta(q(b, c))), this
            },
            toString: function() {
                return this.x + "@" + this.y
            },
            update: function(a, b) {
                return this.x = a || 0, this.y = b || 0, this
            }
        };
        var r = a.Rect = function(a, b, c, d) {
            return this instanceof r ? (Object(a) === a && (b = a.y, c = a.width, d = a.height, a = a.x), this.x = void 0 === a ? 0 : a, this.y = void 0 === b ? 0 : b, this.width = void 0 === c ? 0 : c, void(this.height = void 0 === d ? 0 : d)) : new r(a, b, c, d)
        };
        a.Rect.fromEllipse = function(a) {
            return a = o(a), r(a.x - a.a, a.y - a.b, 2 * a.a, 2 * a.b)
        }, a.Rect.prototype = {
            bbox: function(a) {
                var b = v(a || 0),
                    f = c(e(b)),
                    g = c(d(b)),
                    h = this.width * g + this.height * f,
                    i = this.width * f + this.height * g;
                return r(this.x + (this.width - h) / 2, this.y + (this.height - i) / 2, h, i)
            },
            bottomLeft: function() {
                return q(this.x, this.y + this.height)
            },
            bottomLine: function() {
                return p(this.bottomLeft(), this.corner())
            },
            bottomMiddle: function() {
                return q(this.x + this.width / 2, this.y + this.height)
            },
            center: function() {
                return q(this.x + this.width / 2, this.y + this.height / 2)
            },
            clone: function() {
                return r(this)
            },
            containsPoint: function(a) {
                return a = q(a), a.x >= this.x && a.x <= this.x + this.width && a.y >= this.y && a.y <= this.y + this.height
            },
            containsRect: function(a) {
                var b = r(this).normalize(),
                    c = r(a).normalize(),
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
                return q(this.x + this.width, this.y + this.height)
            },
            equals: function(a) {
                var b = r(this).normalize(),
                    c = r(a).normalize();
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
                return r(f, g, Math.min(c.x, e.x) - f, Math.min(c.y, e.y) - g)
            },
            intersectionWithLineFromCenterToPoint: function(a, b) {
                a = q(a);
                var c, d = q(this.x + this.width / 2, this.y + this.height / 2);
                b && a.rotate(d, b);
                for (var e = [p(this.origin(), this.topRight()), p(this.topRight(), this.corner()), p(this.corner(), this.bottomLeft()), p(this.bottomLeft(), this.origin())], f = p(d, a), g = e.length - 1; g >= 0; --g) {
                    var h = e[g].intersection(f);
                    if (null !== h) {
                        c = h;
                        break
                    }
                }
                return c && b && c.rotate(d, -b), c
            },
            leftLine: function() {
                return p(this.origin(), this.bottomLeft())
            },
            leftMiddle: function() {
                return q(this.x, this.y + this.height / 2)
            },
            moveAndExpand: function(a) {
                return this.x += a.x || 0, this.y += a.y || 0, this.width += a.width || 0, this.height += a.height || 0, this
            },
            inflate: function(a, b) {
                return void 0 === a && (a = 0), void 0 === b && (b = a), this.x -= a, this.y -= b, this.width += 2 * a, this.height += 2 * b, this
            },
            normalize: function() {
                var a = this.x,
                    b = this.y,
                    c = this.width,
                    d = this.height;
                return this.width < 0 && (a = this.x + this.width, c = -this.width), this.height < 0 && (b = this.y + this.height, d = -this.height), this.x = a, this.y = b, this.width = c, this.height = d, this
            },
            origin: function() {
                return q(this.x, this.y)
            },
            pointNearestToPoint: function(a) {
                if (a = q(a), this.containsPoint(a)) {
                    var b = this.sideNearestToPoint(a);
                    switch (b) {
                        case "right":
                            return q(this.x + this.width, a.y);
                        case "left":
                            return q(this.x, a.y);
                        case "bottom":
                            return q(a.x, this.y + this.height);
                        case "top":
                            return q(a.x, this.y)
                    }
                }
                return a.adhereToRect(this)
            },
            rightLine: function() {
                return p(this.topRight(), this.corner())
            },
            rightMiddle: function() {
                return q(this.x + this.width, this.y + this.height / 2)
            },
            round: function(a) {
                var b = n(10, a || 0);
                return this.x = j(this.x * b) / b, this.y = j(this.y * b) / b, this.width = j(this.width * b) / b, this.height = j(this.height * b) / b, this
            },
            scale: function(a, b, c) {
                return c = this.origin().scale(a, b, c), this.x = c.x, this.y = c.y, this.width *= a, this.height *= b, this
            },
            maxRectScaleToFit: function(b, c) {
                b = a.Rect(b), c || (c = b.center());
                var d, e, f, g, h, i, j, k, l = c.x,
                    m = c.y;
                d = e = f = g = h = i = j = k = 1 / 0;
                var n = b.origin();
                n.x < l && (d = (this.x - l) / (n.x - l)), n.y < m && (h = (this.y - m) / (n.y - m));
                var o = b.corner();
                o.x > l && (e = (this.x + this.width - l) / (o.x - l)), o.y > m && (i = (this.y + this.height - m) / (o.y - m));
                var p = b.topRight();
                p.x > l && (f = (this.x + this.width - l) / (p.x - l)), p.y < m && (j = (this.y - m) / (p.y - m));
                var q = b.bottomLeft();
                return q.x < l && (g = (this.x - l) / (q.x - l)), q.y > m && (k = (this.y + this.height - m) / (q.y - m)), {
                    sx: Math.min(d, e, f, g),
                    sy: Math.min(h, i, j, k)
                }
            },
            maxRectUniformScaleToFit: function(a, b) {
                var c = this.maxRectScaleToFit(a, b);
                return Math.min(c.sx, c.sy)
            },
            sideNearestToPoint: function(a) {
                a = q(a);
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
            topLine: function() {
                return p(this.origin(), this.topRight())
            },
            topMiddle: function() {
                return q(this.x + this.width / 2, this.y)
            },
            topRight: function() {
                return q(this.x + this.width, this.y)
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
                return r(f, g, h - f, i - g)
            }
        };
        var s = a.normalizeAngle = function(a) {
            return a % 360 + (a < 0 ? 360 : 0)
        };
        a.scale = {
            linear: function(a, b, c) {
                var d = a[1] - a[0],
                    e = b[1] - b[0];
                return (c - a[0]) / d * e + b[0] || 0
            }
        };
        var t = a.snapToGrid = function(a, b) {
            return b * Math.round(a / b)
        }, u = a.toDeg = function(a) {
                return 180 * a / l % 360
            }, v = a.toRad = function(a, b) {
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
        }, c = "1.1",
            d = function(a, c, e) {
                if (!(this instanceof d)) return d.apply(Object.create(d.prototype), arguments);
                if (a) {
                    if (d.isV(a) && (a = a.node), c = c || {}, d.isString(a)) {
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
                        d.ensureId(a)
                    }
                    return this.node = a, this.setAttributes(c), e && this.append(e), this
                }
            };
        d.prototype.getTransformToElement = function(a) {
            return a = d.toNode(a), a.getScreenCTM().inverse().multiply(this.node.getScreenCTM())
        }, d.prototype.transform = function(a, b) {
            var c = this.node;
            if (d.isUndefined(a)) return d.transformStringToMatrix(this.attr("transform"));
            if (b && b.absolute) return this.attr("transform", d.matrixToTransformString(a));
            var e = d.createSVGTransform(a);
            return c.transform.baseVal.appendItem(e), this
        }, d.prototype.translate = function(a, b, c) {
            c = c || {}, b = b || 0;
            var e = this.attr("transform") || "",
                f = d.parseTransformString(e);
            if (e = f.value, d.isUndefined(a)) return f.translate;
            e = e.replace(/translate\([^\)]*\)/g, "").trim();
            var g = c.absolute ? a : f.translate.tx + a,
                h = c.absolute ? b : f.translate.ty + b,
                i = "translate(" + g + "," + h + ")";
            return this.attr("transform", (i + " " + e).trim()), this
        }, d.prototype.rotate = function(a, b, c, e) {
            e = e || {};
            var f = this.attr("transform") || "",
                g = d.parseTransformString(f);
            if (f = g.value, d.isUndefined(a)) return g.rotate;
            f = f.replace(/rotate\([^\)]*\)/g, "").trim(), a %= 360;
            var h = e.absolute ? a : g.rotate.angle + a,
                i = void 0 !== b && void 0 !== c ? "," + b + "," + c : "",
                j = "rotate(" + h + i + ")";
            return this.attr("transform", (f + " " + j).trim()), this
        }, d.prototype.scale = function(a, b) {
            b = d.isUndefined(b) ? a : b;
            var c = this.attr("transform") || "",
                e = d.parseTransformString(c);
            if (c = e.value, d.isUndefined(a)) return e.scale;
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
            f || this.attr("y", "0.8em"), a ? this.removeAttr("display") : this.attr("display", "none"), this.attr("xml:space", "preserve"), this.node.textContent = "";
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
            var l = 0,
                m = this.attr("x") || 0,
                n = b.lineHeight || "1em";
            "auto" === b.lineHeight && (n = "1.5em");
            for (var o = 0; o < e.length; o++) {
                var p = e[o],
                    q = d("tspan", {
                        class: "v-line",
                        dy: 0 == o ? "0em" : n,
                        x: m
                    });
                if (p)
                    if (b.annotations) {
                        for (var r = 0, s = d.annotateString(e[o], d.isArray(b.annotations) ? b.annotations : [b.annotations], {
                                offset: -l,
                                includeAnnotationIndices: b.includeAnnotationIndices
                            }), t = 0; t < s.length; t++) {
                            var u = s[t];
                            if (d.isObject(u)) {
                                var v = parseInt(u.attrs["font-size"], 10);
                                v && v > r && (r = v), c = d("tspan", u.attrs), b.includeAnnotationIndices && c.attr("annotations", u.annotations), u.attrs.class && c.addClass(u.attrs.class), c.node.textContent = u.t
                            } else c = document.createTextNode(u || " ");
                            q.append(c)
                        }
                        "auto" === b.lineHeight && r && 0 !== o && q.attr("dy", 1.2 * r + "px")
                    } else q.node.textContent = p;
                    else q.addClass("v-empty-line"), q.node.style.fillOpacity = 0, q.node.style.strokeOpacity = 0, q.node.textContent = "-";
                d(g).append(q), l += p.length + 1
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
        }, d.prototype.appendTo = function(a) {
            return d.toNode(a).appendChild(this.node), this
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
        }, d.prototype.contains = function(a) {
            var b = this.node,
                c = d.toNode(a),
                e = c && c.parentNode;
            return b === e || !! (e && 1 === e.nodeType && 16 & b.compareDocumentPosition(e))
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
            b = d.toNode(b);
            var c = d.ensureId(b),
                e = d("animateMotion", a),
                f = d("mpath", {
                    "xlink:href": "#" + c
                });
            e.append(f), this.append(e);
            try {
                e.node.beginElement()
            } catch (a) {
                if ("fake" === document.documentElement.getAttribute("smiling")) {
                    var g = e.node;
                    g.animators = [];
                    var h = g.getAttribute("id");
                    h && (id2anim[h] = g);
                    for (var i = getTargets(g), j = 0, k = i.length; j < k; j++) {
                        var l = i[j],
                            m = new Animator(g, l, j);
                        animators.push(m), g.animators[j] = m, m.register()
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
            return "v-" + ++d.idCounter
        }, d.ensureId = function(a) {
            return a.id || (a.id = d.uniqueId())
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
        }, d.transformRegex = /(\w+)\(([^,)]+),?([^)]+)?\)/gi, d.transformSeparatorRegex = /[ ,]+/, d.transformationListRegex = /^(\w+)\((.*)\)/, d.transformStringToMatrix = function(a) {
            var b = d.createSVGMatrix(),
                c = a && a.match(d.transformRegex);
            if (!c) return b;
            for (var e = 0, f = c.length; e < f; e++) {
                var g = c[e],
                    h = g.match(d.transformationListRegex);
                if (h) {
                    var i, j, k, l, m, n = d.createSVGMatrix(),
                        o = h[2].split(d.transformSeparatorRegex);
                    switch (h[1].toLowerCase()) {
                        case "scale":
                            i = parseFloat(o[0]), j = void 0 === o[1] ? i : parseFloat(o[1]), n = n.scaleNonUniform(i, j);
                            break;
                        case "translate":
                            k = parseFloat(o[0]), l = parseFloat(o[1]), n = n.translate(k, l);
                            break;
                        case "rotate":
                            m = parseFloat(o[0]), k = parseFloat(o[1]) || 0, l = parseFloat(o[2]) || 0, n = 0 !== k || 0 !== l ? n.translate(k, l).rotate(m).translate(-k, -l) : n.rotate(m);
                            break;
                        case "skewx":
                            m = parseFloat(o[0]), n = n.skewX(m);
                            break;
                        case "skewy":
                            m = parseFloat(o[0]), n = n.skewY(m);
                            break;
                        case "matrix":
                            n.a = parseFloat(o[0]), n.b = parseFloat(o[1]), n.c = parseFloat(o[2]), n.d = parseFloat(o[3]), n.e = parseFloat(o[4]), n.f = parseFloat(o[5]);
                            break;
                        default:
                            continue
                    }
                    b = b.multiply(n)
                }
            }
            return b
        }, d.matrixToTransformString = function(a) {
            return a || (a = !0), "matrix(" + (a.a || 1) + "," + (a.b || 0) + "," + (a.c || 0) + "," + (a.d || 1) + "," + (a.e || 0) + "," + (a.f || 0) + ")"
        }, d.parseTransformString = function(a) {
            var b, c, e;
            if (a) {
                var f = d.transformSeparatorRegex;
                if (a.trim().indexOf("matrix") >= 0) {
                    var g = d.transformStringToMatrix(a),
                        h = d.decomposeMatrix(g);
                    b = [h.translateX, h.translateY], e = [h.scaleX, h.scaleY], c = [h.rotation];
                    var i = [];
                    0 === b[0] && 0 === b[0] || i.push("translate(" + b + ")"), 1 === e[0] && 1 === e[1] || i.push("scale(" + e + ")"), 0 !== c[0] && i.push("rotate(" + c + ")"), a = i.join(" ")
                } else {
                    var j = a.match(/translate\((.*)\)/);
                    j && (b = j[1].split(f));
                    var k = a.match(/rotate\((.*)\)/);
                    k && (c = k[1].split(f));
                    var l = a.match(/scale\((.*)\)/);
                    l && (e = l[1].split(f))
                }
            }
            var m = e && e[0] ? parseFloat(e[0]) : 1;
            return {
                value: a,
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
                    sx: m,
                    sy: e && e[1] ? parseFloat(e[1]) : m
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
        }, d.matrixToScale = function(a) {
            var b, c, e, f;
            return a ? (b = d.isUndefined(a.a) ? 1 : a.a, f = d.isUndefined(a.d) ? 1 : a.d, c = a.b, e = a.c) : b = f = 1, {
                sx: c ? Math.sqrt(b * b + c * c) : b,
                sy: e ? Math.sqrt(e * e + f * f) : f
            }
        }, d.matrixToRotate = function(a) {
            var b = {
                x: 0,
                y: 1
            };
            return a && (b = d.deltaTransformPoint(a, b)), {
                angle: g.normalizeAngle(g.toDeg(Math.atan2(b.y, b.x)) - 90)
            }
        }, d.matrixToTranslate = function(a) {
            return {
                tx: a && a.e || 0,
                ty: a && a.f || 0
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
            var h = c.matrixTransform(b);
            c.x = a.x, c.y = a.y + a.height;
            var i = c.matrixTransform(b),
                j = Math.min(d.x, f.x, h.x, i.x),
                k = Math.max(d.x, f.x, h.x, i.x),
                l = Math.min(d.y, f.y, h.y, i.y),
                m = Math.max(d.y, f.y, h.y, i.y);
            return g.Rect(j, l, k - j, m - l)
        }, d.transformPoint = function(a, b) {
            return g.Point(d.createSVGPoint(a.x, a.y).matrixTransform(b))
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
            return a = d(a), d.rectToPath({
                x: parseFloat(a.attr("x")) || 0,
                y: parseFloat(a.attr("y")) || 0,
                width: parseFloat(a.attr("width")) || 0,
                height: parseFloat(a.attr("height")) || 0,
                rx: parseFloat(a.attr("rx")) || 0,
                ry: parseFloat(a.attr("ry")) || 0
            })
        }, d.rectToPath = function(a) {
            var b, c = a.x,
                d = a.y,
                e = a.width,
                f = a.height,
                g = Math.min(a.rx || a["top-rx"] || 0, e / 2),
                h = Math.min(a.rx || a["bottom-rx"] || 0, e / 2),
                i = Math.min(a.ry || a["top-ry"] || 0, f / 2),
                j = Math.min(a.ry || a["bottom-ry"] || 0, f / 2);
            return b = g || h || i || j ? ["M", c, d + i, "v", f - i - j, "a", h, j, 0, 0, 0, h, j, "h", e - 2 * h, "a", h, j, 0, 0, 0, h, -j, "v", -(f - j - i), "a", g, i, 0, 0, 0, -g, -i, "h", -(e - 2 * g), "a", g, i, 0, 0, 0, -g, i, "Z"] : ["M", c, d, "H", c + e, "V", d + f, "H", c, "V", d, "Z"], b.join(" ")
        }, d.toNode = function(a) {
            return d.isV(a) ? a.node : a.nodeName && a || a[0]
        }, d
    }();
    var joint = {
        version: "1.1.0",
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
                for (var d, e = _.isArray(b) ? b.slice() : b.split(c || "/"); e.length;) {
                    if (d = e.shift(), !(Object(a) === a && d in a)) return;
                    a = a[d]
                }
                return a
            },
            setByPath: function(a, b, c, d) {
                for (var e = _.isArray(b) ? b : b.split(d || "/"), f = a, g = 0, h = e.length; g < h - 1; g++) f = f[e[g]] || (f[e[g]] = {});
                return f[e[h - 1]] = c, a
            },
            unsetByPath: function(a, b, c) {
                c = c || "/";
                var d = _.isArray(b) ? b.slice() : b.split(c),
                    e = d.pop();
                if (d.length > 0) {
                    var f = joint.util.getByPath(a, d, c);
                    f && delete f[e]
                } else delete a[e];
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
            toKebabCase: function(a) {
                return a.replace(/[A-Z]/g, "-$&").toLowerCase()
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
            parseCssNumeric: function(a, b) {
                b = b || [];
                var c = {
                    value: parseFloat(a)
                };
                if (_.isNaN(c.value)) return null;
                var d = b.join("|");
                if (_.isString(a)) {
                    var e = new RegExp("(\\d+)(" + d + ")$").exec(a);
                    if (!e) return null;
                    e[2] && (c.unit = e[2])
                }
                return c
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
                for (var k, l, m = a.split(" "), n = [], o = [], p = 0, q = 0, r = m.length; p < r; p++) {
                    var s = m[p];
                    if (j.data = o[q] ? o[q] + " " + s : s, i.getComputedTextLength() <= e) o[q] = j.data, k && (n[q++] = !0, k = 0);
                    else {
                        if (!o[q] || k) {
                            var t = !! k;
                            if (k = s.length - 1, t || !k) {
                                if (!k) {
                                    if (!o[q]) {
                                        o = [];
                                        break
                                    }
                                    m.splice(p, 2, s + m[p + 1]), r--, n[q++] = !0, p--;
                                    continue
                                }
                                m[p] = s.substring(0, k), m[p + 1] = s.substring(k) + m[p + 1]
                            } else m.splice(p, 1, s.substring(0, k), s.substring(k)), r++, q && !n[q - 1] && q--;
                            p--;
                            continue
                        }
                        q++, p--
                    } if (void 0 !== f) {
                        if (void 0 === l) {
                            var u;
                            u = "auto" === c.lineHeight ? {
                                value: 1.5,
                                unit: "em"
                            } : joint.util.parseCssNumeric(c.lineHeight, ["em"]) || {
                                value: 1,
                                unit: "em"
                            }, l = u.value, "em" === u.unit && (l *= h.getBBox().height)
                        }
                        if (l * o.length > f) {
                            o.splice(Math.floor(f / l));
                            break
                        }
                    }
                }
                return d.svgDocument ? g.removeChild(h) : document.body.removeChild(g), o.join("\n")
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
                }, d = function(b, c) {
                        var d = function(a) {
                            for (var b = 32768, c = [], d = 0; d < a.length; d += b) c.push(String.fromCharCode.apply(null, a.subarray(d, d + b)));
                            return c.join("")
                        };
                        if (200 === b.status) {
                            var e = new Uint8Array(b.response),
                                f = a.split(".").pop() || "png",
                                g = {
                                    svg: "svg+xml"
                                }, h = "data:image/" + (g[f] || f) + ";base64,",
                                i = h + btoa(d(e));
                            c(null, i)
                        } else c(new Error("Failed to load image " + a))
                    }, e = new XMLHttpRequest;
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
                a = a || document.body, b(document, "FullscreenElement") || b(document, "FullScreenElement") ? b(document, "ExitFullscreen") || b(document, "CancelFullScreen") : b(a, "RequestFullscreen") || b(a, "RequestFullScreen")
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
                        return _.isArray(c) || (d instanceof joint.dia.Cell ? c = b : c instanceof joint.dia.Cell && (c = b.length > 1 ? _.initial(b) : b)), d instanceof joint.dia.Cell && (d = {}), a.call(this, c, d)
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
            this.requireSetThemeOverride = a && !! a.theme, this.options = _.extend({}, this.options, a), _.bindAll(this, "setTheme", "onSetTheme", "remove", "onRemove"), joint.mvc.views[this.cid] = this, this.setTheme(this.options.theme || this.defaultTheme), this._ensureElClassName(), this.init()
        },
        _ensureElement: function() {
            var a;
            if (this.svgElement) {
                if (this.el) a = _.result(this, "el");
                else {
                    var b = _.extend({
                        id: this.id
                    }, _.result(this, "attributes"));
                    this.className && (b.class = _.result(this, "className")), a = V(_.result(this, "tagName"), b).node
                }
                this.setElement(a, !1)
            } else Backbone.View.prototype._ensureElement.call(this)
        },
        _setElement: function(a) {
            this.svgElement ? (this.$el = a instanceof Backbone.$ ? a : Backbone.$(a), this.el = this.$el[0], this.vel = V(this.el)) : Backbone.View.prototype._setElement.call(this, a)
        },
        _ensureElClassName: function() {
            var a = _.result(this, "className"),
                b = joint.util.addClassNamePrefix(a);
            this.$el.removeClass(a), this.$el.addClass(b)
        },
        init: function() {},
        onRender: function() {},
        setTheme: function(a, b) {
            return b = b || {}, this.theme && this.requireSetThemeOverride && !b.override ? this : (this.removeThemeClassName(), this.addThemeClassName(a), this.onSetTheme(this.theme, a), this.theme = a, this)
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
        onRemove: function() {},
        getEventNamespace: function() {
            return ".joint-event-ns-" + this.cid
        }
    }, {
        extend: function() {
            var a = Array.prototype.slice.call(arguments),
                b = a[0] && _.clone(a[0]) || {}, c = a[1] && _.clone(a[1]) || {}, d = b.render || this.prototype && this.prototype.render || null;
            return b.render = function() {
                return d && d.apply(this, arguments), this.onRender(), this
            }, Backbone.View.extend.call(this, b, c)
        }
    }), joint.dia.GraphCells = Backbone.Collection.extend({
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
                d = {}, e = [],
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
            var d = {}, e = {}, f = [];
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
            var f = d || {}, g = e || 0;
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
    }), joint.util.wrapWith(joint.dia.Graph.prototype, ["resetCells", "addCells", "removeCells"], "cells"),
    function(a, b, c, d) {
        function e(a) {
            return b.isString(a) && "%" === a.slice(-1)
        }

        function f(a, b) {
            return function(c, d) {
                var f = e(c);
                c = parseFloat(c), f && (c /= 100);
                var g = {};
                if (isFinite(c)) {
                    var h = f || c >= 0 && c <= 1 ? c * d[b] : Math.max(c + d[b], 0);
                    g[a] = h
                }
                return g
            }
        }

        function g(a, b, d) {
            return function(f, g) {
                var h = e(f);
                f = parseFloat(f), h && (f /= 100);
                var i;
                if (isFinite(f)) {
                    var j = g[d]();
                    i = h || f > 0 && f < 1 ? j[a] + g[b] * f : j[a] + f
                }
                var k = c.Point();
                return k[a] = i || 0, k
            }
        }

        function h(a, b, d) {
            return function(f, g) {
                var h;
                h = "middle" === f ? g[b] / 2 : f === d ? g[b] : isFinite(f) ? f > -1 && f < 1 ? -g[b] * f : -f : e(f) ? g[b] * parseFloat(f) / 100 : 0;
                var i = c.Point();
                return i[a] = -(g[a] + h), i
            }
        }
        var i = a.dia.attributes = {
            xlinkHref: {
                set: "xlink:href"
            },
            xmlSpace: {
                set: "xml:space"
            },
            filter: {
                qualify: b.isPlainObject,
                set: function(a) {
                    return "url(#" + this.paper.defineFilter(a) + ")"
                }
            },
            fill: {
                qualify: b.isPlainObject,
                set: function(a) {
                    return "url(#" + this.paper.defineGradient(a) + ")"
                }
            },
            stroke: {
                qualify: b.isPlainObject,
                set: function(a) {
                    return "url(#" + this.paper.defineGradient(a) + ")"
                }
            },
            sourceMarker: {
                qualify: b.isPlainObject,
                set: function(a) {
                    return {
                        "marker-start": "url(#" + this.paper.defineMarker(a) + ")"
                    }
                }
            },
            targetMarker: {
                qualify: b.isPlainObject,
                set: function(a) {
                    return a = b.assign({
                        transform: "rotate(180)"
                    }, a), {
                        "marker-end": "url(#" + this.paper.defineMarker(a) + ")"
                    }
                }
            },
            vertexMarker: {
                qualify: b.isPlainObject,
                set: function(a) {
                    return {
                        "marker-mid": "url(#" + this.paper.defineMarker(a) + ")"
                    }
                }
            },
            text: {
                set: function(a, c, e, f) {
                    var g = d(e),
                        h = "joint-text",
                        i = g.data(h),
                        j = b.pick(f, "lineHeight", "annotations", "textPath"),
                        k = j.fontSize = f["font-size"] || f.fontSize,
                        l = JSON.stringify([a, j]);
                    void 0 !== i && i === l || (k && e.setAttribute("font-size", k), V(e).text("" + a, j), g.data(h, l))
                }
            },
            textWrap: {
                qualify: b.isPlainObject,
                set: function(b, c, d, f) {
                    var g = b.width || 0;
                    e(g) ? c.width *= parseFloat(g) / 100 : g <= 0 ? c.width += g : c.width = g;
                    var h = b.height || 0;
                    e(h) ? c.height *= parseFloat(h) / 100 : h <= 0 ? c.height += h : c.height = h;
                    var i = a.util.breakText("" + b.text, c, {
                        "font-weight": f["font-weight"] || f.fontWeight,
                        "font-size": f["font-size"] || f.fontSize,
                        "font-family": f["font-family"] || f.fontFamily
                    }, {
                        svgDocument: this.paper.svg
                    });
                    V(d).text(i)
                }
            },
            lineHeight: {
                qualify: function(a, b, c) {
                    return void 0 !== c.text
                }
            },
            textPath: {
                qualify: function(a, b, c) {
                    return void 0 !== c.text
                }
            },
            annotations: {
                qualify: function(a, b, c) {
                    return void 0 !== c.text
                }
            },
            port: {
                set: function(a) {
                    return null === a || void 0 === a.id ? a : a.id
                }
            },
            style: {
                qualify: b.isPlainObject,
                set: function(a, b, c) {
                    d(c).css(a)
                }
            },
            html: {
                set: function(a, b, c) {
                    d(c).html(a + "")
                }
            },
            ref: {},
            refX: {
                position: g("x", "width", "origin")
            },
            refY: {
                position: g("y", "height", "origin")
            },
            refDx: {
                position: g("x", "width", "corner")
            },
            refDy: {
                position: g("y", "height", "corner")
            },
            refWidth: {
                set: f("width", "width")
            },
            refHeight: {
                set: f("height", "height")
            },
            refRx: {
                set: f("rx", "width")
            },
            refRy: {
                set: f("ry", "height")
            },
            refCx: {
                set: f("cx", "width")
            },
            refCy: {
                set: f("cy", "height")
            },
            xAlignment: {
                offset: h("x", "width", "right")
            },
            yAlignment: {
                offset: h("y", "height", "bottom")
            }
        };
        i.refX2 = i.refX, i.refY2 = i.refY, i["ref-x"] = i.refX, i["ref-y"] = i.refY, i["ref-dy"] = i.refDy, i["ref-dx"] = i.refDx, i["ref-width"] = i.refWidth, i["ref-height"] = i.refHeight, i["x-alignment"] = i.xAlignment, i["y-alignment"] = i.yAlignment
    }(joint, _, g, $), joint.dia.Cell = Backbone.Model.extend({
        constructor: function(a, b) {
            //var c, d = a || {};
            //this.cid = _.uniqueId("c"), this.attributes = {}, b && b.collection && (this.collection = b.collection), b && b.parse && (d = this.parse(d, b) || {}), (c = _.result(this, "defaults")) && (d = _.merge({}, c, d)), this.set(d, b), this.changed = {}, this.initialize.apply(this, arguments)
            var c, d = a || {};
            this.cid = _.uniqueId("c"); 
            this.attributes = {};
            b && b.collection && (this.collection = b.collection);
            b && b.parse && (d = this.parse(d, b) || {});
            (c = _.result(this, "defaults")) && (d = _.merge({}, c, d));
            this.set(d, b);
            this.changed = {};
            this.initialize.apply(this, arguments);
        },
        translate: function(a, b, c) {
            throw new Error("Must define a translate() method.")
        },
        toJSON: function() {
            var a = this.constructor.prototype.defaults.attrs || {}, b = this.attributes.attrs,
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
            var d = "/",
                e = _.isString(a);
            if (e || _.isArray(a)) {
                if (arguments.length > 1) {
                    var f, g;
                    e ? (f = a, g = f.split("/")) : (f = a.join(d), g = a.slice());
                    var h = g[0],
                        i = g.length;
                    if (c = c || {}, c.propertyPath = f, c.propertyValue = b, c.propertyPathArray = g, 1 === i) return this.set(h, b, c);
                    for (var j = {}, k = j, l = h, m = 1; m < i; m++) {
                        var n = g[m],
                            o = _.isFinite(e ? Number(n) : n);
                        k = k[l] = o ? [] : {}, l = n
                    }
                    j = joint.util.setByPath(j, g, b, "/");
                    var p = _.merge({}, this.attributes);
                    c.rewrite && joint.util.unsetByPath(p, f, "/");
                    var q = _.merge(p, j);
                    return this.set(h, q[h], c)
                }
                return joint.util.getByPath(this.attributes, a, d)
            }
            return this.set(_.merge({}, this.attributes, a), b)
        },
        removeProp: function(a, b) {
            b = b || {}, b.dirty = !0;
            var c = _.isArray(a) ? a : a.split("/");
            if (1 === c.length) return this.unset(a, b);
            var d = c[0],
                e = c.slice(1),
                f = _.merge({}, this.get(d));
            return joint.util.unsetByPath(f, e, "/"), this.set(d, f, b)
        },
        attr: function(a, b, c) {
            var d = Array.prototype.slice.call(arguments);
            return 0 === d.length ? this.get("attrs") : (_.isArray(a) ? d[0] = ["attrs"].concat(a) : _.isString(a) ? d[0] = "attrs/" + a : d[0] = {
                attrs: a
            }, this.prop.apply(this, d))
        },
        removeAttr: function(a, b) {
            return _.isArray(a) ? this.removeProp(["attrs"].concat(a)) : this.removeProp("attrs/" + a, b)
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
    }, {
        getAttributeDefinition: function(a) {
            var b = this.attributes,
                c = joint.dia.attributes;
            return b && b[a] || c[a]
        },
        define: function(a, b, c, d) {
            c = _.assign({
                defaults: _.defaultsDeep({
                    type: a
                }, b, this.prototype.defaults)
            }, c);
            var e = this.extend(c, d);
            return joint.util.setByPath(joint.shapes, a, e, "."), e
        }
    }), joint.dia.CellView = joint.mvc.View.extend({
        tagName: "g",
        svgElement: !0,
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
        findBySelector: function(a, b) {
            var c = $(b || this.el);
            return "." === a ? c : c.find(a)
        },
        notify: function(a) {
            if (this.paper) {
                var b = Array.prototype.slice.call(arguments, 1);
                this.trigger.apply(this, [a].concat(b)), this.paper.trigger.apply(this.paper, [a, this].concat(b))
            }
        },
        getStrokeBBox: function(a) {
            var b = !! a;
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
        getSelector: function(a, b) {
            if (a === this.el) return b;
            var c;
            if (a) {
                var d = V(a).index() + 1;
                c = a.tagName + ":nth-child(" + d + ")", b && (c += " > " + b), c = this.getSelector(a.parentNode, c)
            }
            return c
        },
        getAttributeDefinition: function(a) {
            return this.model.constructor.getAttributeDefinition(a)
        },
        setNodeAttributes: function(a, b) {
            _.isEmpty(b) || (a instanceof SVGElement ? V(a).attr(b) : $(a).attr(b))
        },
        processNodeAttributes: function(a, b) {
            var c, d, e, f, g, h, i, j, k, l = [];
            for (c in b) b.hasOwnProperty(c) && (d = b[c], e = this.getAttributeDefinition(c), !e || _.isFunction(e.qualify) && !e.qualify.call(this, d, a, b) ? (h || (h = {}), h[joint.util.toKebabCase(c)] = d) : (_.isString(e.set) && (h || (h = {}), h[e.set] = d), null !== d && l.push(c, e)));
            for (f = 0, g = l.length; f < g; f += 2) c = l[f], e = l[f + 1], d = b[c], _.isFunction(e.set) && (i || (i = {}), i[c] = d), _.isFunction(e.position) && (j || (j = {}), j[c] = d), _.isFunction(e.offset) && (k || (k = {}), k[c] = d);
            return {
                raw: b,
                normal: h,
                set: i,
                position: j,
                offset: k
            }
        },
        updateRelativeAttributes: function(a, b, c, d) {
            d || (d = {});
            var e, f, h, i = b.raw || {}, j = b.normal || {}, k = b.set,
                l = b.position,
                m = b.offset;
            for (e in k) {
                f = k[e], h = this.getAttributeDefinition(e);
                var n = h.set.call(this, f, c.clone(), a, i);
                _.isObject(n) ? _.extend(j, n) : void 0 !== n && (j[e] = n)
            }
            if (a instanceof HTMLElement) return void this.setNodeAttributes(a, j);
            var o = j.transform || "",
                p = V.transformStringToMatrix(o),
                q = g.Point(p.e, p.f);
            o && (j = _.omit(j, "transform"), p.e = p.f = 0);
            var r, s, t;
            if (l || m) {
                var u = this.getNodeScale(a, d.scalableNode);
                r = u.sx, s = u.sy
            }
            for (e in l) f = l[e], h = this.getAttributeDefinition(e), t = h.position.call(this, f, c.clone(), a, i), t && q.offset(g.Point(t).scale(r, s));
            if (this.setNodeAttributes(a, j), m) {
                var v = a.getBoundingClientRect();
                if (v.width > 0 && v.height > 0) {
                    var w = V.transformRect(a.getBBox(), p).scale(1 / r, 1 / s);
                    for (e in m) f = m[e], h = this.getAttributeDefinition(e), t = h.offset.call(this, f, w, a, i), t && q.offset(g.Point(t).scale(r, s))
                }
            }
            q.round(1), p.e = q.x, p.f = q.y, a.setAttribute("transform", V.matrixToTransformString(p))
        },
        getNodeScale: function(a, b) {
            var c, d;
            if (b && b.contains(a)) {
                var e = b.scale();
                c = 1 / e.sx, d = 1 / e.sy
            } else c = 1, d = 1;
            return {
                sx: c,
                sy: d
            }
        },
        findNodesAttributes: function(a, b, c) {
            var d = {};
            for (var e in a)
                if (a.hasOwnProperty(e))
                    for (var f = c[e] = this.findBySelector(e, b), g = 0, h = f.length; g < h; g++) {
                        var i = f[g],
                            j = V.ensureId(i),
                            k = a[e],
                            l = d[j];
                        l ? (l.merged || (l.merged = !0, l.attributes = _.cloneDeep(l.attributes)), _.merge(l.attributes, k)) : d[j] = {
                            attributes: k,
                            node: i,
                            merged: !1
                        }
                    }
                return d
        },
        updateDOMSubtreeAttributes: function(a, b, c) {
            c || (c = {}), c.rootBBox || (c.rootBBox = g.Rect());
            var d, e, f, h, i, j = {}, k = {}, l = [],
                m = c.roAttributes,
                n = this.findNodesAttributes(m || b, a, j),
                o = m ? o = this.findNodesAttributes(b, a, j) : n;
            for (var p in n)
                if (h = n[p], f = h.attributes, e = h.node, i = this.processNodeAttributes(e, f), i.set || i.position || i.offset) {
                    var q, r = o[p] && o[p].attributes,
                        s = r && void 0 === f.ref ? r.ref : f.ref;
                    if (s) {
                        if (q = (j[s] || this.findBySelector(s, a))[0], !q) throw new Error('dia.ElementView: "' + s + '" reference does not exists.')
                    } else q = null;
                    d = {
                        node: e,
                        refNode: q,
                        processedAttributes: i,
                        allAttributes: r
                    };
                    var t = _.findIndex(l, {
                        refNode: e
                    });
                    t > -1 ? l.splice(t, 0, d) : l.push(d)
                } else this.setNodeAttributes(e, i.normal);
            for (var u = 0, v = l.length; u < v; u++) {
                d = l[u], e = d.node, q = d.refNode;
                var w = q ? V.ensureId(q) : "",
                    x = k[w];
                x || (x = k[w] = q ? V(q).bbox(!1, c.rotatableNode || a) : c.rootBBox), m ? (i = this.processNodeAttributes(e, d.allAttributes), this.mergeProcessedAttributes(i, d.processedAttributes)) : i = d.processedAttributes, this.updateRelativeAttributes(e, i, x, c)
            }
        },
        mergeProcessedAttributes: function(a, b) {
            a.set || (a.set = {}), a.position || (a.position = {}), a.offset || (a.offset = {}), _.extend(a.set, b.set), _.extend(a.position, b.position), _.extend(a.offset, b.offset);
            var c = a.normal && a.normal.transform;
            void 0 !== c && b.normal && (b.normal.transform = c), a.normal = b.normal
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
            this.notify("cell:pointermove", a, b, c);
			//console.log("pointermove:" + this.arguments );
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
        mouseenter: function(a) {
            this.notify("cell:mouseenter", a)
        },
        mouseleave: function(a) {
            this.notify("cell:mouseleave", a)
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
        size: function(a, b, c) {
            var d = this.get("size");
            return void 0 === a ? {
                width: d.width,
                height: d.height
            } : (_.isObject(a) && (c = b, b = _.isNumber(a.height) ? a.height : d.height, a = _.isNumber(a.width) ? a.width : d.width), this.resize(a, b, c))
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
                }), this.position(g.x + h, g.y + i, d), this.rotate(a, b, null, d), this.stopBatch("rotate")
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
        update: function(a, b) {
            this._removePorts();
            var c = this.model,
                d = c.attr();
            this.updateDOMSubtreeAttributes(this.el, d, {
                rootBBox: g.Rect(c.size()),
                scalableNode: this.scalableNode,
                rotatableNode: this.rotatableNode,
                roAttributes: b === d ? null : b
            }), this._renderPorts()
        },
        renderMarkup: function() {
            var a = this.model.get("markup") || this.model.markup;
            if (!a) throw new Error("properties.markup is missing while the default render() implementation is used.");
            var b = joint.util.template(a)(),
                c = V(b);
            this.vel.append(c)
        },
        render: function() {
            this.$el.empty(), this.renderMarkup(), this.rotatableNode = this.vel.findOne(".rotatable");
            var a = this.scalableNode = this.vel.findOne(".scalable");
            return a && this.update(), this.resize(), this.rotate(), this.translate(), this
        },
        resize: function(a, b, c) {
            var d = this.model,
                e = d.get("size") || {
                    width: 1,
                    height: 1
                }, f = d.get("angle") || 0,
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
                    }, d = c.width / 2,
                    e = c.height / 2;
                0 !== b ? a.attr("transform", "rotate(" + b + "," + d + "," + e + ")") : a.removeAttr("transform")
            }
        },
        getBBox: function(a) {
            if (a && a.useModelGeometry) {
                var b = this.model.getBBox().bbox(this.model.get("angle"));
                return this.paper.localToPaperRect(b)
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
        },
        mouseenter: function(a) {
            joint.dia.CellView.prototype.mouseenter.apply(this, arguments), this.notify("element:mouseenter", a)
        },
        mouseleave: function(a) {
            joint.dia.CellView.prototype.mouseleave.apply(this, arguments), this.notify("element:mouseleave", a)
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
        label: function(a, b, c) {
            return a = a || 0, arguments.length <= 1 ? this.prop(["labels", a]) : this.prop(["labels", a], b, c)
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
            var c = {}, d = this.get("source");
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
            var a = this._V.labels;
            if (!a) return this;
            a.empty();
            var b = this.model,
                c = b.get("labels") || [],
                d = this._labelCache = {}, e = c.length;
            if (0 === e) return this;
            for (var f = joint.util.template(b.get("labelMarkup") || b.labelMarkup), g = V(f()), h = this.can("labelMove"), i = 0; i < e; i++) {
                var j = c[i],
                    k = j.markup,
                    l = d[i] = k ? V("g").append(V(k)) : g.clone();
                l.addClass("label").attr({
                    "label-idx": i,
                    cursor: h ? "move" : "default"
                }).appendTo(a);
                var m = j.attrs;
                k || (m = _.merge({
                    text: {
                        textAnchor: "middle",
                        fontSize: 14,
                        pointerEvents: "none",
                        yAlignment: "middle"
                    },
                    rect: {
                        ref: "text",
                        fill: "white",
                        rx: 3,
                        ry: 3,
                        refWidth: 1,
                        refHeight: 1,
                        refX: 0,
                        refY: 0
                    }
                }, m)), this.updateDOMSubtreeAttributes(l.node, m)
            }
            return this
        },
        renderTools: function() {
            if (!this._V.linkTools) return this;
            var a = $(this._V.linkTools.node).empty(),
                b = joint.util.template(this.model.get("toolMarkup") || this.model.toolMarkup),
                c = V(b());
            if (a.append(c.node), this._toolCache = c, this.options.doubleLinkTools) {
                var d;
                this.model.get("doubleToolMarkup") || this.model.doubleToolMarkup ? (b = joint.util.template(this.model.get("doubleToolMarkup") || this.model.doubleToolMarkup),
                    d = V(b())) : d = c.clone(), a.append(d.node), this._tool2Cache = d
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
            return c = c || {}, c.updateConnectionOnly || this.updateDOMSubtreeAttributes(this.el, this.model.attr()), this.updateConnection(c), this.updateLabelPositions(), this.updateToolsPosition(), this.updateArrowheadMarkers(), this.options.perpendicular = null, this.updatePostponed = !1, this
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
        _findConnectionPoints: function(a) {
            var b, c, d, e, f = _.first(a);
            b = this.getConnectionPoint("source", this.model.get("source"), f || this.model.get("target")).round();
            var h = _.last(a);
            c = this.getConnectionPoint("target", this.model.get("target"), h || b).round();
            var i = this._markerCache;
            this._V.markerSource && (i.sourceBBox = i.sourceBBox || this._V.markerSource.bbox(!0), d = g.point(b).move(f || c, i.sourceBBox.width * this._V.markerSource.scale().sx * -1).round()), this._V.markerTarget && (i.targetBBox = i.targetBBox || this._V.markerTarget.bbox(!0), e = g.point(c).move(h || b, i.targetBBox.width * this._V.markerTarget.scale().sx * -1).round()), i.sourcePoint = d || b.clone(), i.targetPoint = e || c.clone(), this.sourcePoint = b, this.targetPoint = c
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
                    _.isFinite(h) ? (h = h > c ? c : h, h = h < 0 ? c + h : h, h = h > 1 ? h : c * h) : h = c / 2;
                    var j = b.getPointAtLength(h);
                    if (_.isObject(i)) j = g.point(j).offset(i);
                    else if (_.isFinite(i)) {
                        d || (d = this._samples || this._V.connection.sample(this.options.sampleInterval));
                        for (var k, l, m, n = 1 / 0, o = 0; o < d.length; o++) l = d[o], m = g.line(l, j).squaredLength(), m < n && (n = m, k = o);
                        var p = d[k - 1],
                            q = d[k + 1],
                            r = 0;
                        q ? r = g.point(j).theta(q) : p && (r = g.point(p).theta(j)), j = g.point(j).offset(i).rotate(j, r - 90)
                    }
                    this._labelCache[e].attr("transform", "translate(" + j.x + ", " + j.y + ")")
                }, this)
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
                    j = e.get(i) || {}, k = j.id && this.constructor.makeSelector(j);
                if (c.handleBy === this.cid && h == k) this[a + "BBox"] = this[i + "BBox"], this[a + "View"] = this[i + "View"], this[a + "Magnet"] = this[i + "Magnet"];
                else if (c.translateBy) {
                    var l = this[a + "BBox"];
                    l.x += c.tx, l.y += c.ty
                } else {
                    var m = this.paper.findViewByModel(f.id),
                        n = m.el.querySelector(h);
                    this[a + "BBox"] = m.getStrokeBBox(n), this[a + "View"] = m, this[a + "Magnet"] = n
                } if (c.handleBy === this.cid && c.translateBy && e.isEmbeddedIn(b) && !_.isEmpty(e.get("vertices")) && (d = !1), !this.updatePostponed && j.id) {
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
            var e = c.args || {}, f = _.isFunction(c) ? c : b[c.name];
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
                        null != k && (l.port = k), null != j && (l.selector = j), this.model.set(g, l, {
                            ui: !0
                        })
                    }
                } if (!e.linkAllowed(this)) switch (this._whenNotAllowed) {
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
                var m = this.model.prop(g) || {}, n = !joint.dia.Link.endsEqual(h, m);
                n && (h.id && this.notify("link:disconnect", a, e.findViewByModel(h.id), this._initialMagnet, g), m.id && this.notify("link:connect", a, e.findViewByModel(m.id), d, g)), this._afterArrowheadMove()
            }
            this._action = null, this._whenNotAllowed = null, this._initialMagnet = null, this._initialEnd = null, this._validateConnectionArgs = null, this.notify("link:pointerup", a, b, c), joint.dia.CellView.prototype.pointerup.apply(this, arguments)
        },
        mouseenter: function(a) {
            joint.dia.CellView.prototype.mouseenter.apply(this, arguments), this.notify("link:mouseenter", a)
        },
        mouseleave: function(a) {
            joint.dia.CellView.prototype.mouseleave.apply(this, arguments), this.notify("link:mouseleave", a)
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
            background: !1,
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
            DOMMouseScroll: "mousewheel",
            "mouseenter .joint-cell": "cellMouseenter",
            "mouseleave .joint-cell": "cellMouseleave"
        },
        _highlights: {},
        init: function() {
            _.bindAll(this, "pointerup");
            var a = this.model = this.options.model || new joint.dia.Graph;
            this.setGrid(this.options.drawGrid), this.cloneOptions(), this.render(), this.setDimensions(), this.listenTo(a, "add", this.onCellAdded).listenTo(a, "remove", this.removeView).listenTo(a, "reset", this.resetViews).listenTo(a, "sort", this._onSort).listenTo(a, "batch:stop", this._onBatchStop), this.on("cell:highlight", this.onCellHighlight).on("cell:unhighlight", this.onCellUnhighlight).on("scale translate", this.update), this._mousemoved = 0, this._views = {}, this.$document = $(this.el.ownerDocument)
        },
        cloneOptions: function() {
            var a = this.options;
            a.origin = _.clone(a.origin), a.defaultConnector = _.clone(a.defaultConnector), a.highlighting = _.defaultsDeep({}, a.highlighting, this.constructor.prototype.options.highlighting)
        },
        bindDocumentEvents: function() {
            var a = this.getEventNamespace();
            this.$document.on("mouseup" + a + " touchend" + a, this.pointerup)
        },
        unbindDocumentEvents: function() {
            this.$document.off(this.getEventNamespace())
        },
        render: function() {
            return this.$el.empty(), this.svg = V("svg").attr({
                width: "100%",
                height: "100%"
            }).node, this.viewport = V("g").addClass(joint.util.addClassNamePrefix("viewport")).node, this.defs = V("defs").node, V(this.svg).append([this.viewport, this.defs]), this.$background = $("<div/>").addClass(joint.util.addClassNamePrefix("paper-background")), this.options.background && this.drawBackground(this.options.background), this.$grid = $("<div/>").addClass(joint.util.addClassNamePrefix("paper-grid")), this.options.drawGrid && this.drawGrid(), this.$el.append(this.$background, this.$grid, this.svg), this
        },
        update: function() {
            this.options.drawGrid && this.drawGrid(), this._background && this.updateBackgroundImage(this._background)
        },
        _viewportMatrix: null,
        _viewportTransformString: null,
        matrix: function(a) {
            var b = this.viewport;
            if (void 0 === a) {
                var c = b.getAttribute("transform");
                return (this._viewportTransformString || null) === c ? a = this._viewportMatrix : (a = b.getCTM(), this._viewportMatrix = a, this._viewportTransformString = c), V.createSVGMatrix(a)
            }
            return a = V.createSVGMatrix(a), V(b).transform(a, {
                absolute: !0
            }), this._viewportMatrix = a, this._viewportTransformString = b.getAttribute("transform"), this
        },
        clientMatrix: function() {
            return V.createSVGMatrix(this.viewport.getScreenCTM())
        },
        _onSort: function() {
            this.model.hasActiveBatch("add") || this.sortViews()
        },
        _onBatchStop: function(a) {
            var b = a && a.batchName;
            "add" !== b || this.model.hasActiveBatch("add") || this.sortViews()
        },
        onRemove: function() {
            this.removeViews(), this.unbindDocumentEvents()
        },
        setDimensions: function(a, b) {
            a = this.options.width = a || this.options.width, b = this.options.height = b || this.options.height, this.$el.css({
                width: Math.round(a),
                height: Math.round(b)
            }), this.trigger("resize", a, b)
        },
        setOrigin: function(a, b) {
            return this.translate(a || 0, b || 0, {
                absolute: !0
            })
        },
        fitToContent: function(a, b, c, d) {
            _.isObject(a) ? (d = a, a = d.gridWidth || 1, b = d.gridHeight || 1, c = d.padding || 0) : (d = d || {}, a = a || 1, b = b || 1, c = c || 0), c = joint.util.normalizeSides(c);
            var e = V(this.viewport).bbox(!0, this.svg),
                f = this.scale(),
                g = this.translate();
            e.x *= f.sx, e.y *= f.sy, e.width *= f.sx, e.height *= f.sy;
            var h = Math.max(Math.ceil((e.width + e.x) / a), 1) * a,
                i = Math.max(Math.ceil((e.height + e.y) / b), 1) * b,
                j = 0,
                k = 0;
            ("negative" == d.allowNewOrigin && e.x < 0 || "positive" == d.allowNewOrigin && e.x >= 0 || "any" == d.allowNewOrigin) && (j = Math.ceil(-e.x / a) * a, j += c.left, h += j), ("negative" == d.allowNewOrigin && e.y < 0 || "positive" == d.allowNewOrigin && e.y >= 0 || "any" == d.allowNewOrigin) && (k = Math.ceil(-e.y / b) * b, k += c.top, i += k), h += c.right, i += c.bottom, h = Math.max(h, d.minWidth || 0), i = Math.max(i, d.minHeight || 0), h = Math.min(h, d.maxWidth || Number.MAX_VALUE), i = Math.min(i, d.maxHeight || Number.MAX_VALUE);
            var l = h != this.options.width || i != this.options.height,
                m = j != g.tx || k != g.ty;
            m && this.translate(j, k), l && this.setDimensions(h, i)
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
                var c, d = a.padding,
                    e = a.minScaleX || a.minScale,
                    f = a.maxScaleX || a.maxScale,
                    h = a.minScaleY || a.minScale,
                    i = a.maxScaleY || a.maxScale;
                if (a.fittingBBox) c = a.fittingBBox;
                else {
                    var j = this.translate();
                    c = {
                        x: j.tx,
                        y: j.ty,
                        width: this.options.width,
                        height: this.options.height
                    }
                }
                c = g.rect(c).moveAndExpand({
                    x: d,
                    y: d,
                    width: -2 * d,
                    height: -2 * d
                });
                var k = this.scale(),
                    l = c.width / b.width * k.sx,
                    m = c.height / b.height * k.sy;
                if (a.preserveAspectRatio && (l = m = Math.min(l, m)), a.scaleGrid) {
                    var n = a.scaleGrid;
                    l = n * Math.floor(l / n), m = n * Math.floor(m / n)
                }
                l = Math.min(f, Math.max(e, l)), m = Math.min(i, Math.max(h, m)), this.scale(l, m);
                var o = this.getContentBBox(),
                    p = c.x - o.x,
                    q = c.y - o.y;
                this.translate(p, q)
            }
        },
        getContentBBox: function() {
            var a = this.viewport.getBoundingClientRect(),
                b = this.clientMatrix(),
                c = this.translate();
            return g.rect({
                x: a.left - b.e + c.tx,
                y: a.top - b.f + c.ty,
                width: a.width,
                height: a.height
            })
        },
        getArea: function() {
            return this.paperToLocalRect({
                x: 0,
                y: 0,
                width: this.options.width,
                height: this.options.height
            })
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
                    d = a.splice(0, c);
                _.each(d, function(a) {
                    a.graph === this.model && this.renderView(a)
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
            if (void 0 === a) return V.matrixToScale(this.matrix());
            void 0 === b && (b = a), void 0 === c && (c = 0, d = 0);
            var e = this.translate();
            if (c || d || e.tx || e.ty) {
                var f = e.tx - c * (a - 1),
                    g = e.ty - d * (b - 1);
                this.translate(f, g)
            }
            var h = this.matrix();
            return h.a = a || 0, h.d = b || 0, this.matrix(h), this.trigger("scale", a, b, c, d), this
        },
        rotate: function(a, b, c) {
            if (void 0 === a) return V.matrixToRotate(this.matrix());
            if (void 0 === b) {
                var d = this.viewport.getBBox();
                b = d.width / 2, c = d.height / 2
            }
            var e = this.matrix().translate(b, c).rotate(a).translate(-b, -c);
            return this.matrix(e), this
        },
        translate: function(a, b) {
            if (void 0 === a) return V.matrixToTranslate(this.matrix());
            var c = this.matrix();
            c.e = a || 0, c.f = b || 0, this.matrix(c);
            var d = this.translate(),
                e = this.options.origin;
            return e.x = d.tx, e.y = d.ty, this.trigger("translate", d.tx, d.ty), this.options.drawGrid && this.drawGrid(), this
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
        snapToGrid: function(a, b) {
            return this.clientToLocalPoint(a, b).snapToGrid(this.options.gridSize)
        },
        localToPaperPoint: function(a, b) {
            var c = g.Point(a, b),
                d = V.transformPoint(c, this.matrix());
            return g.Point(d)
        },
        localToPaperRect: function(a, b, c, d) {
            var e = g.Rect(a, b),
                f = V.transformRect(e, this.matrix());
            return g.Rect(f)
        },
        paperToLocalPoint: function(a, b) {
            var c = g.Point(a, b),
                d = V.transformPoint(c, this.matrix().inverse());
            return g.Point(d)
        },
        paperToLocalRect: function(a, b, c, d) {
            var e = g.Rect(a, b, c, d),
                f = V.transformRect(e, this.matrix().inverse());
            return g.Rect(f)
        },
        localToClientPoint: function(a, b) {
            var c = g.Point(a, b),
                d = V.transformPoint(c, this.clientMatrix());
            return g.Point(d)
        },
        localToClientRect: function(a, b, c, d) {
            var e = g.Rect(a, b, c, d),
                f = V.transformRect(e, this.clientMatrix());
            return g.Rect(f)
        },
        clientToLocalPoint: function(a, b) {
            var c = g.Point(a, b),
                d = V.transformPoint(c, this.clientMatrix().inverse());
            return g.Point(d)
        },
        clientToLocalRect: function(a, b, c, d) {
            var e = g.Rect(a, b, c, d),
                f = V.transformRect(e, this.clientMatrix().inverse());
            return g.Rect(f)
        },
        localToPagePoint: function(a, b) {
            return this.localToPaperPoint(a, b).offset(this.pageOffset())
        },
        localToPageRect: function(a, b, c, d) {
            return this.localToPaperRect(a, b, c, d).moveAndExpand(this.pageOffset())
        },
        pageToLocalPoint: function(a, b) {
            var c = g.Point(a, b),
                d = c.difference(this.pageOffset());
            return this.paperToLocalPoint(d)
        },
        pageToLocalRect: function(a, b, c, d) {
            var e = this.pageOffset(),
                f = g.Rect(a, b, c, d);
            return f.x -= e.x, f.y -= e.y, this.paperToLocalRect(f)
        },
        clientOffset: function() {
            var a = this.svg.getBoundingClientRect();
            return g.Point(a.left, a.top)
        },
        pageOffset: function() {
            return this.clientOffset().offset(window.scrollX, window.scrollY)
        },
        linkAllowed: function(a) {
            var b;
            if (a instanceof joint.dia.Link) b = a;
            else {
                if (!(a instanceof joint.dia.LinkView)) throw new Error("Must provide link model or view.");
                b = a.model
            } if (!this.options.multiLinks) {
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
                b = d && c.highlighting[d] || c.highlighting.
                default
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
                b.id || (b.id = V.uniqueId());
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
            this.bindDocumentEvents(), a = joint.util.normalizeEvent(a);
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
            this.unbindDocumentEvents(), a = joint.util.normalizeEvent(a);
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
        cellMouseenter: function(a) {
            a = joint.util.normalizeEvent(a);
            var b = this.findView(a.target);
            b && !this.guard(a, b) && b.mouseenter(a)
        },
        cellMouseleave: function(a) {
            a = joint.util.normalizeEvent(a);
            var b = this.findView(a.target);
            b && !this.guard(a, b) && b.mouseleave(a)
        },
        setGridSize: function(a) {
            return this.options.gridSize = a, this.options.drawGrid && this.drawGrid(), this
        },
        clearGrid: function() {
            return this.$grid && this.$grid.css("backgroundImage", "none"), this
        },
        _getGriRefs: function() {
            return this._gridCache || (this._gridCache = {
                root: V("svg", {
                    width: "100%",
                    height: "100%"
                }, V("defs")),
                patterns: {},
                add: function(a, b) {
                    V(this.root.node.childNodes[0]).append(b), this.patterns[a] = b, this.root.append(V("rect", {
                        width: "100%",
                        height: "100%",
                        fill: "url(#" + a + ")"
                    }))
                },
                get: function(a) {
                    return this.patterns[a]
                },
                exist: function(a) {
                    return void 0 !== this.patterns[a]
                }
            }), this._gridCache
        },
        setGrid: function(a) {
            this.clearGrid(), this._gridCache = null, this._gridSettings = [];
            var b = _.isArray(a) ? a : [a || {}];
            return _.each(b, function(a) {
                this._gridSettings.push.apply(this._gridSettings, this._resolveDrawGridOption(a))
            }, this), this
        },
        _resolveDrawGridOption: function(a) {
            var b = this.constructor.gridPatterns;
            if (_.isString(a) && b[a]) return _.map(b[a], _.clone);
            var c = a || {
                args: [{}]
            }, d = _.isArray(c),
                e = c.name;
            if (d || e || c.markup || (e = "dot"), e && b[e]) {
                var f = _.map(b[e], _.clone),
                    g = _.isArray(c.args) ? c.args : [c.args || {}];
                _.defaults(g[0], _.omit(a, "args"));
                for (var h = 0; h < g.length; h++) f[h] && _.extend(f[h], g[h]);
                return f
            }
            return d ? c : [c]
        },
        drawGrid: function(a) {
            var b = this.options.gridSize;
            if (b <= 1) return this.clearGrid();
            var c = _.isArray(a) ? a : [a],
                d = this.matrix(),
                e = this._getGriRefs();
            _.each(this._gridSettings, function(a, f) {
                var g = "pattern_" + f,
                    h = _.merge(a, c[f], {
                        sx: d.a || 1,
                        sy: d.d || 1,
                        ox: d.e || 0,
                        oy: d.f || 0
                    });
                h.width = b * (d.a || 1) * (h.scaleFactor || 1), h.height = b * (d.d || 1) * (h.scaleFactor || 1), e.exist(g) || e.add(g, V("pattern", {
                    id: g,
                    patternUnits: "userSpaceOnUse"
                }, V(h.markup)));
                var i = e.get(g);
                _.isFunction(h.update) && h.update(i.node.childNodes[0], h);
                var j = h.ox % h.width;
                j < 0 && (j += h.width);
                var k = h.oy % h.height;
                k < 0 && (k += h.height), i.attr({
                    x: j,
                    y: k,
                    width: h.width,
                    height: h.height
                })
            });
            var f = (new XMLSerializer).serializeToString(e.root.node);
            return f = "url(data:image/svg+xml;base64," + btoa(f) + ")", this.$grid.css("backgroundImage", f), this
        },
        updateBackgroundImage: function(a) {
            a = a || {};
            var b = a.position || "center",
                c = a.size || "auto auto",
                d = this.scale(),
                e = this.translate();
            if (_.isObject(b)) {
                var f = e.tx + d.sx * (b.x || 0),
                    h = e.ty + d.sy * (b.y || 0);
                b = f + "px " + h + "px"
            }
            _.isObject(c) && (c = g.rect(c).scale(d.sx, d.sy), c = c.width + "px " + c.height + "px"), this.$background.css({
                backgroundSize: c,
                backgroundPosition: b
            })
        },
        drawBackgroundImage: function(a, b) {
            if (!(a instanceof HTMLImageElement)) return void this.$background.css("backgroundImage", "");
            b = b || {};
            var c, d = b.size,
                e = b.repeat || "no-repeat",
                f = b.opacity || 1,
                g = Math.abs(b.quality) || 1,
                h = this.constructor.backgroundPatterns[_.camelCase(e)];
            if (_.isFunction(h)) {
                a.width *= g, a.height *= g;
                var i = h(a, b);
                if (!(i instanceof HTMLCanvasElement)) throw new Error("dia.Paper: background pattern must return an HTML Canvas instance");
                c = i.toDataURL("image/png"), e = "repeat", _.isObject(d) ? (d.width *= i.width / a.width, d.height *= i.height / a.height) : _.isUndefined(d) && (b.size = {
                    width: i.width / g,
                    height: i.height / g
                })
            } else c = a.src, _.isUndefined(d) && (b.size = {
                width: a.width,
                height: a.height
            });
            this.$background.css({
                opacity: f,
                backgroundRepeat: e,
                backgroundImage: "url(" + c + ")"
            }), this.updateBackgroundImage(b)
        },
        updateBackgroundColor: function(a) {
            this.$el.css("backgroundColor", a || "")
        },
        drawBackground: function(a) {
            if (a = a || {}, this.updateBackgroundColor(a.color), a.image) {
                a = this._background = _.cloneDeep(a);
                var b = document.createElement("img");
                b.onload = _.bind(this.drawBackgroundImage, this, b, a), b.src = a.image
            } else this.drawBackgroundImage(null), this._background = null;
            return this
        },
        setInteractivity: function(a) {
            this.options.interactive = a, _.invoke(this._views, "setInteractivity", a)
        },
        isDefined: function(a) {
            return !!this.svg.getElementById(a)
        },
        defineFilter: function(a) {
            if (!_.isObject(a)) throw new TypeError("dia.Paper: defineFilter() requires 1. argument to be an object.");
            var b = a.id,
                c = a.name;
            if (b || (b = c + this.svg.id + joint.util.hashCode(JSON.stringify(a))), !this.isDefined(b)) {
                var d = joint.util.filter,
                    e = d[c] && d[c](a.args || {});
                if (!e) throw new Error("Non-existing filter " + c);
                var f = _.extend({
                    filterUnits: "objectBoundingBox",
                    x: -1,
                    y: -1,
                    width: 3,
                    height: 3
                }, a.attrs, {
                    id: b
                });
                V(e, f).appendTo(this.defs)
            }
            return b
        },
        defineGradient: function(a) {
            if (!_.isObject(a)) throw new TypeError("dia.Paper: defineGradient() requires 1. argument to be an object.");
            var b = a.id,
                c = a.type,
                d = a.stops;
            if (b || (b = c + this.svg.id + joint.util.hashCode(JSON.stringify(a))), !this.isDefined(b)) {
                var e = joint.util.template('<stop offset="${offset}" stop-color="${color}" stop-opacity="${opacity}"/>'),
                    f = _.map(d, function(a) {
                        return e({
                            offset: a.offset,
                            color: a.color,
                            opacity: _.isFinite(a.opacity) ? a.opacity : 1
                        })
                    }),
                    g = ["<" + c + ">", f.join(""), "</" + c + ">"].join(""),
                    h = _.extend({
                        id: b
                    }, a.attrs);
                V(g, h).appendTo(this.defs)
            }
            return b
        },
        defineMarker: function(a) {
            if (!_.isObject(a)) throw new TypeError("dia.Paper: defineMarker() requires 1. argument to be an object.");
            var b = a.id;
            if (b || (b = this.svg.id + joint.util.hashCode(JSON.stringify(a))), !this.isDefined(b)) {
                var c = _.omit(a, "type", "userSpaceOnUse"),
                    d = V("marker", {
                        id: b,
                        orient: "auto",
                        overflow: "visible",
                        markerUnits: a.markerUnits || "userSpaceOnUse"
                    }, [V(a.type || "path", c)]);
                d.appendTo(this.defs)
            }
            return b
        }
    }, {
        backgroundPatterns: {
            flipXy: function(a) {
                var b = document.createElement("canvas"),
                    c = a.width,
                    d = a.height;
                b.width = 2 * c, b.height = 2 * d;
                var e = b.getContext("2d");
                return e.drawImage(a, 0, 0, c, d), e.setTransform(-1, 0, 0, -1, b.width, b.height), e.drawImage(a, 0, 0, c, d), e.setTransform(-1, 0, 0, 1, b.width, 0), e.drawImage(a, 0, 0, c, d), e.setTransform(1, 0, 0, -1, 0, b.height), e.drawImage(a, 0, 0, c, d), b
            },
            flipX: function(a) {
                var b = document.createElement("canvas"),
                    c = a.width,
                    d = a.height;
                b.width = 2 * c, b.height = d;
                var e = b.getContext("2d");
                return e.drawImage(a, 0, 0, c, d), e.translate(2 * c, 0), e.scale(-1, 1), e.drawImage(a, 0, 0, c, d), b
            },
            flipY: function(a) {
                var b = document.createElement("canvas"),
                    c = a.width,
                    d = a.height;
                b.width = c, b.height = 2 * d;
                var e = b.getContext("2d");
                return e.drawImage(a, 0, 0, c, d), e.translate(0, 2 * d), e.scale(1, -1), e.drawImage(a, 0, 0, c, d), b
            },
            watermark: function(a, b) {
                b = b || {};
                var c = a.width,
                    d = a.height,
                    e = document.createElement("canvas");
                e.width = 3 * c, e.height = 3 * d;
                for (var f = e.getContext("2d"), h = _.isNumber(b.watermarkAngle) ? -b.watermarkAngle : -20, i = g.toRad(h), j = e.width / 4, k = e.height / 4, l = 0; l < 4; l++)
                    for (var m = 0; m < 4; m++)(l + m) % 2 > 0 && (f.setTransform(1, 0, 0, 1, (2 * l - 1) * j, (2 * m - 1) * k), f.rotate(i), f.drawImage(a, -c / 2, -d / 2, c, d));
                return e
            }
        },
        gridPatterns: {
            dot: [{
                color: "#AAAAAA",
                thickness: 1,
                markup: "rect",
                update: function(a, b) {
                    V(a).attr({
                        width: b.thickness * b.sx,
                        height: b.thickness * b.sy,
                        fill: b.color
                    })
                }
            }],
            fixedDot: [{
                color: "#AAAAAA",
                thickness: 1,
                markup: "rect",
                update: function(a, b) {
                    var c = b.sx <= 1 ? b.thickness * b.sx : b.thickness;
                    V(a).attr({
                        width: c,
                        height: c,
                        fill: b.color
                    })
                }
            }],
            mesh: [{
                color: "#AAAAAA",
                thickness: 1,
                markup: "path",
                update: function(a, b) {
                    var c, d = b.width,
                        e = b.height,
                        f = b.thickness;
                    c = d - f >= 0 && e - f >= 0 ? ["M", d, 0, "H0 M0 0 V0", e].join(" ") : "M 0 0 0 0", V(a).attr({
                        d: c,
                        stroke: b.color,
                        "stroke-width": b.thickness
                    })
                }
            }],
            doubleMesh: [{
                color: "#AAAAAA",
                thickness: 1,
                markup: "path",
                update: function(a, b) {
                    var c, d = b.width,
                        e = b.height,
                        f = b.thickness;
                    c = d - f >= 0 && e - f >= 0 ? ["M", d, 0, "H0 M0 0 V0", e].join(" ") : "M 0 0 0 0", V(a).attr({
                        d: c,
                        stroke: b.color,
                        "stroke-width": b.thickness
                    })
                }
            }, {
                color: "#000000",
                thickness: 3,
                scaleFactor: 4,
                markup: "path",
                update: function(a, b) {
                    var c, d = b.width,
                        e = b.height,
                        f = b.thickness;
                    c = d - f >= 0 && e - f >= 0 ? ["M", d, 0, "H0 M0 0 V0", e].join(" ") : "M 0 0 0 0", V(a).attr({
                        d: c,
                        stroke: b.color,
                        "stroke-width": b.thickness
                    })
                }
            }]
        }
    }),
    function(a, b) {
        var c = function(c) {
            var d = b.cloneDeep(c) || {};
            this.ports = [], this.groups = {}, this.portLayoutNamespace = a.layout.Port, this.portLabelLayoutNamespace = a.layout.PortLabel, this._init(d)
        };
        c.prototype = {
            getPorts: function() {
                return this.ports
            },
            getGroup: function(a) {
                return this.groups[a] || {}
            },
            getPortsByGroup: function(a) {
                return b.filter(this.ports, function(b) {
                    return b.group === a
                })
            },
            getGroupPortsMetrics: function(a, c) {
                var d = this.getGroup(a),
                    e = this.getPortsByGroup(a),
                    f = d.position || {}, h = f.name,
                    i = this.portLayoutNamespace;
                i[h] || (h = "left");
                var j = f.args || {}, k = b.pluck(e, "position.args"),
                    l = i[h](k, c, j);
                return b.transform(l, b.bind(function(a, b, d) {
                    var f = e[d];
                    a.push({
                        portId: f.id,
                        portTransformation: b,
                        labelTransformation: this._getPortLabelLayout(f, g.Point(b), c),
                        portAttrs: f.attrs,
                        portSize: f.size,
                        labelSize: f.label.size
                    })
                }, this), [])
            },
            _getPortLabelLayout: function(a, b, c) {
                var d = this.portLabelLayoutNamespace,
                    e = a.label.position.name || "left";
                return d[e] ? d[e](b, c, a.label.position.args) : null
            },
            _init: function(a) {
                b.transform(a.groups || {}, b.bind(this._evaluateGroup, this), this.groups), b.transform(a.items || [], b.bind(this._evaluatePort, this), this.ports)
            },
            _evaluateGroup: function(a, c, d) {
                a[d] = b.merge(c, {
                    position: this._getPosition(c.position, !0),
                    label: this._getLabel(c, !0)
                })
            },
            _evaluatePort: function(a, c) {
                var d = b.clone(c),
                    e = this.getGroup(c.group);
                d.markup = d.markup || e.markup, d.attrs = b.merge({}, e.attrs, d.attrs), d.position = this._createPositionNode(e, d), d.label = b.merge({}, e.label, this._getLabel(d)), d.z = this._getZIndex(e, d), d.size = b.extend({}, e.size, d.size), a.push(d)
            },
            _getZIndex: function(a, c) {
                return b.isNumber(c.z) ? c.z : b.isNumber(a.z) || "auto" === a.z ? a.z : "auto"
            },
            _createPositionNode: function(a, c) {
                return b.merge({
                    name: "left",
                    args: {}
                }, a.position, {
                    args: c.args
                })
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
                var c = a.label || {}, d = c;
                return d.position = this._getPosition(c.position, b), d
            }
        }, b.extend(a.dia.Element.prototype, {
            _initializePorts: function() {
                this._createPortData(), this.on("change:ports", function() {
                    this._processRemovedPort(), this._createPortData()
                }, this)
            },
            _processRemovedPort: function() {
                var a = this.get("ports") || {}, c = {};
                b.each(a.items, function(a) {
                    c[a.id] = !0
                });
                var d = this.previous("ports") || {}, e = {};
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
            getPortsPositions: function(a) {
                var c = this._portSettingsData.getGroupPortsMetrics(a, g.Rect(this.size()));
                return b.transform(c, function(a, b) {
                    var c = b.portTransformation;
                    a[b.portId] = {
                        x: c.x,
                        y: c.y,
                        angle: c.angle
                    }
                }, {})
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
                var g = Array.prototype.slice.call(arguments, 1);
                return b.isArray(c) ? g[0] = ["ports", "items", f].concat(c) : b.isString(c) ? g[0] = ["ports/items/", f, "/", c].join("") : (g = ["ports/items/" + f], b.isPlainObject(c) && (g.push(c), g.push(d))), this.prop.apply(this, g)
            },
            _validatePorts: function() {
                var c = this.get("ports") || {}, d = [];
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
                var d = c || {}, e = b.clone(this.prop("ports/items")),
                    f = this.getPortIndex(a);
                return f !== -1 && (e.splice(f, 1), d.rewrite = !0, this.prop("ports/items", e, d)), this
            },
            _createPortData: function() {
                var a = this._validatePorts();
                if (a.length > 0) throw this.set("ports", this.previous("ports")), new Error(a.join(" "));
                var d;
                this._portSettingsData && (d = this._portSettingsData.getPorts()), this._portSettingsData = new c(this.get("ports"));
                var e = this._portSettingsData.getPorts();
                if (d) {
                    var f = b.filter(e, function(a) {
                        if (!b.find(d, "id", a.id)) return a
                    }),
                        g = b.filter(d, function(a) {
                            if (!b.find(e, "id", a.id)) return a
                        });
                    g.length > 0 && this.trigger("ports:remove", this, g), f.length > 0 && this.trigger("ports:add", this, f)
                }
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
                var d = b.groupBy(this.model._portSettingsData.getPorts(), "z"),
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
                this._updatePortGroup(void 0);
                var a = b.keys(this.model._portSettingsData.groups);
                b.each(a, this._updatePortGroup, this)
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
            _updatePortGroup: function(a) {
                for (var b = g.Rect(this.model.size()), c = this.model._portSettingsData.getGroupPortsMetrics(a, b), d = 0, e = c.length; d < e; d++) {
                    var f = c[d],
                        h = f.portId,
                        i = this._portElementsCache[h] || {}, j = f.portTransformation;
                    this.applyPortTransform(i.portElement, j), this.updateDOMSubtreeAttributes(i.portElement.node, f.portAttrs, {
                        rootBBox: g.Rect(f.portSize)
                    });
                    var k = f.labelTransformation;
                    k && (this.applyPortTransform(i.portLabelElement, k, -j.angle || 0), this.updateDOMSubtreeAttributes(i.portLabelElement.node, k.attrs, {
                        rootBBox: g.Rect(f.labelSize)
                    }))
                }
            },
            applyPortTransform: function(a, b, c) {
                var d = V.createSVGMatrix().rotate(c || 0).translate(b.x || 0, b.y || 0).rotate(b.angle || 0);
                a.transform(d, {
                    absolute: !0
                })
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
                    "ref-dy": null,
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
            var c = this.model;
            if (joint.env.test("svgforeignobject")) joint.dia.ElementView.prototype.update.call(this, c, b);
            else {
                var d = _.omit(b || c.get("attrs"), ".content");
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
                    s = {}, t = {};
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
            m(f), this.options.perpendicular = !! f.perpendicular;
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
                    }, f = {
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
            var i, j = {}, k = [g.point(c.x, d.y), g.point(d.x, c.y)],
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
            var k, l, m, n = {}, p = c(e(h, i), 1),
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
                    w = !! a(u, v);
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
        }, o = {
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
                b = a.paper._jumpOverUpdateList = []
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
                w = r.options.defaultConnector || {}, x = t.filter(function(b, c) {
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
            var d = c || {}, e = d.className || this.className;
            V(b).addClass(e)
        },
        unhighlight: function(a, b, c) {
            var d = c || {}, e = d.className || this.className;
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
        getHighlighterId: function(a, b) {
            return a.id + JSON.stringify(b)
        },
        removeHighlighter: function(a) {
            this._views[a] && (this._views[a].remove(), this._views[a] = null)
        },
        highlight: function(a, b, c) {
            var d = this.getHighlighterId(b, c);
            if (!this._views[d]) {
                var e, f = _.defaults(c || {}, this.defaultOptions),
                    g = V(b);
                try {
                    var h = g.convertToPathData()
                } catch (a) {
                    e = g.bbox(!0), h = V.rectToPath(_.extend({}, f, e))
                }
                var i = V("path").attr({
                    d: h,
                    "pointer-events": "none",
                    "vector-effect": "non-scaling-stroke",
                    fill: "none"
                }).attr(f.attrs);
                i.transform(a.el.getCTM().inverse()), i.transform(b.getCTM());
                var j = f.padding;
                if (j) {
                    e || (e = g.bbox(!0));
                    var k = e.x + e.width / 2,
                        l = e.y + e.height / 2,
                        m = (e.width + j) / e.width,
                        n = (e.height + j) / e.height;
                    i.transform({
                        a: m,
                        b: 0,
                        c: 0,
                        d: n,
                        e: k - m * k,
                        f: l - n * l
                    })
                }
                var o = this._views[d] = new joint.mvc.View({
                    svgElement: !0,
                    className: "highlight-stroke",
                    el: i.node
                }),
                    p = _.bind(this.removeHighlighter, this, d),
                    q = a.model;
                o.listenTo(q, "remove", p), o.listenTo(q.graph, "reset", p), a.vel.append(i)
            }
        },
        unhighlight: function(a, b, c) {
            this.removeHighlighter(this.getHighlighterId(b, c))
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
                groups: { in : {
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
                e = {}, f = b.marginX || 0,
                h = b.marginY || 0;
            b.rankDir && (e.rankdir = b.rankDir), b.align && (e.align = b.align), b.nodeSep && (e.nodesep = b.nodeSep), b.edgeSep && (e.edgesep = b.edgeSep), b.rankSep && (e.ranksep = b.rankSep), f && (e.marginx = f), h && (e.marginy = h), d.setGraph(e), dagre.layout(d, {
                debugTiming: !! b.debugTiming
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

    joint.g = g;
    joint.V = joint.Vectorizer = V;

    return joint;

}));