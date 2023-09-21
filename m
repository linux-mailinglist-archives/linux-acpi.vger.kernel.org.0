Return-Path: <linux-acpi+bounces-23-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B927A9C59
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1CDAB21FE5
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02094A7A
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:42:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCD168BD
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 17:49:18 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB6F89D97
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 10:40:20 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275-3ANp1ejCPpKMCXrfXPnzNA-1; Thu, 21 Sep 2023 14:20:59 +0100
X-MC-Unique: 3ANp1ejCPpKMCXrfXPnzNA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Sep
 2023 14:20:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Sep 2023 14:20:58 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Shuai Xue' <xueshuai@linux.alibaba.com>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Linux PCI <linux-pci@vger.kernel.org>,
	"mahesh@linux.ibm.com" <mahesh@linux.ibm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "lenb@kernel.org" <lenb@kernel.org>
Subject: RE: Questions: Should kernel panic when PCIe fatal error occurs?
Thread-Topic: Questions: Should kernel panic when PCIe fatal error occurs?
Thread-Index: AQHZ7ISwt0MI+BDoAEe5dUPUvfmXNrAlQDAw
Date: Thu, 21 Sep 2023 13:20:58 +0000
Message-ID: <2e5870e416f84e8fad8340061ec303e2@AcuMS.aculab.com>
References: <20230920230257.GA280837@bhelgaas>
 <d84b6d17-7fe9-222a-c874-798af4d9faea@linux.alibaba.com>
In-Reply-To: <d84b6d17-7fe9-222a-c874-798af4d9faea@linux.alibaba.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Li4uDQpJJ3ZlIGdvdCBhIHRhcmdldCB0byBnZW5lcmF0ZSBBRVIgZXJyb3JzIGJ5IGdlbmVyYXRp
bmcgcmVhZCBjeWNsZXMNCnRoYXQgYXJlIGluc2lkZSB0aGUgYWRkcmVzcyByYW5nZSB0aGF0IHRo
ZSBicmlkZ2UgZm9yd2FyZHMgYnV0DQpvdXRzaWRlIG9mIGFueSBCQVIgYmVjYXVzZSB0aGVyZSBh
cmUgMiBkaWZmZXJlbnQgc2l6ZWQgQkFScy4NCihQcmV0dHkgZWFzeSB0byBzZXR1cC4pDQpPbiB0
aGUgc3lzdGVtIEkgd2FzIHVzaW5nIHRoZXkgZGlkbid0IGdldCBwcm9wYWdhdGVkIGFsbCB0aGUg
d2F5DQp0byB0aGUgcm9vdCBicmlkZ2UgLSBidXQgd2VyZSB2aXNpYmxlIGluIHRoZSBsb3dlciBi
cmlkZ2UuDQpJdCB3b3VsZCBiZSBuaWNlIGZvciBhIGRyaXZlciB0byBiZSBhYmxlIHRvIGRldGVj
dC9jbGVhciBzdWNoDQphIGZsYWcgaWYgaXQgZ2V0cyBhbiB1bmV4cGVjdGVkIH4wdSByZWFkIHZh
bHVlLg0KKEknbSBub3Qgc3VyZSBhbiBlcnJvciBjYWxsYmFjayBoZWxwcy4pDQoNCk9UT0ggYSAn
bmVicyBjb21wbGlhbnQnIHNlcnZlciByb3V0ZWQgYW55IGtpbmQgb2YgUENJZSBsaW5rIGVycm9y
DQp0aHJvdWdoIHRvIHNvbWUgJ3N5c3RlbSBtYW5hZ2VtZW50JyBsb2dpYyB0aGF0IHRoZW4gcmFp
c2VkIGFuIE5NSS4NCkknbSBub3Qgc3VyZSB3aG8gdGhvdWdodCBhbiBOTUkgd2FzIGEgZ29vZCBp
ZGVhIC0gdGhleSBhcmUgcHJldHR5DQppbXBvc3NpYmxlIHRvIGhhbmRsZSBpbiB0aGUga2VybmVs
IGFuZCB0b28gbGF0ZSB0byBiZSBvZiB1c2UgdG8NCnRoZSBjb2RlIHBlcmZvcm1pbmcgdGhlIGFj
Y2Vzcy4NCg0KSW4gYW55IGNhc2Ugd2Ugd2VyZSBnZXR0aW5nIG9uZSBhZnRlciAnZWNobyAxID54
eHgvcmVtb3ZlJyBhbmQNCnRoZW4gdGFraW5nIHRoZSBQQ0llIGxpbmsgZG93biBieSByZXByb2dy
YW1taW5nIHRoZSBmcGdhLg0KU28gdGhlIGxpbmsgZ29pbmcgZG93biB3YXMgZW50aXJlbHkgZXhw
ZWN0ZWQsIGJ1dCB0aGVyZSBzZWVtZWQNCnRvIGJlIG5vdGhpbmcgd2UgY291bGQgZG8gdG8gc3Rv
cCB0aGUga2VybmVsIGNyYXNoaW5nLg0KDQpJJ20gc3VyZSAnbmVicyBjb21wbGlhbnQnIG91Z2h0
IHRvIGNvbnRhaW4gc29tZSByZXF1aXJlbWVudHMgZm9yDQpyZXNpbGllbmNlIHRvIGhhcmR3YXJl
IGZhaWx1cmVzIQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


