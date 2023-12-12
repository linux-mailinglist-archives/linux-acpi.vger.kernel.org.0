Return-Path: <linux-acpi+bounces-2299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78880E259
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 03:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A72F1C209A0
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09E442B;
	Tue, 12 Dec 2023 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Ob8fu2Iw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6164B5
	for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 18:52:07 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B5A3F2C01BC;
	Tue, 12 Dec 2023 15:52:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1702349523;
	bh=EhEDl/bwO+lO79WJrltFLO5hM+8zR4lFT8h6icmX18o=;
	h=From:To:Subject:Date:From;
	b=Ob8fu2IwSI5Of0REca9PkO8NfD8JaXUPQ5vA/mtxPZw2pPkfYIVpadlQKDe5nN5aG
	 W9u2IjG2x0PKVnyvBTCQVYzGSP1aVLIBB5xg3SCeh5kyIWNBzu9ZlQbRug637W9LJY
	 5rlvkVlHm8YGRBYPVsPlQSzhP7q4xHScsPOzdEI0FSEnV1Kw57G8Ua/vRfYFdr6392
	 qrPnwxMqYP1mGvFT+aI1Qcc3XLueE0RKeD7oXMQgzLouWeOLk6QuJItq9P+mDhJVqH
	 rWkgLmZ8ISdU4NE4dQLFtulUz/3uiz3eFeMFSNOqlM+o2vfqSujW6w7EQyCVkv3++G
	 Gww6Yk9Hwtcbw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6577cad30000>; Tue, 12 Dec 2023 15:52:03 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 15:52:03 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Tue, 12 Dec 2023 15:52:03 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Tue, 12 Dec 2023 15:52:03 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Deterministic device paths for ACPI instantiated hwmon devices
Thread-Topic: Deterministic device paths for ACPI instantiated hwmon devices
Thread-Index: AQHaLKYvbHi8z1cXhUawglUQytIyoQ==
Date: Tue, 12 Dec 2023 02:52:03 +0000
Message-ID: <9d52cc19-062b-4b8d-a9a0-bc2101dccab4@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <26BEBAFA17279E45A8A4C2C54BD2AC46@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=AZXP4EfG c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=2gvIz3qf2Ucxk_-o8dMA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGksDQoNCldlJ3JlIGxvb2tpbmcgYXQgb3VyIGZpcnN0IGluLWhvdXNlIG1vZHVsYXIgcHJvZHVj
dCB1c2luZyBhbiB4ODZfNjQgQ1BVLiANClByZXZpb3VzbHkgd2UndmUgZG9uZSBvdGhlciBwcm9k
dWN0cyB1c2luZyBvdGhlciB2YXJpb3VzIGVtYmVkZGVkIENQVSANCmFyY2hpdGVjdHVyZXMgd2hp
Y2ggbWFrZSB1c2Ugb2YgYSBkZXZpY2UgdHJlZSBmb3IgZGVzY3JpYmluZyB0aGUgaGFyZHdhcmUu
DQoNCldlJ3ZlIGdvdCBzb21lIHVzZXJzcGFjZSBjb2RlIHdoaWNoIHRyaWVzIHRvIHByZXNlbnQg
ZW5kLXVzZXIgY29uc3VtYWJsZSANCm5hbWVzIGZvciB2YXJpb3VzIGhhcmR3YXJlIG1vbml0b3Jz
IG9uIHJlbW92YWJsZSBtb2R1bGVzIChlLmcuIA0KInRlbXBlcmF0dXJlIHNlbnNvciAxIG9uIHRo
ZSBjYXJkIGluIGJheSAzIikuDQoNCldlIGRvIHRoaXMgYmFzZWQgb24ga25vd2luZyB0aGUgZGV0
ZXJtaW5pc3RpYyBwYXRoIG9mIHRoZSBkZXZpY2UgaW4gDQpzeXNmcyAoZS5nLiAvc3lzL2Rldmlj
ZXMvcGxhdGZvcm0vc29jL2kyYzAvbG03NUAyZSkgdGhhdCB3b3JrcyBmaW5lIGZvciANCmRldmlj
ZXMgaW5zdGFudGlhdGVkIG9uIGEgZGV2aWNlIHRyZWUgYXdhcmUgc3lzdGVtICh1c2luZyBkZXZp
Y2UtdHJlZSANCm92ZXJsYXlzKS4gSG93ZXZlciB3ZSd2ZSB5ZXQgdG8gZmluZCBhbnkgd2F5IG9m
IGdldHRpbmcgYSBkZXRlcm1pbmlzdGljIA0KcGF0aCBvdXQgb2YgZGV2aWNlcyBpbnN0YW50aWF0
ZWQgdmlhIEFDUEkgb3ZlcmxheXMuIEZvciBub3cgd2UndmUgYmVlbiANCnVzaW5nIHRoZSBgL3N5
cy9jbGFzcy9od21vbi9od21vbk4vZGV2aWNlYCBwYXRocyBidXQgdGhlIE4gZGVwZW5kcyBvbiAN
CnRoZSBvcmRlciB0aGUgaGFyZHdhcmUgd2FzIGRpc2NvdmVyZWQgd2hpY2ggbWF5IG5vdCBiZSB0
aGUgb3JkZXIgdGhlIA0KZW5kLXVzZXIgZXhwZWN0cy4NCg0KSXMgdGhlcmUgYSB3YXkgb2YgaW5m
ZXJyaW5nL2luZmx1ZW5jaW5nIHRoZSBudW1iZXJpbmcgdGhhdCBnZXRzIHVzZWQgaW4gDQp0aGUg
YC9zeXMvZGV2aWNlcy9MTlhTWVNUTTowMC9MTlhTWUJVUzowMC9BTURJMDAxMDowMC9gIHBhdGhz
IHRoYXQgDQphcHBlYXIgd2hlbiB0aGUgZGV2aWNlcyBnZXQgaW5zdGFudGlhdGVkPw0KDQpUaGFu
a3MsDQpDaHJpcw0K

