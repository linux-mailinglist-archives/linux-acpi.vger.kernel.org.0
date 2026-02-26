Return-Path: <linux-acpi+bounces-21182-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGa4L9Hwn2kyfAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21182-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 08:05:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3CC1A199E
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 08:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B0993020A56
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 07:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60F538E110;
	Thu, 26 Feb 2026 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cpSVHs9O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eCAYBsR9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699538A71B
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089549; cv=pass; b=hfCmOS8IfVG8p3Dy549NZVZxpzu2IvoA9Si5Jhh32v1qNMdvljGNjkeAhSjv/Pfd5R6cHpnnPoec+cxZJr4gPqfdPp+8f0dH9/TpVy9j9QwP/pz5Q4mjIZhNcUbZ3rGn+8ME/mCCYaZfqS9AVXy9PWfhQj+WjODzER8pBJeWCmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089549; c=relaxed/simple;
	bh=fthQwGFGcr3v5gbtPCMZp9gFbRlGycmeGJ6rhMoXyYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh/VzQyCCBYs9kjWxsS0+psLJOQVjWpqnRk013GT0GXrlshogEdV+XVzJ7bZxxT4rHA2VyDFcw0DeRCc4rt2BPoG9BYr7s3iCX1edpjOGZ52SXnjrqm4xmpFnGt777+ufgH1xEDGYjKkUauH7Z/Pcd3tYaZyERgallx+TwWm8nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cpSVHs9O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eCAYBsR9; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VKr83721822
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 07:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k+P7CghlNIgjxycB/1qldY8eXMaIX8CflGPUmpKbNzU=; b=cpSVHs9ObcHsKfAX
	3ggqKxAEXUPS1VD3qshQZ0rce0/Ew6L8IPvz9t5w4UaBOJI1vzlU6M8/T/FpTp9W
	sgHBIp6RGQQL0oYuASc1K1r5Ifq2e/jT8HbmgIPhNhxF3l9U8llkr/n9Y9Pp/FFG
	l+CaNPpRgdpkwqyKA/bMPHCQsdtWdsxSNZDu61bxcHRjSLfcRbeLzWmkPhvwci4q
	ShFWsBp9qM2MUlI9bAsIpcS2O1HfqpnPp1bDBjsHiaFvk7wdmVxdKCzHc5nrzU/E
	ses5Ly8RZ59i0kL6FFcn+6sRqnM5fTkFxWROQAiNJvBGcgohyjyWMS8yV70glr2m
	/XeO7Q==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyvf396f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 07:05:46 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679862e4413so5632182eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 23:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772089546; cv=none;
        d=google.com; s=arc-20240605;
        b=L3gnBmJNiW8P4DdEKrCXmY9A8SXsyNK9qzaMmkFMZY7CrkyFEi91Yp8mJpcrTIvfE5
         sQ4AT8Tw3Eh/8TBtuLnAs5bcEkTnKd+45BDfW9x8I55sIR/GvtvtvXk+J4OyHgoxHf3O
         HQrujQ1w6j0YhWBAVbo5QB/zd52Njrzu/aYrvMS5w04OZE0UeR7KPOnLdMKAOAuAaZFb
         2hF27n3nwrF2l8UdRClESR1cYOENaPN7KJU8ZuKc6SaohyVru4a7Fsma3icS4GVEmN/O
         VTf3Xi4vN8N2F/CxQlOlE8a/Qz6WrInP5gmbWL3UznvyXEITkUXM1Gtf9oxqtcx6fz2v
         RpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+P7CghlNIgjxycB/1qldY8eXMaIX8CflGPUmpKbNzU=;
        fh=PpYBcKrRD+bCc/xA2WOJRW217qaf8LdS8NzH1r9R3ys=;
        b=NznGu05nXBzcESMxHSocQjFd5/A9fKL4uEwsLxM9vXFmb07PjIJa2jCBREToURILHL
         sEsHH/qmi1+CVS+lmfFJ8Wzmg8xoDJSuI8CD80oZ33WpAgP43JQmExDLKXV4Hd47F8iB
         3X1rwwuMGm1h4NvSvNkgpmTNv0FIVyaonMhAkNq+s+E6DJ2tRHGTNXx7gyJJFncCXQyr
         mxEOVnBX+CzvpQGmJOAIj942EtJLUuDLTKDFtG731bIxFQ17RwJIYRW7+nxvDY6bQVhB
         S/CwpbH32FSBakjk8rqBfZTafXteo9bcgGB8717elNKPtGjKVPfK2BHgAhuq/24bR5mu
         Y/Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089546; x=1772694346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+P7CghlNIgjxycB/1qldY8eXMaIX8CflGPUmpKbNzU=;
        b=eCAYBsR9nsrh8HWI5M6Yi880xAjH3r8+RXU4D4n/Zq9GHf3Cme1WZHljy5NKnWVK9L
         j0Y2jL646uHn67krOpBxnKpWLrnxfljbe2hFANefxKgLjY5RXQ7/+Tsy7cHH/HqOKK/n
         ii9LFcrUFnvFuVDO1uWoeKHdVqqDvFdQJczpJddWoJ3rIp9P4goBhZdVx7OhTvtotlto
         PzmbMT304Tn8K1HSoV8xw7pp6Qilks4IXaO1+T63J6xVJCjPx+E/5eNQDbFS5t0zKBhG
         Iahmip/D/4oRSXaGWZ12FaBKtZQjPoe2Cb1lgTVSULRSQOqCpnu55OY/gVGViw2OhLYC
         Hkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089546; x=1772694346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+P7CghlNIgjxycB/1qldY8eXMaIX8CflGPUmpKbNzU=;
        b=al4+DJvxroVKVXTUo/7NgKYUFXh9sgFNZKO4EDxWPjZOuOajKqpfsLB0FFNVdHpQKo
         lFROoDIHdgSR319coZgFrc1CfcNrVtoQS8jzaQPeRJQhZzrY/rjofHph44v5+qzp3zTN
         DWHGxsGNSjcUMmQhYVPVS7zzH8+ahuWBfITfeJA+soc1TCZ8zzLb1994xjtVRGmR6z5c
         pG7nspOEZPPmku8kpcQ0U87cvR/8+5YAzVafsVg7OmSS78WIWHk7YvGjKmV+EHYKe1Qb
         W9/n5/LjdrLBKQBh0isiDIo3XoxowAqBYSI0WrtsZQ0PAaTw22y1rx0d6wRxYCTKA4Gf
         f4tA==
