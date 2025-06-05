Return-Path: <linux-acpi+bounces-14150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFF1ACF164
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 15:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED995174391
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913DC272E7C;
	Thu,  5 Jun 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gpWy8An+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA4266B46
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jun 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131854; cv=none; b=OqUan2nJrmD1FzGrACIo5TleRdRcoiSRRyZ8KGzKnkWc+BG9GANLJ5cWU9oZtIFy0HNvXTWvRZLz4CAguYT9t4yl3l5/Dx88p+Lnwb6/dNydJ+aio+ACJNXNL6zWdViIy6ejtfbGYrgUSVDxlKe6jNYAtO2tg+ASCr2Pt6oPbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131854; c=relaxed/simple;
	bh=vLM/1Fwlx8b+UK1HL4acBgZkNMtY/ECcZtBJAw5i8kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQK5KE9Q2uTOlmXqdpO1UPQmfxsn2T78vViflixVMGO6TTtjWBACcD1Gs1sdrzrmRWNRwRpFRwLFBoxy0WeeV1zvbZrtgZwnFQieYuoxjdVmzz08aBZ6l49meIHSD4hcD2p7XAlVuCkYDP1tqW8+9DqQ1C/+YjSfHZ4+wtcYysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gpWy8An+; arc=none smtp.client-ip=66.163.190.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749131846; bh=7Pij581zFWjUHqr6AUe1QrFQplXSla6n2vA3DY/kqa4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gpWy8An+JRoWSzveSq2D6pEJhW6mrJNsby2j017NTTU8rHOnd9EDl5C2i2tMxgVaACbD7Iu+s1P9rXeJ89qAzU80jXj6EqPhHwWR0BShz1Mb/1ALz8ffI1vpDMFshBCN1CI0mjMcsnbYsCCZv808RMc/iLyjd1OmroCQdQa34qhlrgozyKIaddlSbpuyoQZ2jk0hmsiT5K7FUTW0VQlSBeCR4gKfG3e+C4fBjfPHxrsHE6R58xFcyprZK1Mj8qvv5BHLcQkkpmD1ZZjXHBnMS2KLreiBCo7CUd4w6J4+NrhktcKNeG5sv8n3ujE7j8bHknKeU/Hcb+RU3oFu1KpAPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749131846; bh=+0Wh3eI2F1SO811zLel0DC36S2dzMgVS6IxKU8+vCBv=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rRuij+LZiIuUwzyrfkYvId7f7tw4VHYJOLKLxT7wvr/NEy9JvvvqgUNRdvV7a3ZZUTNeX9aSEe7BzfRTnjANyOZND6F3JvFSiJuFZipLfcldTfdA0LABSIf8cl1RdfDMu8t5BwOGubR2E7q/DCqGcoatf/4ZaJi6oAU1XGDwUkWABsECa8RdZ7wdOpSAXvAdyRJirMovhAlrhmyEyv9bGinyk0LU7tY77uVNgk4yAP2yF5c8jGTDw5btNIGC+9G/rDokGTtpoeqI6007OP6IKHzYBs1+HR8NuniQCAG812NdB9AtPxs8eP8iVH7HzkpGHEaGrOYx7ojTy76ardOyqw==
