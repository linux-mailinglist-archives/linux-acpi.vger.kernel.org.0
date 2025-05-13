Return-Path: <linux-acpi+bounces-13693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC7AB4989
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 04:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167D43BEBA1
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A307417A2FC;
	Tue, 13 May 2025 02:30:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AB944E;
	Tue, 13 May 2025 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747103433; cv=none; b=CKfTA+oj0Necsfo9dFs2TryyhZ0yv3waI5QXdSXyV45XdY3ZkScYcxvfSrY8tjc1jk0Jonh2/dEizOpbVWeQhmf26SGylhYwk+nxGSqZ8Z24ZdeNpYAt+5qq3Ogl3/0g9eNlGfKxs41W4KBf4/gln82xHBiOyjXzIVk6IRRrEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747103433; c=relaxed/simple;
	bh=YnVK1ciKEF7jPUGTIUHV1WReyaEQrCcNoSuNPZ5CmcE=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=mjjlz2D7LmiuYnE1BJSAuh+mAdCGKJTrnPenLcmd6IdP3b35r1lOYCyWBbLsDfR+KOZGrMI/L5PoJMZjkrloCQcTakKZE+CZixWkufLwXC9f2ldOPmS7roCpVrUlJaD/YI3MYqJFA7Nsd1rcHA0fU+Hyn79cgCi31XekN1b+4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 370782082fa211f0b29709d653e92f7d-20250513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:cd0b143e-f236-475e-bb50-e6b49b8ffbc7,IP:0,U
	RL:0,TC:1,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-24
X-CID-META: VersionHash:6493067,CLOUDID:c3fa1de45e79c83e76c04d5cf56d6e95,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102,TC:0,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 370782082fa211f0b29709d653e92f7d-20250513
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1201376049; Tue, 13 May 2025 10:30:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1D6E0E003505;
	Tue, 13 May 2025 10:30:20 +0800 (CST)
Received: by mail.kylinos.cn (NSMail, from userid 0)
	id 14946E006100; Tue, 13 May 2025 10:30:20 +0800 (CST)
From: =?UTF-8?B?5byg5a2Q5qyi?= <zhangzihuan@kylinos.cn>
Subject: =?UTF-8?B?UmU6IFJlOiBbUEFUQ0ggdjFdIEFDUEk6IGJhdHRlcnk6IFJlZHVjZSB1bm5lY2Vzc2FyeSBjYWxscyB0byBhY3BpX2JhdHRlcnlfdXBkYXRlKCk=?=
To: 	=?UTF-8?B?UmFmYWVsIEouIFd5c29ja2k=?= <rafael@kernel.org>,
Cc: 	=?UTF-8?B?cmFmYWVs?= <rafael@kernel.org>,
	=?UTF-8?B?bGVuYg==?= <lenb@kernel.org>,
	=?UTF-8?B?bGludXgtYWNwaQ==?= <linux-acpi@vger.kernel.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
Date: Tue, 13 May 2025 10:30:19 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <1b46kma6jpr-1b47uk3lljk@nsmail7.0.0--kylin--1>
References: CAJZ5v0guh4MGJpaCoh3Guc8BL_37=KHWW10wvK+iD6jZLvZWwg@mail.gmail.com
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Tue, 13 May 2025 10:30:19 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-1dq81r8c76a-1dq9bp1r903
X-ns-mid: webmail-6822aebb-1dlfrxww
X-ope-from: <zhangzihuan@kylinos.cn>

This message is in MIME format.

