Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69342E2898
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 19:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgLXShw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 13:37:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:39502 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbgLXShw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Dec 2020 13:37:52 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-277-gYu6pb9aP32_rumPVp6FPw-1; Thu, 24 Dec 2020 18:36:12 +0000
X-MC-Unique: gYu6pb9aP32_rumPVp6FPw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Dec 2020 18:36:11 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Dec 2020 18:36:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Scally' <djrscally@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Erik Kaneda" <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        "niklas.soderlund+renesas@ragnatech.se" 
        <niklas.soderlund+renesas@ragnatech.se>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: RE: [PATCH v3 05/14] software_node: unregister software_nodes in
 reverse order
Thread-Topic: [PATCH v3 05/14] software_node: unregister software_nodes in
 reverse order
Thread-Index: AQHW2f9YHWzUalHOOk+Pd50vjly8GaoGkhDQ
Date:   Thu, 24 Dec 2020 18:36:10 +0000
Message-ID: <fcb07dea193b4b99b11f2a8e684d8acf@AcuMS.aculab.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-6-djrscally@gmail.com>
 <CAHp75VdF5NdjrSxcOafh7KNNDteYEUDk9otA0HKX-iks7G0D4g@mail.gmail.com>
 <de478ef0-0b4d-df1d-2651-9cc35bf2f45b@gmail.com>
 <CAHp75VdWuowLenNPQRNc+QXeyuvwKqh_bjw=1WvmFrzoygXFRw@mail.gmail.com>
 <2b415312-fe30-c73b-0077-4ec2a07116df@gmail.com>
In-Reply-To: <2b415312-fe30-c73b-0077-4ec2a07116df@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

RnJvbTogRGFuaWVsIFNjYWxseSANCj4gU2VudDogMjQgRGVjZW1iZXIgMjAyMCAxNDoxNA0KLi4u
DQo+ID4+IFRoZSBhcnJheSB3aWxsIGJlIHVud291bmQgaW4gcmV2ZXJzZSBvcmRlciAoaS5lLiBs
YXN0IGVudHJ5IGZpcnN0KS4gSWYNCj4gPj4gYW55IG1lbWJlciBvZiB0aGUgYXJyYXkgaXMgYSBj
aGlsZCBvZiBhbm90aGVyIG1lbWJlciB0aGVuIHRoZSBjaGlsZCBtdXN0DQo+ID4gY2hpbGRyZW4g
Pw0KPiANCj4gWWVzLCB5b3UgYXJlIHJpZ2h0IG9mIGNvdXJzZS4NCg0KVGhlIHNlY29uZCAnY2hp
bGQnIGlzIGEgYmFjay1yZWZlcmVuY2UgdG8gJ2FueSBtZW1iZXInIHNvIGlzIHNpbmd1bGFyDQpz
byAnY2hpbGQnIGlzIGNvcnJlY3QuDQondGhlIGNoaWxkJyBjb3VsZCBiZSByZXBsYWNlZCBieSAn
aXQnDQoNCllvdSBjb3VsZCBoYXZlOg0KICAgSWYgYW55IG1lbWJlcnMgb2YgdGhlIGFycmF5IGFy
ZSBjaGlsZHJlbiBvZiBhbm90aGVyIG1lbWJlciB0aGVuIHRoZQ0KICAgY2hpbGRyZW4gbXVzdCBh
cHBlYXIgbGF0ZXIgaW4gdGhlIGxpc3QuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

