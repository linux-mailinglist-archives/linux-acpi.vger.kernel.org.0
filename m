Return-Path: <linux-acpi+bounces-7850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9417895FDDD
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 01:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375431F22ECF
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D3A19B59F;
	Mon, 26 Aug 2024 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="OGjj+9G6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C93A1494CF;
	Mon, 26 Aug 2024 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724716737; cv=none; b=V46/KnhTv/Y/up3Pcpo4UMVTe9VFg9uXwiuiBx3E0GRuEXKjnsQdECEUdcl46yM1cNEn/g7eTLhkBgzeEZnbe89Ec7XhC1w3Pvvx1hL6is0VxG3oFHMIyqogZN7iPqup4Vn5obDNSQTxFriI+x1CXOrKLzqCKdBZ4SdAyk5x8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724716737; c=relaxed/simple;
	bh=nUxLJotlRFoie2z1KF7VG7SqPZm71IRkxR8soOR/bP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NKA72a65f8RaJLVZOYRmLrNP0h9NppAPG8H/3GDXeldyNbc/JzAL2vtTWonfZcMFLLKQSQyoR6R7a1SWIMjhj/jKF0Ngk1iIO2dccRpIG8fngP0RA5SZwaGRYMj3uR3dqHPOo2I7Ja3R4XV3Pwv/fdxIWYT/1hfBfEb2/zCtHws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=OGjj+9G6 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=lYvDMtU32GzRUMqBUsd+A3LiN5p58lzdAs5JVRbFdOg=; b=O
	Gjj+9G6heFpV3s/b6y3M2dwLljRcLJsGIKV5UTsQ/EdwhABirXVqvy15/2TvNMzj
	oCYpX2YC+jTe0BjKVIR+JMfCzvEJLQnITHx8fdLUfyR1xw8mK+Tc38Fxc+ncZHKj
	ZCgPXKNfBLz+TVvGf4SsOwgu89Vv/hz+2a7u1lljd4=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-120 (Coremail) ; Tue, 27 Aug 2024 07:58:32 +0800
 (CST)
Date: Tue, 27 Aug 2024 07:58:32 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: rafael@kernel.org, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re:[PATCH] Add rev and func to warning message when
 acpi_evaluate_dsm failed.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240826043858.4292-1-00107082@163.com>