--nsmail-1dq81r8c76a-1dq9bp1r903
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+Jmd0OyZndDsgV2hlbiBlbnRlcmluZyB0aGUgYWNwaV9tYXR0ZXJ5X25v
dGlmeSBmdW5jdGlvbiwgbm8gbWF0dGVyIHdoYXQgdGhlIGV2ZW50PGJyPiZn
dDsmZ3Q7IGlzLCBhY3BpX21hdHRlcnlfdXBkYXRlIHdpbGwgZGVmaW5pdGVs
eSBiZSBjYWxsZWQuPGJyPjxicj4mZ3Q7IEkgdGhpbmsgeW91IG1lYW4gYWNw
aV9iYXR0ZXJ5X3VwZGF0ZSgpLjwvcD4KPHA+PGJyPlRoYW5rcyBmb3IgeW91
ciByZXZpZXcuPC9wPgo8cD48YnI+Jmd0OyZndDsgRmlybXdhcmUgbWFudWZh
Y3R1cmVycyB3aWxsIGN1c3RvbWl6ZSBzb21lIGV2ZW50cyBsaWtlIDB4MCwg
c288YnI+Jmd0OyZndDsgbm9uLW1hdGNoaW5nIGV2ZW50cyB3aWxsIGJlIGln
bm9yZWQuPGJyPiZndDs8YnI+Jmd0O0kgZG9uJ3QgcXVpdGUgZ2V0IHdoYXQg
eW91IGFyZSB0cnlpbmcgdG8gYWNoaWV2ZSBoZXJlLjwvcD4KPHA+PGJyPldo
aWxlIHRoZSBsYXB0b3AgaXMgY2hhcmdpbmcsIGFjcGlfYmF0dGVyeV9ub3Rp
ZnkoKSByZWNlaXZlcyBhIHN0ZWFkeSBzdHJlYW0gb2YgMHg4MSBldmVudHMs
IGFuZCBvbmx5IHJlY2VpdmVzIDB4ODAgZXZlbnRzPC9wPgo8cD53aGVuIHRo
ZSBiYXR0ZXJ5IGlzIGFsbW9zdCBmdWxseSBjaGFyZ2VkIG9yJm5ic3A7IHRo
ZSBhZGFwdGVyIGlzIHBsdWdnZWQgaW4uIElmIGFjcGlfYmF0dGVyeV91cGRh
dGUoKSBpcyBqdXN0IHRvPC9wPgo8cD51cGRhdGUgdGhlIGJhdHRlcnkgc3Rh
dHVzLCZuYnNwOyBpdCBkaWRuJ3QgbmVlZCB0byBiZSBjYWxsZWQgZnJlcXVl
bnRseS48L3A+CjxwPjxicj4mZ3Q7Jmd0OyBTaWduZWQtb2ZmLWJ5OiB6aGFu
Z3ppaHVhbiA8YnI+Jmd0OyZndDsgLS0tPGJyPiZndDsmZ3Q7IGRyaXZlcnMv
YWNwaS9iYXR0ZXJ5LmMgfCAzICsrLTxicj4mZ3Q7Jmd0OyAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pPGJyPiZndDsm
Z3Q7PGJyPiZndDsmZ3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYmF0
dGVyeS5jIGIvZHJpdmVycy9hY3BpL2JhdHRlcnkuYzxicj4mZ3Q7Jmd0OyBp
bmRleCA2NzYwMzMwYThhZjUuLjk0NDZjNTdiNzdlNyAxMDA2NDQ8YnI+Jmd0
OyZndDsgLS0tIGEvZHJpdmVycy9hY3BpL2JhdHRlcnkuYzxicj4mZ3Q7Jmd0
OysrKyBiL2RyaXZlcnMvYWNwaS9iYXR0ZXJ5LmM8YnI+Jmd0OyZndDsgQEAg
LTEwODMsNyArMTA4Myw4IEBAIHN0YXRpYyB2b2lkIGFjcGlfYmF0dGVyeV9u
b3RpZnkoYWNwaV9oYW5kbGUgaGFuZGxlLCB1MzIgZXZlbnQsIHZvaWQgKmRh
dGEpPGJyPiZndDsmZ3Q7IG1zbGVlcChiYXR0ZXJ5X25vdGlmaWNhdGlvbl9k
ZWxheV9tcyk7PGJyPiZndDsmZ3Q7IGlmIChldmVudCA9PSBBQ1BJX0JBVFRF
UllfTk9USUZZX0lORk8pPGJyPiZndDsmZ3Q7IGFjcGlfYmF0dGVyeV9yZWZy
ZXNoKGJhdHRlcnkpOzxicj4mZ3Q7Jmd0OyAtIGFjcGlfYmF0dGVyeV91cGRh
dGUoYmF0dGVyeSwgZmFsc2UpOzxicj4mZ3Q7Jmd0OyArIGlmIChldmVudCA9
PSBBQ1BJX0JBVFRFUllfTk9USUZZX1NUQVRVUyk8YnI+Jmd0OyZndDsgKyBh
Y3BpX2JhdHRlcnlfdXBkYXRlKGJhdHRlcnksIGZhbHNlKTs8YnI+Jmd0Ozxi
cj4mZ3Q7IFNvIG9ubHkgY2FsbCBhY3BpX2JhdHRlcnlfdXBkYXRlKCkgZm9y
IEFDUElfQkFUVEVSWV9OT1RJRllfU1RBVFVTLjxicj4mZ3Q7PGJyPiZndDsg
V2h5IGRvIHlvdSB0aGluayB0aGlzIGlzIHRoZSBvbmx5IGNhc2UgaW4gd2hp
Y2ggYWNwaV9iYXR0ZXJ5X3VwZGF0ZSgpPGJyPiZndDsgbmVlZHMgdG8gYmUg
Y2FsbGVkPzwvcD4KPHA+PGJyPmFjcGlfYmF0dGVyeV91cGRhdGUoKSBjYWxs
cyBhY3BpX2JhdHRlcnlfZ2V0X3N0YXR1cygpIHRvIGdldCB0aGUgYmF0dGVy
eSB1cGRhdGUgc3RhdHVzLiBJdCB3aWxsIG9ubHkgYmUgdXBkYXRlZDwvcD4K
PHA+aWYgaXQgcmVjZWl2ZXMgYW4gZXZlbnQgdGhhdCB0aGUgYmF0dGVyeSBz
dGF0dXMgaGFzIGNoYW5nZWQuPC9wPg==

--nsmail-1dq81r8c76a-1dq9bp1r903--