X-YMail-OSG: fwBjBwAVM1kZM4WGig35UZ.bs419msPgG20iG_FR3ESJtpOV9SQ1dZ7HOSrgjwZ
 w0Gh1yFKMs3huH9kd8ZyxbLiCU9DfDLwHHoTUV7s32cytmTdOEm8DqGuYlQ77JlZULJyoMqYr.wC
 0c4vx8VfE63PmXs6nPPyOfPllt.MKeUduRC27IwhLnK53Q1gCO3WxLPgHXvtRsBr8ZQf72t7UTA2
 PIJimt3uMNz2iDHx0CvpRmh07wQTrY1cXgMyFyzcIop5Y.Un865rsxv_703TvbkAEpoYsCe7UK67
 QuUZd8zJQ5m03q5hX2ehMmNZm4voHNbTnu5EH_nl8cLONlMCfgKj30fVc4S8LilwbHQeb__dgNgO
 vUCZwcOA5gdhiGFSo2c4qpvUJiOqtQGyfTKjAyq3IlY_GnjAEcoGdegZcFcwSP69Q4TSQs.hTvNn
 rAAPaYGPEWHwqA4LQjcr4EHpV7uWzUKPk8FjL.nUaBSysjuvhaMTmQKvf.FGXOJbBKPiWpYmjopD
 Rp1axoD76BCKCBBy5cMPIfVBecDxdYbrod18XvHG5N6xehfZJIZUf0RsUtGkWKD33id2Ij3raaSN
 q8R7_POeOBsnVfYbqUJTVPgEVcwecillchl86tn26spnRQTPyJT9IF7bLYiUrMne4EhQ3c86x6vv
 muTW7F9w0zqVI3LSSDdfzxjs5jSHo26kpkQ4DlI5uQCYD_x1WwWLd6KdLPMGeQwylQVKVWpsDWc9
 LoqxAS2fEOfQnHuejEtza05dwRH3vCLWaVH0h9ZiHUtx_M_3OxoaCVHH1Si9AFP95QmMOS.9uL2L
 OS_mF1nbN0_h9h21u8wxi7Ubugqqq6H.DPMoZ2rR719Iebg3TKGHHXKyIDg96MSvNCVmOujmk_xt
 gS4mHnV.xj8JxGHlqDL3rZ4hbifKmVFk6eE2NGBPUDzT1XsvjxVOGw.Js2WSpnmadUSrVnBR11zP
 DGslLZT1jqxP6_5XshUwZUqqkzZJjPrqhb0Us4K82ab1s.gu4Ilgo.eCmgyGcA9wbnUMYc.eJOiP
 6fx.NhrbCO7sK35EZopZc0DIBMrXVpPCKV2TrpHyB0NWy4o6ta3OsYdWSsXW_LmsKn5iqFOc5P0u
 CQPKOBvc7H9.Ya1YAj5DnbjYdwUSrv9ug79d7rDDVAmh9kFMG3ukX8FKZEUNKajrSc8y0KaQZIBz
 eAMKQVMd64hnIKrlV5e3Ld9lHffAJ3CNXSIEH54xi4DaBzc2qgHtqFRi6quqPkZaHm.U8boKWFUt
 j5iRyzkqhZz83PugOjBcqBkESWCZqpRvlxogkNbmsHiXXR.0htA5f5r2fYSoaDL2fBICNDR3n44s
 7oTktF9oV3xnJs4FjgMDKPi.vo1zQQRkFeBcBAvRwyZ46AJ7XlFH07jcFUsfjJn7Fs2oAWVRftfa
 7J0bQcyLwJgajlGoZikGOPehIORutMlvB.zLRTT_TptOOnVKtf.pilZsKUXRd.CZ2HbC3kywJEaI
 eLcwMxeDBjr.oj6BEfEOH81GVMkIRvliaHl_j_vlCyTSywu58dsIZbiJQcAJspojyS_WDrFiWjac
 TGM1oXHpdTXMFYBsH6b_8s23CrD3LQx3G387npJ8arpPC3dimMu.VMeGeVwZbYfqMrcIiZWqPm1d
 rqBaOZveyMb0GD5yyHeOosFja5ud1HK41gT3Hr_a5titim7ElZP3V0Trakvj5umU1KC3wHqP8Y1W
 GLjHC_9Mak1sOHCNCHqp58pOwoN.q0oaBfKzH_6baqdbVZZjaTJtMkdAYlZbco6nts_quu2r6QmN
 NMEJML0YOQX9AAWyyfKyizmMDD0tbpOk_H2gg1S6zFcZsMR8yM10A8EBcgpJY8Owcbww2GefyMtC
 wV2PXVc8j3rdCVZOgjDTjmWKkk.ERcKhKbIeyMH1959rOYi9_9k4eglNCaH36o_.G6vdcdjvwWMZ
 g1Mm3PAlobi8M_PRnKUvz.9b7soam_lBazNSytPNwAHGrHfLLQBam1jF2V7PwI9rt5hQL2MprlTC
 ly_mILJ1rkyPZ4jtIZ8afyC3julxSOhJm7tPvFDGYI6.0zIDpDBeciL0oM5vWwnE6JtxAsQEAfwr
 sQTffb6G9dkOKOtH92D3f9YlrQ2eYwZSIkwtZ_dFZQXH0TXSRQTzWIKdOiMpv8tIrJ4y5yfzt0PD
 G2e98_M0Xv6IxMPbF9qgWM4UsBvLL5hN6JWc5ZLr4m283SozQaBmm3lLb35.VY22FAlfHttZYQbB
 sy7XTNSkK_7ywkLXfuP.NGfFFogGi7ImIdda1HQmxtoklLQ--
X-Sonic-MF: <igor.korotin@yahoo.com>
X-Sonic-ID: 3befdfe6-6df7-4284-8731-6c12b188ce9e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Jun 2025 13:57:26 +0000
Received: by hermes--production-ir2-858bd4ff7b-w59v5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aa6bd7898dce500d2c3ef2418e041585;
          Thu, 05 Jun 2025 13:57:23 +0000 (UTC)
Message-ID: <2d02be52-b22b-4a2b-bfbe-aff7b62200e8@yahoo.com>
Date: Thu, 5 Jun 2025 14:57:21 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] rust: Add ACPI match table support for Rust
 drivers
To: Danilo Krummrich <dakr@kernel.org>,
 Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Len Brown <lenb@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Hung <alex.hung@amd.com>,
 Tamir Duberstein <tamird@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>
References: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
 <aEC73CHD0fvByrJs@cassiopeiae>
Content-Language: en-US
From: Igor Korotin <igor.korotin@yahoo.com>
In-Reply-To: <aEC73CHD0fvByrJs@cassiopeiae>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23956 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


> Thanks this is great!
> 
> Unfortunately, it seems that something went wrong sending this patch series.
> Patches 3 and 5 are missing on my end (and on the corresponding lists as well).

Yes, I know. Gmail has blocked me from sending any letters. I probably hit
some limit. It will likely unblock me sometime today or tomorrow.

> Also, technically this series is a v2; patch 1 differs from the one you sent
> originally -- please include a changelog.

Because of this Gmail issue, I need to clarify the right course of 
action to avoid being blocked again:
Should I resend the whole series as PATCH v2 with a changelog?

Thanks
Igor


