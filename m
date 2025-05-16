Return-Path: <linux-acpi+bounces-13740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDADAB9408
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 04:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D3E1BC4CF8
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 02:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E522A4CD;
	Fri, 16 May 2025 02:28:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87D0227E84;
	Fri, 16 May 2025 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362534; cv=none; b=Viu/gq7D5kKCPPuXI/qtCo3kNvJENZcFJwMtssmynLvvZ1ZxpICEiYaJdnQtmrhf2ubSxWut91I/b/F9enyPznjoAdc6/YlL+9ZGxJlAtKkwMv5wgyFwJwu7PNSal4PqIb9CJCFMoS5dVwlicl8+WRi51LROLjUrHtnJnN2Qyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362534; c=relaxed/simple;
	bh=fPPCqqWx4J7tkQlGwFMmh1gpZkeVhZ7FEm6Z4kNAPj4=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=UFjvQicx4cVsEBH6BDBzk3RYhyhgr247yjU2RmzzBzDbkPplu9s1ADM4IHXOeMA+cYPZNb9N63jK1J8nethxySssxjSFsNiroTet9i56hHRvprEH4rmPKt9pjexZUP92m2Ar/+uE/sWW/aYtOeXUWyRxSUnMPHYXa3NNUe4iayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7b86c5d031fd11f0b29709d653e92f7d-20250516
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8b2285b2-c8f6-469c-8c9d-0d090eef8c87,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:465bb5e0c4ae257e02329f0e8226590e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102,TC:0,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b86c5d031fd11f0b29709d653e92f7d-20250516
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 318472205; Fri, 16 May 2025 10:28:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 84BA8E003505;
	Fri, 16 May 2025 10:28:41 +0800 (CST)
Received: by mail.kylinos.cn (NSMail, from userid 0)
	id 770ADE006100; Fri, 16 May 2025 10:28:41 +0800 (CST)
From: =?UTF-8?B?5byg5a2Q5qyi?= <zhangzihuan@kylinos.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MV0gQUNQSTogYmF0dGVyeTogUmVkdWNlIHVubmVjZXNzYXJ5IGNhbGxzIHRvIGFjcGlfYmF0dGVyeV91cGRhdGUoKQ==?=
To: 	=?UTF-8?B?cmFmYWVs?= <rafael@kernel.org>,
Cc: 	=?UTF-8?B?cmFmYWVs?= <rafael@kernel.org>,
	=?UTF-8?B?bGVuYg==?= <lenb@kernel.org>,
	=?UTF-8?B?bGludXgtYWNwaQ==?= <linux-acpi@vger.kernel.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
Date: Fri, 16 May 2025 10:28:41 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <akgj8nk6ez-akht6gz88s@nsmail7.0.0--kylin--1>
References: CAJZ5v0guh4MGJpaCoh3Guc8BL_37=KHWW10wvK+iD6jZLvZWwg@mail.gmail.com
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Fri, 16 May 2025 10:28:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-dc7gm6101q-dc8qjzg1vj
X-ns-mid: webmail-6826a2d9-d61f5za6
X-ope-from: <zhangzihuan@kylinos.cn>

This message is in MIME format.