X-Forwarded-Encrypted: i=1; AJvYcCWcGMlGt8UUwwnTjOwqPSo0EpIDtfI1JKJErhgfiS2L7gARbomwJi//rlnihJQDR0Ft6lfOyRma/v/R@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKuGKxzowSm1FbTnOB41GlBRUMM4jnAr6ll43zeHeXfIQEwyN
	PGD1J2Baw1xuGvZRnVRI3nMG1SNe35HyDcni/al8OT21g28huL7uSTHxk75lRIUy70TrEj8DNJY
	EyIkiRL9vEm3z2qh7pUvLrvpo9Vu4NsYtnaaYFBU0JoMe4hM0sYXgmEdupgeHOMHFu/kAthVV8I
	Jp7CVH+5fwnmVwFmBuVVXNyd1kxdaAEmgM+Z1sEK7/Qp8CpuQ=
X-Gm-Gg: ATEYQzx2wqCjcGT430EY05sgGnv3r2qxjW6P4fo1EHJ80w/eCVrUD/+m4q3aomJ1Cpy
	kBAgEtdt7jP/RHdB6lNhkWoXcEdkziZEgqvAxIikAnlSZpNAeUzdNT+Sz2GZCLRps/svG0+O7ep
	fFTsMU5aTdzUrS19P883xF5e94PJD1xYKfhOKz3V49+j45DZfHqMTua/etdyIDuCOvH7Gx5eovH
	NTmZYw=
X-Received: by 2002:a05:6820:1786:b0:677:4fc0:a852 with SMTP id 006d021491bc7-679f3d28624mr625356eaf.34.1772089546213;
        Wed, 25 Feb 2026 23:05:46 -0800 (PST)
X-Received: by 2002:a05:6820:1786:b0:677:4fc0:a852 with SMTP id
 006d021491bc7-679f3d28624mr625343eaf.34.1772089545831; Wed, 25 Feb 2026
 23:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 12:35:34 +0530
X-Gm-Features: AaiRm51yZ89kZv0f4gE9xa9boBW5MZ_Co37QxpUC5GHdKH2lI624cxTwISy9vz0
Message-ID: <CA+Ht8=a_fw-u2PLEf1GY7qYLT945OaJ0LeW6K+X2SvSWLqsrXA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
        robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: C-8w17pnrlFpe2u2UsxfzKxC5UKAN02b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MiBTYWx0ZWRfXxMhbSAlKMXm1
 1fywHx/CYxT3TSi7sOQC1DBcpPNcJSpn1DkAh4yW7+3yo7xNPaalRRy1gliu+5GgbeCvKDCNnh6
 yJRJvySrK4bcscbgfe6r4JJNbyHtoE7wQhlw9C74GTP55tsFC1d/LVnGQ4ODsUXaPXf3RRh+Af/
 G00ACUfTDVHluGYXWjMqDQFVruYVOfQqvYzJvFJsrdjyVLWBhpRbj7AmEyIg1ZcRWtve8xxy5gS
 2LebaSyBQk38jx8M1UhBHVbVGANKHf5oSjBiEZQvUnlAqaldDa96sV2Mjh02Cq3ofVyH2xZE3rZ
 X8uLRjdlwC0d8PV8d6BmyNNEJJHSrCUGOIVVFwKxygtpFZFfiNqbocOGbzDfSEsMe+CAaVQ2+Cw
 TSH1PHEygDvXWlr7ltQS6DxOxBNcajenrUKn+zFaoehYk1fztnsAfyDlkyzC+5IybQDrEbTrC3z
 bR+3nznFopgCp7v2NOA==