References: <20240826043858.4292-1-00107082@163.com>
X-NTES-SC: AL_Qu2ZBvuauU8q5COfZukXn0oTju85XMCzuv8j3YJeN500qiTB+iklRXJ/B3zW+u6qFgS3vRWqTjpD8cFbQ7JIR7qo95lFP/wY86hIRFIatsl3
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d43b414.1fb.191912081ba.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f8qpFs1mRrsiAA--.65311W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQVHqmVOCdN33QACsY
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SSBtYWRlIGEgbWlzdGFrZSBhYm91dCB0aGUgcGF0Y2ggdGl0bGUsIHBsZWFzZSBpZ25vcmUgdGhp
cyBhbmQgSSB3aWxsIHNlbmQgYW5vdGhlciBvbmUuCgpEYXZpZAoKQXQgMjAyNC0wOC0yNiAxMjoz
ODo1OCwgIkRhdmlkIFdhbmciIDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToKPldoZW4gYWNwaV9l
dmFsdWF0ZV9kc20gZmFpbGVkLCB0aGUgd2FybmluZyBtZXNzYWdlIGxhY2tzIHRoZSByZXYKPmFu
ZCBmdW5jIGluZm9ybWF0aW9uIHdoaWNoIGlzIGF2YWlsYWJsZSBhbmQgaGVscGZ1bC4gRm9yIGV4
YW1wbGUsCj5pd2x3aWZpIHdvdWxkIG1ha2UgRFNNIHF1ZXJpZXMgZm9yIGxhcmkgY29uZmlnLCBh
bmQgd2l0aCBzb21lIEhXLAo+RFNNIGVycm9yIHdvdWxkIHJldHVybjoKPglBQ1BJOiBcOiBmYWls
ZWQgdG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJmMi03ODhmLWM2NGQtYTViMy0xZjczOGUyODVhZGUg
KDB4MTAwMSkKPglBQ1BJOiBcOiBmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJmMi03ODhm
LWM2NGQtYTViMy0xZjczOGUyODVhZGUgKDB4MTAwMSkKPglBQ1BJOiBcOiBmYWlsZWQgdG8gZXZh
bHVhdGUgX0RTTSBiZjAyMTJmMi03ODhmLWM2NGQtYTViMy0xZjczOGUyODVhZGUgKDB4MTAwMSkK
PglBQ1BJOiBcOiBmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJmMi03ODhmLWM2NGQtYTVi
My0xZjczOGUyODVhZGUgKDB4MTAwMSkKPglBQ1BJOiBcOiBmYWlsZWQgdG8gZXZhbHVhdGUgX0RT
TSBiZjAyMTJmMi03ODhmLWM2NGQtYTViMy0xZjczOGUyODVhZGUgKDB4MTAwMSkKPglBQ1BJOiBc
OiBmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJmMi03ODhmLWM2NGQtYTViMy0xZjczOGUy
ODVhZGUgKDB4MTAwMSkKPglBQ1BJOiBcOiBmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJm
Mi03ODhmLWM2NGQtYTViMy0xZjczOGUyODVhZGUgKDB4MTAwMSkKPglBQ1BJOiBcOiBmYWlsZWQg
dG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJmMi03ODhmLWM2NGQtYTViMy0xZjczOGUyODVhZGUgKDB4
MTAwMSkKPldpdGggdGhpcyBwYXRjaCwgdGhlIHdhcm5pbmcgd291bGQgYmUgbW9yZSBpbmZvcm1h
dGl2ZToKPglBQ1BJOiBcOiBmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJmMi03ODhmLWM2
NGQtYTViMy0xZjczOGUyODVhZGUgcmV2OjAgZnVuYzoxICgweDEwMDEpCj4JQUNQSTogXDogZmFp
bGVkIHRvIGV2YWx1YXRlIF9EU00gYmYwMjEyZjItNzg4Zi1jNjRkLWE1YjMtMWY3MzhlMjg1YWRl
IHJldjowIGZ1bmM6NiAoMHgxMDAxKQo+CUFDUEk6IFw6IGZhaWxlZCB0byBldmFsdWF0ZSBfRFNN
IGJmMDIxMmYyLTc4OGYtYzY0ZC1hNWIzLTFmNzM4ZTI4NWFkZSByZXY6MCBmdW5jOjcgKDB4MTAw
MSkKPglBQ1BJOiBcOiBmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJmMi03ODhmLWM2NGQt
YTViMy0xZjczOGUyODVhZGUgcmV2OjAgZnVuYzo4ICgweDEwMDEpCj4JQUNQSTogXDogZmFpbGVk
IHRvIGV2YWx1YXRlIF9EU00gYmYwMjEyZjItNzg4Zi1jNjRkLWE1YjMtMWY3MzhlMjg1YWRlIHJl
djowIGZ1bmM6MyAoMHgxMDAxKQo+CUFDUEk6IFw6IGZhaWxlZCB0byBldmFsdWF0ZSBfRFNNIGJm
MDIxMmYyLTc4OGYtYzY0ZC1hNWIzLTFmNzM4ZTI4NWFkZSByZXY6MCBmdW5jOjkgKDB4MTAwMSkK
PglBQ1BJOiBcOiBmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSBiZjAyMTJmMi03ODhmLWM2NGQtYTVi
My0xZjczOGUyODVhZGUgcmV2OjAgZnVuYzoxMCAoMHgxMDAxKQo+CUFDUEk6IFw6IGZhaWxlZCB0
byBldmFsdWF0ZSBfRFNNIGJmMDIxMmYyLTc4OGYtYzY0ZC1hNWIzLTFmNzM4ZTI4NWFkZSByZXY6
MCBmdW5jOjEyICgweDEwMDEpCj4KPlNpZ25lZC1vZmYtYnk6IERhdmlkIFdhbmcgPDAwMTA3MDgy
QDE2My5jb20+Cj4tLS0KPiBkcml2ZXJzL2FjcGkvdXRpbHMuYyB8IDMgKystCj4gMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJp
dmVycy9hY3BpL3V0aWxzLmMgYi9kcml2ZXJzL2FjcGkvdXRpbHMuYwo+aW5kZXggYWU5Mzg0Mjgy
MjczLi42ZGU1NDJkOTk1MTggMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2FjcGkvdXRpbHMuYwo+Kysr
IGIvZHJpdmVycy9hY3BpL3V0aWxzLmMKPkBAIC04MDEsNyArODAxLDggQEAgYWNwaV9ldmFsdWF0
ZV9kc20oYWNwaV9oYW5kbGUgaGFuZGxlLCBjb25zdCBndWlkX3QgKmd1aWQsIHU2NCByZXYsIHU2
NCBmdW5jLAo+IAo+IAlpZiAocmV0ICE9IEFFX05PVF9GT1VORCkKPiAJCWFjcGlfaGFuZGxlX3dh
cm4oaGFuZGxlLAo+LQkJCQkgImZhaWxlZCB0byBldmFsdWF0ZSBfRFNNICVwVWIgKDB4JXgpXG4i
LCBndWlkLCByZXQpOwo+KwkJCQkgImZhaWxlZCB0byBldmFsdWF0ZSBfRFNNICVwVWIgcmV2OiVs
bGQgZnVuYzolbGxkICgweCV4KVxuIiwKPisJCQkJIGd1aWQsIHJldiwgZnVuYywgcmV0KTsKPiAK
PiAJcmV0dXJuIE5VTEw7Cj4gfQo+LS0gCj4yLjM5LjIK