--nsmail-dc7gm6101q-dc8qjzg1vj
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBpZD0icmUiIHN0eWxlPSJtYXJnaW4tbGVmdDogMC41ZW07IHBhZGRp
bmctbGVmdDogMC41ZW07IGJvcmRlci1sZWZ0OiAxcHggc29saWQgZ3JlZW47
Ij4KPGRpdiBpZD0iY29udGVudCI+CjxkaXYgY2xhc3M9InZpZXdlcl9wYXJ0
IiBzdHlsZT0icG9zaXRpb246IHJlbGF0aXZlOyI+CjxkaXY+SGkgUmFmYWVs
LDxicj5UaGFuayB5b3UgZm9yIHRoZSByZXZpZXchPC9kaXY+CjxkaXY+Jm5i
c3A7PC9kaXY+CjxkaXY+Jmd0OyBPbiBUdWUsIEFwciAyMiwgMjAyNSBhdCAx
MToxMeKAr0FNIHpoYW5nemlodWFuIHdyb3RlOjxicj4mZ3Q7Jmd0Ozxicj4m
Z3Q7Jmd0OyBXaGVuIGVudGVyaW5nIHRoZSBhY3BpX21hdHRlcnlfbm90aWZ5
IGZ1bmN0aW9uLCBubyBtYXR0ZXIgd2hhdCB0aGUgZXZlbnQ8YnI+Jmd0OyZn
dDsgaXMsIGFjcGlfbWF0dGVyeV91cGRhdGUgd2lsbCBkZWZpbml0ZWx5IGJl
IGNhbGxlZC48YnI+Jmd0Ozxicj4mZ3Q7IEkgdGhpbmsgeW91IG1lYW4gYWNw
aV9iYXR0ZXJ5X3VwZGF0ZSgpLjxicj4mZ3Q7Jm5ic3A7PC9kaXY+CjxkaXY+
Jm5ic3A7PC9kaXY+CjxkaXY+UmlnaHQuPC9kaXY+CjxkaXY+Jm5ic3A7PC9k
aXY+CjxkaXY+Jmd0OyZndDsgVXNlIHRoZSBhY3BpX2xpc3RlbiBjb21tYW5k
IHRvIGxpc3Rlbiwgc29tZXRpbWVzIHRoZSBsb2cgbG9va3MgbGlrZSB0aGlz
Ojxicj4mZ3Q7Jmd0Ozxicj4mZ3Q7Jmd0OyBiYXR0ZXJ5IHh4eDowMCAwMDAw
MDA4MSAwMDAwMDAwMTxicj4mZ3Q7Jmd0OyBiYXR0ZXJ5IHh4eDowMCAwMDAw
MDAwMCAwMDAwMDAwMTxicj4mZ3Q7Jmd0OyBiYXR0ZXJ5IHh4eDowMCAwMDAw
MDA4MCAwMDAwMDAwMTxicj4mZ3Q7Jmd0Ozxicj4mZ3Q7Jmd0OyBGaXJtd2Fy
ZSBtYW51ZmFjdHVyZXJzIHdpbGwgY3VzdG9taXplIHNvbWUgZXZlbnRzIGxp
a2UgMHgwLCBzbzxicj4mZ3Q7Jmd0OyBub24tbWF0Y2hpbmcgZXZlbnRzIHdp
bGwgYmUgaWdub3JlZC48YnI+Jmd0Ozxicj4mZ3Q7IEkgZG9uJ3QgcXVpdGUg
Z2V0IHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gYWNoaWV2ZSBoZXJlLjxicj4m
Z3Q7PC9kaXY+CjxkaXY+Jm5ic3A7PC9kaXY+CjxkaXY+V2hpbGUgdGhlIGxh
cHRvcCBpcyBjaGFyZ2luZywgYWNwaV9iYXR0ZXJ5X25vdGlmeSgpIHJlY2Vp
dmVzIGEgc3RlYWR5IHN0cmVhbSBvZiAweDgxIGV2ZW50cywgYW5kIG9ubHkg
cmVjZWl2ZXMgMHg4MCBldmVudHM8YnI+d2hlbiB0aGUgYmF0dGVyeSBpcyBh
bG1vc3QgZnVsbHkgY2hhcmdlZCBvciB0aGUgYWRhcHRlciBpcyBwbHVnZ2Vk
IGluLiBJZiBhY3BpX2JhdHRlcnlfdXBkYXRlKCkgaXMganVzdCB0bzxicj51
cGRhdGUgdGhlIGJhdHRlcnkgc3RhdHVzLCBpdCBkaWRuJ3QgbmVlZCB0byBi
ZSBjYWxsZWQgZnJlcXVlbnRseS48L2Rpdj4KPGRpdj48YnI+Jmd0OyZndDsg
U2lnbmVkLW9mZi1ieTogemhhbmd6aWh1YW4gPGJyPiZndDsmZ3Q7IC0tLTxi
cj4mZ3Q7Jmd0OyBkcml2ZXJzL2FjcGkvYmF0dGVyeS5jIHwgMyArKy08YnI+
Jmd0OyZndDsgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKTxicj4mZ3Q7Jmd0Ozxicj4mZ3Q7Jmd0OyBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9hY3BpL2JhdHRlcnkuYyBiL2RyaXZlcnMvYWNwaS9iYXR0
ZXJ5LmM8YnI+Jmd0OyZndDsgaW5kZXggNjc2MDMzMGE4YWY1Li45NDQ2YzU3
Yjc3ZTcgMTAwNjQ0PGJyPiZndDsmZ3Q7IC0tLSBhL2RyaXZlcnMvYWNwaS9i
YXR0ZXJ5LmM8YnI+Jmd0OyZndDsgKysrIGIvZHJpdmVycy9hY3BpL2JhdHRl
cnkuYzxicj4mZ3Q7Jmd0OyBAQCAtMTA4Myw3ICsxMDgzLDggQEAgc3RhdGlj
IHZvaWQgYWNwaV9iYXR0ZXJ5X25vdGlmeShhY3BpX2hhbmRsZSBoYW5kbGUs
IHUzMiBldmVudCwgdm9pZCAqZGF0YSk8YnI+Jmd0OyZndDsmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwO21zbGVlcChiYXR0ZXJ5X25vdGlmaWNhdGlvbl9kZWxheV9tcyk7
PGJyPiZndDsmZ3Q7IGlmIChldmVudCA9PSBBQ1BJX0JBVFRFUllfTk9USUZZ
X0lORk8pPGJyPiZndDsmZ3Q7Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDthY3BpX2JhdHRl
cnlfcmVmcmVzaChiYXR0ZXJ5KTs8YnI+Jmd0OyZndDsgLSBhY3BpX2JhdHRl
cnlfdXBkYXRlKGJhdHRlcnksIGZhbHNlKTs8YnI+Jmd0OyZndDsgKyBpZiAo
ZXZlbnQgPT0gQUNQSV9CQVRURVJZX05PVElGWV9TVEFUVVMpPGJyPiZndDsm
Z3Q7ICsgYWNwaV9iYXR0ZXJ5X3VwZGF0ZShiYXR0ZXJ5LCBmYWxzZSk7PGJy
PiZndDs8YnI+Jmd0O1NvIG9ubHkgY2FsbCBhY3BpX2JhdHRlcnlfdXBkYXRl
KCkgZm9yIEFDUElfQkFUVEVSWV9OT1RJRllfU1RBVFVTLjxicj4mZ3Q7PC9k
aXY+CjxkaXY+Jm5ic3A7PC9kaXY+CjxkaXY+YWNwaV9iYXR0ZXJ5X3VwZGF0
ZSgpIGNhbGxzIGFjcGlfYmF0dGVyeV9nZXRfc3RhdHVzKCkgdG8gZ2V0IHRo
ZSBiYXR0ZXJ5IHVwZGF0ZSBzdGF0dXMuIEl0IHdpbGwgb25seSBiZSB1cGRh
dGVkPGJyPmlmIGl0IHJlY2VpdmVzIGFuIGV2ZW50IHRoYXQgdGhlIGJhdHRl
cnkgc3RhdHVzIGhhcyBjaGFuZ2VkLjxicj5XaHkgZG8geW91IHRoaW5rIHRo
aXMgaXMgdGhlIG9ubHkgY2FzZSBpbiB3aGljaCBhY3BpX2JhdHRlcnlfdXBk
YXRlKCk8YnI+bmVlZHMgdG8gYmUgY2FsbGVkPzwvZGl2Pgo8L2Rpdj4KPC9k
aXY+CjwvZGl2Pg==

--nsmail-dc7gm6101q-dc8qjzg1vj--