X-Proofpoint-GUID: C-8w17pnrlFpe2u2UsxfzKxC5UKAN02b
X-Authority-Analysis: v=2.4 cv=dZWNHHXe c=1 sm=1 tr=0 ts=699ff0ca cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=2-EGK2xgfFmwblvCShkA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260062
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21182-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[himanshu.chauhan@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,oss.qualcomm.com:dkim,arm.com:email]
X-Rspamd-Queue-Id: 5C3CC1A199E
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 7:14=E2=80=AFPM Ahmed Tiba <ahmed.tiba@arm.com> wro=
te:
>
> This is v2 of the GHES refactor series. The goal is to reuse existing
> GHES CPER handling for non-ACPI platforms without changing the GHES
> flow or naming, and add a DT firmware-first CPER provider, while
> keeping the changes mechanical and reviewable.

It seems almost all the code is being moved from ghes.c to ghes_cper.c
in multiple patches. It is not making sense and looks like an
unnecessary churn.
What is that which can't be handled in a separate file for non-ACPI platfor=
ms?

>
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
> Changes in v2:
> - Dropped the proposed "estatus core" and kept GHES naming/flow intact
>   (per Borislav Petkov).
> - Re-sliced the series into smaller mechanical steps (per Mauro Carvalho =
Chehab).
> - Minor DT binding fixes based on Krzysztof Kozlowski's feedback.
> - Removed fixmap slot usage from the DT FFH driver (per Will Deacon).
>
> Series structure:
> - Patches 1-8 are mechanical moves only and do not change behavior.
> - Patch 9 wires the shared helpers back into GHES.
> - The DT firmware-first CPER buffer provider is added in the final patche=
s.
> - "ACPI: APEI: introduce GHES helper" is internal build glue only
>   and does not introduce a new user-visible configuration option.
>
> - Link to v1: https://lore.kernel.org/r/20251217112845.1814119-1-ahmed.ti=
ba@arm.com
>
> ---
> Ahmed Tiba (11):
>       ACPI: APEI: GHES: share macros via a private header
>       ACPI: APEI: GHES: add ghes_cper.o stub
>       ACPI: APEI: GHES: move CPER read helpers
>       ACPI: APEI: GHES: move GHESv2 ack and alloc helpers
>       ACPI: APEI: GHES: move estatus cache helpers
>       ACPI: APEI: GHES: move vendor record helpers
>       ACPI: APEI: GHES: move CXL CPER helpers
>       ACPI: APEI: introduce GHES helper
>       ACPI: APEI: share GHES CPER helpers
>       dt-bindings: firmware: add arm,ras-ffh
>       RAS: add DeviceTree firmware-first CPER provider
>
>  Documentation/admin-guide/RAS/main.rst             |   18 +
>  .../devicetree/bindings/firmware/arm,ras-ffh.yaml  |   71 ++
>  MAINTAINERS                                        |    6 +
>  drivers/Makefile                                   |    1 +
>  drivers/acpi/Kconfig                               |    4 +
>  drivers/acpi/apei/Kconfig                          |    1 +
>  drivers/acpi/apei/apei-internal.h                  |   10 +-
>  drivers/acpi/apei/ghes.c                           | 1024 +-------------=
-----
>  drivers/acpi/apei/ghes_cper.c                      | 1026 ++++++++++++++=
++++++
>  drivers/ras/Kconfig                                |   12 +
>  drivers/ras/Makefile                               |    1 +
>  drivers/ras/esource-dt.c                           |  264 +++++
>  include/acpi/ghes.h                                |   10 +-
>  include/acpi/ghes_cper.h                           |  143 +++
>  include/cxl/event.h                                |    2 +-
>  15 files changed, 1558 insertions(+), 1035 deletions(-)
> ---
> base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
> change-id: 20260220-topics-ahmtib01-ras_ffh_arm_internal_review-bfddc7fc7=
cab
>
> Best regards,
> --
> Ahmed Tiba <ahmed.tiba@arm.com>
>
>

