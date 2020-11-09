Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A32AB31A
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 10:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgKIJFm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 04:05:42 -0500
Received: from smtp.asem.it ([151.1.184.197]:55909 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbgKIJFm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Nov 2020 04:05:42 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000593587.MSG 
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2020 10:05:38 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 10:05:36 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Mon, 9 Nov 2020 10:05:36 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Topic: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Index: AdazWEAUpTjocun1TNeP3lXLN/Ph2wACVbgAAABK9IAABkeZAAAAulsAAALtYfAAHgxtAAAWS8WA///44YD/+8QuMA==
Date:   Mon, 9 Nov 2020 09:05:36 +0000
Message-ID: <dfeb12b6c53a49a2afc8cf381b066999@asem.it>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
 <20201105152020.GO2495@lahna.fi.intel.com>
 <5fb64f9c8af64235943c29c9ba50a2df@asem.it>
 <20201106070432.GQ2495@lahna.fi.intel.com>
 <c20e82318bbf426c9d9000cac7e7734b@asem.it>
 <20201106171727.GK4077@smile.fi.intel.com>
In-Reply-To: <20201106171727.GK4077@smile.fi.intel.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020E.5FA90661.0046,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQW5keSwNCg0KPiA+DQo+ID4gQWxsIG9rIG5vdywgSSd2ZSBhZGRlZCB0aGUgYnJpZGdlIChJ
IGhhZCB0byB1c2UgdGhlIEJJT1Mgc291cmNlcykgYW5kDQo+ID4gbm90IGl0IHdvcmtzOg0KPiAN
Cj4gSSBzdXBwb3NlIG5vdCAtPiBub3cgOykNCg0KcmlnaHQhIC0tPiBub3cgaXQgd29ya3MgISEh
IPCfmIoNCg0KPiANCj4gR2xhZCB0byBoZWFyIHRoaXMhIFNvLCBtYXliZSB5b3UgY2FuIGFkZCBz
b21lIGJpdHMgdG8gdGhlIGRvY3VtZW50YXRpb24NCj4gWzFdDQo+IGJhc2VkIG9uIHlvdXIgZXhw
ZXJpZW5jZT8NCj4gDQoNClllcywgSSBjYW4hIFRoYW5rcyB5b3UgZm9yIGFza2luZyBtZSENCg0K
PiBOb3RlLCBJIGhhdmUgc2VudCBhIHNlcmllcyBbMl0gdG8gYW1lbmQgaXQgYSBiaXQsIGFuZCB5
b3VyIGlucHV0IHdlbGNvbWUhDQo+IA0KPiBbMV06IERvY3VtZW50YXRpb24vZmlybXdhcmUtZ3Vp
ZGUvYWNwaS9ncGlvLXByb3BlcnRpZXMucnN0DQo+IFsyXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtYWNwaS8yMDIwMTAyOTE5MzI0My42MTU0Ni0xLQ0KPiBhbmRyaXkuc2hldmNoZW5r
b0BsaW51eC5pbnRlbC5jb20vVC8jdQ0KDQpPaywgSSdsbCBzZWUgaG93IHRvIGludGVncmF0ZSBt
eSBQQ0kgImludmVzdGlnYXRpb24iIGFib3V0IHRoZQ0KaWRlbnRpZmljYXRpb24gb2YgdGhlIGNv
cnJlY3QgcGF0aCBmcm9tIHRoZSBDUFUgdG8gdGhlIGZpbmFsIFBDSQ0KZGV2aWNlLCB0aHJvdWdo
IHRoZSB2YXJpb3VzIGJyaWRnZXMgb2YgdGhlIGJvYXJkLg0KSSB0aGluayB0aGF0IGEgZ2VuZXJh
bCBkaXNjb3Vyc2UgYWJvdXQgaXQgY2FuIGJlIHVzZWZ1bCB0bw0Kb3RoZXIgcGVvcGxlLCB0b28u
DQoNCj4gDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtv
DQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQoNCkZsYXZpbw0K
