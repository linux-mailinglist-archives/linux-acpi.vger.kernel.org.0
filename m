Return-Path: <linux-acpi+bounces-17956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F145CBEF28E
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 05:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06F414EAD18
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF8248176;
	Mon, 20 Oct 2025 03:12:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89851F63CD;
	Mon, 20 Oct 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929944; cv=none; b=LqDToMh+Q4CfpruO1WTczm7rZd5eHRPS+YVR0qJ7W7USASl2lFjHp3TEKPA0AfPY+5lXZLV7MEy0z8P7IDG+penGKr8muhpMtVsjtV5aEQX+kIqrLUu4U3cpddL78CmmqeGaQxES8+j/zZs+HX4UzyLs3TYIOij/ehhyMFmzVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929944; c=relaxed/simple;
	bh=f6IuFtSaQiz8+JQHGBTlFmc5TjNx/7yBYYh3Vm2K3FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRoDiBQx7ZyQC+qJPrOgIHz6/y9jw2EqJf7Q/BCCSYKBKP3BZjD7upHBkoGA6LKIPIOGZoG0uWQCtPKUhtLEcsbZI3GKBWb0nv5jK9VvJETmBXrYRWI0GFWXA7F5FzPKYEOIjDnjFExK60En7FlUPPzOmpwpp4zsRMDqdrehKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8febad8ead6211f0a38c85956e01ac42-20251020
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	UD_TRUSTED
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c28fa9b8-aaa1-4d53-b79b-a1a5ae9da1b0,IP:10,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:38
X-CID-INFO: VERSION:1.3.6,REQID:c28fa9b8-aaa1-4d53-b79b-a1a5ae9da1b0,IP:10,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:38
X-CID-META: VersionHash:a9d874c,CLOUDID:c5a9f3683d2c2f19ed87449a4201ed05,BulkI
	D:25102011121004M9IT46,BulkQuantity:0,Recheck:0,SF:16|19|24|38|44|66|78|10
	2|850,TC:nil,Content:0|50,EDM:5,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8febad8ead6211f0a38c85956e01ac42-20251020
X-User: huangsiyuan@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <huangsiyuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2112434053; Mon, 20 Oct 2025 11:12:08 +0800
From: Siyuan Huang <huangsiyuan@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org
Cc: linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siyuan Huang <huangsiyuan@kylinos.cn>
Subject: [PATCH] rust: acpi: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Mon, 20 Oct 2025 11:12:04 +0800
Message-Id: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>
---
 rust/kernel/acpi.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 7ae317368b00..f9488be9249c 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -42,9 +42,7 @@ pub const fn new(id: &'static CStr) -> Self {
             "ID exceeds 16 bytes"
         );
         let src = id.as_bytes_with_nul();
-        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
-        // SAFETY: FFI type is valid to be zero-initialized.
-        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
+        let mut acpi: bindings::acpi_device_id = pin_init::zeroed();
         let mut i = 0;
         while i < src.len() {
             acpi.id[i] = src[i];
-- 
2.25.1


