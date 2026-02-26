Return-Path: <linux-acpi+bounces-21180-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKLsJQPwn2kyfAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21180-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 08:02:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7CF1A18E7
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 08:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27A40301073C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16E338BF92;
	Thu, 26 Feb 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdta/EM5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hdJ4Qase"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22E27FD5D
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089323; cv=pass; b=pcmwO4LkbkRSQ0kPyD9EOxxjwY9JMbxs5nr90Jzp+a8F8TwVnSaWbjH5/U5aPbHKjPHz3qq0GALucuqCLPWUQ+spYXgb2lFbikC01nHSWeOjm6dHrIGqrlsDZ4OagmcWT7NwMSkSyUkGi2fn4htXZmfkdioJ1gRMwLZKUE1Fpb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089323; c=relaxed/simple;
	bh=kZ4LwUnvC2DyZr1N00c+azhtmALaEsS/mIV7Pkmnonw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkoEPOtLfAph5xD2SwkACDK6L9lwRherNwCuN1subKuF856thzltxZ3edA3U5RrmN3ABi2F7J481CsUcMXOojmY3OKTff+nJBxCX+mjlYjVwish0l3h+zqaDzK6UvkIr3XxzoTI4qf5d+1Ux6yFSWW9ZVFZfbb3kmdxer9fLUMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdta/EM5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hdJ4Qase; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V16d2617845
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 07:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PuwrpYHKTq+yUBpseafFLTw4rFPjcM9QQ+vB3eBHFCU=; b=gdta/EM5CvQGlG0K
	ut6mwjp8R1yuSSizLf5WFvAjSRpdaMukUrXqxJJes+U/SpXDCAE10KgwTLo+9ZiB
	NbLHwEMra7xF65M6dLb/5BO7zvqALTGPK2pakphfiLY9NHn5pcr0cP0+dI3DM8o6
	xACP7BVCih/hWaDHA2Q00eZJT/WzOyYcQ7lEdW4q4WFv42S7lObaOxmSqJP9MMo8
	tncgQtI7VfJg5pCCXTO37YVSdnHm0XEsCgGRTetRuTg7+0hiJyHteVEecZf1KHNU
	o82ZwnM7/3DuktbaVBSpo3qn+tdFL1PUTl0TBYmouZsnmZjSL2pSi5Lj1Bbf6FRX
	28R1ZA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj559j4e6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 07:02:01 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679dda090fbso12839692eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 23:02:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772089321; cv=none;
        d=google.com; s=arc-20240605;
        b=TNEvEPMbC2/PLubRNTmerWCfdzJ/Rd8S7u9xF3k/RTvlnPwtNbMQaG3WGLvpESzTvE
         lQEx8Q/eA2cipsl8wgVYUHcGg0AK4bQzC6aLET8Xy37id3P06ggcEMEt4UyP+wEaNSOL
         AVtpRBKKvP6JcZcyeFfsn9sl2AtvlVjxdkmD4i2Itxqv0nQghinzO2GiPjAeoCexHUhf
         O0xqBPoJuAzuOycQIlHWtUG4HIaS4JmIKajo94aTzg45mN6BySmxf0IeQZ1jV4mM3kIf
         Kc0LV3qMSvdPCF61GnmB8DXfKW11KWlSIbdBveakXoke4suEVoa3Tm0B6tNPGGezZq0K
         FLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PuwrpYHKTq+yUBpseafFLTw4rFPjcM9QQ+vB3eBHFCU=;
        fh=MGnoDa5FNJlSxDcYJFNqXDafiLz0f/7rgk9z/PobjoM=;
        b=G88wEx5kF2swX+Cy8+a0Y21w4/R9wOnn2nBfSCoWbqJdKIexqcF29PbpxHP4CJahno
         nPd1r9QjhnFKHPo6TYAJZBsF93Za2dtKzL4aHtX/hCSkfUoPRhcqZgn2nJ8DjtXjBV9P
         C/5yaWeQxh4JcU/7KYNi5PltMis6S88o1oWiNBdRJGNRs10YeG1+2vdPenpr0bxynXik
         mpe4/BVPyXT6hiyzZ4sT46Uo7w+lTNBcgFqDtSLPFr/4Sft2yJxzMZkAlTFH0jdWrdD8
         qJpD/3VlspRZQyFnqLARS3hBMtd0kq7xtFsK6IHgKg0O3TbUwUt+TQv90+Ztzb4tamO7
         C+aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089321; x=1772694121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuwrpYHKTq+yUBpseafFLTw4rFPjcM9QQ+vB3eBHFCU=;
        b=hdJ4QaseSs0hEvP6le38BQfgTa6wF/fSFKjLGsMNYYRQCk8TaU8V7jAHZwtiNCYSwQ
         i1jl91wPKb820OZ0ttSEVPs8axue4EDsv00fiDZJRKDsh71/PUZygxhhD7xYVVUcvlLP
         95OQe9kIYmy8EymW6IjURSOqvxfqPHggybJX6CJ9G0qDxsYZhaeB2DzAuNS6m2NTphuX
         3XZ+/mUlT35R8cs6D3BqdB9528tq4rmjmQR7NHcg52CXQ6z9rBOUWfrjGwNZNOVskuHq
         A9+JkGU93gO19jt4lF7cWHSPhZ8zwQbSLy/601ad2P2cgxTFzBrnwvq9vcfkE4MpRGFi
         moEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089321; x=1772694121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuwrpYHKTq+yUBpseafFLTw4rFPjcM9QQ+vB3eBHFCU=;
        b=v53Qh+lSvxe4btADq+oS/Y6VhL0JBRBcUxMzYhDqqPbYL1ow6mXmUSp36o0dOGeS8H
         d39VpWjP6wLiXG+P77SUdNXifXUSfdE2vLeVfUYVTkNz5AfyG8rbWHURcyFcQtf72bLV
         HPIc76O+UEg6kgg5X9QA8AKKKPk9MCfSyNVjfUe0lVY0zXApkz3kKeTxxXnq0qwPjwqd
         MF383b70/XHQSLRPwEQdJ/42Q0yv8ter+1Y0PfQXbe1zX0/BiDz5QCzRdqHHz11XMkep
         obhJV29iWXDWQTd7PQ6Ht++E3VYeE3tJwVhHt4VmpMEIcZ8DU+MGZkwUGNuCkfU0CRKe
         mvqg==
X-Forwarded-Encrypted: i=1; AJvYcCXIr7inuqcHhnad/Ce8PGz3Ur7L73NT8h0lmc+/EdMEB7ZEnKFzojCRGRftVvKRSwSH0dQzvLk+I+fs@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtzvimDC1ArR6mnfe1tZO/n8NwStenlu4J8GgcdzrFIHMN6V+
	bVYPz6JHVr0ITyQ1DVygmp7Z/OItQWce6nOuOJyaJktjirNmUhpGvfjCGAJekN4pWbhC5iKmkGx
	7Knuuw5LWWWL+pjO5aGxUAdj4AHY6E0aZ06nNKO6RNg35U4PNOQfnEWIWgIzsOc1gEN7SjrWhQy
	rDMw8NFftAc2ySApohh9vCJ7nC+FiU4nGyk88uLxM=
X-Gm-Gg: ATEYQzw47LlVN0pwdotWsPoutyactBnYnHjG0cePHHLeUIYBN9uyRVfx/xnEvMIXRBW
	NoOsHv3hX8/NhGVnHz0MJadCmQ6IIyYmpR5S5XRhjofS/MXZMp46hyvKY97B4kvkvHUk59Dvneo
	R4xT9KFVgQsTVn31baRGFzD3z+QM5wInA0LBGZusz6BEBfdpTAfEtK1qBRUT42wRvto5JSLhnp1
	vSgu5k=
X-Received: by 2002:a05:6820:1620:b0:662:ff03:c213 with SMTP id 006d021491bc7-679ef989c63mr1389681eaf.61.1772089320658;
        Wed, 25 Feb 2026 23:02:00 -0800 (PST)
X-Received: by 2002:a05:6820:1620:b0:662:ff03:c213 with SMTP id
 006d021491bc7-679ef989c63mr1389647eaf.61.1772089319185; Wed, 25 Feb 2026
 23:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-11-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-11-347fa2d7351b@arm.com>
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 12:31:46 +0530
X-Gm-Features: AaiRm50IC1HsOl6QMRXAOVKf4_ryi0l229YCdeA9iFVtyFNBsgVnkGuVYYlysYg
Message-ID: <CA+Ht8=bj_5UDYmHrdp5s+1e3amO7ErPm-K28Wog2y3+j4PtjNw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] RAS: add DeviceTree firmware-first CPER provider
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
        robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: z6Ee3T_YAb_ydr_TaG8M7T6ZcEDhoFRy
X-Proofpoint-GUID: z6Ee3T_YAb_ydr_TaG8M7T6ZcEDhoFRy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfX1WDfgzpcI+sl
 ggG5zbq8ikT9Kx/EZ5MA0TvHH6qxF5QyPXj8RIE5fxMBUr0M3gru4jakS+qoxJFFe/ENKtKlpIx
 8CayMG8F2O+BK/ViXfXLVdSPeRbYxkOS+MWF8u2DloqLNu2D+NIkZwdrJwSsFWq6qeeVA/ZyoqO
 ssMN9gbXyXaCPNKddkCOI5PGb5JVYPlt5rSPZ262XZnH7w3O5IobgH9xkku+lg0aMZhtoCzkuix
 O7sWDF2ptXdy2RqTXV1cYuUBDuuzL6Jriq2w+D3eZrZ41VskYABfZT9WGFyTZv8kbvJX93kdgSl
 fq+SFNEpXXAeMLDEOpFOTe8KPSSlidnOVacCGMh/5Hy5RU/E8/15eqx9Qtck5cKIr2hypknx6PJ
 wmOTA+aDefF8tWr6w1rjG+mdmWc1q72roU5UyovzaSiU1LTftF7dKtaX74T+dkMSHEsZn6v9Uz9
 ycF0RSPJRpJ2N50NUNg==
X-Authority-Analysis: v=2.4 cv=TcybdBQh c=1 sm=1 tr=0 ts=699fefe9 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8
 a=0_E0fn6IqdgZwImqbKcA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21180-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,intel.com:email,oss.qualcomm.com:dkim,arm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BD7CF1A18E7
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 7:13=E2=80=AFPM Ahmed Tiba <ahmed.tiba@arm.com> wro=
te:
>
> Add a DeviceTree firmware-first CPER provider that reuses the shared
> GHES helpers, wire it into the RAS Kconfig/Makefile and document it in
> the admin guide. Update MAINTAINERS now that the driver exists.
>
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  Documentation/admin-guide/RAS/main.rst |  18 +++
>  MAINTAINERS                            |   1 +
>  drivers/acpi/apei/apei-internal.h      |  10 +-
>  drivers/acpi/apei/ghes_cper.c          |   2 +
>  drivers/ras/Kconfig                    |  12 ++
>  drivers/ras/Makefile                   |   1 +
>  drivers/ras/esource-dt.c               | 264 +++++++++++++++++++++++++++=
++++++
>  include/acpi/ghes_cper.h               |   9 ++
>  8 files changed, 308 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/RAS/main.rst b/Documentation/admin=
-guide/RAS/main.rst
> index 5a45db32c49b..4ffabaaeabb1 100644
> --- a/Documentation/admin-guide/RAS/main.rst
> +++ b/Documentation/admin-guide/RAS/main.rst
> @@ -205,6 +205,24 @@ Architecture (MCA)\ [#f3]_.
>  .. [#f3] For more details about the Machine Check Architecture (MCA),
>    please read Documentation/arch/x86/x86_64/machinecheck.rst at the Kern=
el tree.
>
> +Firmware-first CPER via DeviceTree
> +----------------------------------
> +
> +Some systems expose Common Platform Error Record (CPER) data
> +via DeviceTree instead of ACPI HEST tables.
> +Enable ``CONFIG_RAS_ESOURCE_DT`` to build the ``drivers/ras/esource-dt.c=
``
> +driver and describe the CPER error source buffer with the
> +``Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml`` binding.
> +The driver reuses the GHES CPER helper object in
> +``drivers/acpi/apei/ghes_cper.c`` so the logging, notifier chains, and
> +memory failure handling match the ACPI GHES behaviour even when
> +ACPI is disabled.
> +
> +Once a platform describes a firmware-first provider, both ACPI GHES and =
the
> +DeviceTree driver reuse the same code paths. This keeps the behaviour
> +consistent regardless of whether the error source is described via ACPI
> +tables or DeviceTree.
> +
>  EDAC - Error Detection And Correction
>  *************************************
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47db7877b485..fa6113b482b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22031,6 +22031,7 @@ RAS ERROR STATUS
>  M:     Ahmed Tiba <ahmed.tiba@arm.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml
> +F:     drivers/ras/esource-dt.c
>
>  RAS INFRASTRUCTURE
>  M:     Tony Luck <tony.luck@intel.com>
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-i=
nternal.h
> index 77c10a7a7a9f..c16ac541f15b 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -8,6 +8,7 @@
>  #define APEI_INTERNAL_H
>
>  #include <linux/acpi.h>
> +#include <acpi/ghes_cper.h>
>
>  struct apei_exec_context;
>
> @@ -120,15 +121,6 @@ int apei_exec_collect_resources(struct apei_exec_con=
text *ctx,
>  struct dentry;
>  struct dentry *apei_get_debugfs_dir(void);
>
> -static inline u32 cper_estatus_len(struct acpi_hest_generic_status *esta=
tus)
> -{
> -       if (estatus->raw_data_length)
> -               return estatus->raw_data_offset + \
> -                       estatus->raw_data_length;
> -       else
> -               return sizeof(*estatus) + estatus->data_length;
> -}
> -
>  int apei_osc_setup(void);
>
>  int einj_get_available_error_type(u32 *type, int einj_action);
> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.=
c
> index 29b790160e91..9b2d1b8cf9f4 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -42,7 +42,9 @@
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
>
> +#ifdef CONFIG_ACPI_APEI
>  #include "apei-internal.h"
> +#endif
>
>  ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
>
> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> index fc4f4bb94a4c..ea6d96713020 100644
> --- a/drivers/ras/Kconfig
> +++ b/drivers/ras/Kconfig
> @@ -34,6 +34,18 @@ if RAS
>  source "arch/x86/ras/Kconfig"
>  source "drivers/ras/amd/atl/Kconfig"
>
> +config RAS_ESOURCE_DT
> +       bool "DeviceTree firmware-first CPER error source block provider"
> +       depends on OF
> +       depends on ARM64
> +       select GHES_CPER_HELPERS
> +       help
> +         Enable support for firmware-first Common Platform Error Record =
(CPER)
> +         error source block providers that are described via DeviceTree
> +         instead of ACPI HEST tables. The driver reuses the existing GHE=
S
> +         CPER helpers so the error processing matches the ACPI code path=
s,
> +         but it can be built even when ACPI is disabled.
> +
>  config RAS_FMPM
>         tristate "FRU Memory Poison Manager"
>         default m
> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
> index 11f95d59d397..53558a1707b3 100644
> --- a/drivers/ras/Makefile
> +++ b/drivers/ras/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_RAS)      +=3D ras.o
>  obj-$(CONFIG_DEBUG_FS) +=3D debugfs.o
>  obj-$(CONFIG_RAS_CEC)  +=3D cec.o
> +obj-$(CONFIG_RAS_ESOURCE_DT)   +=3D esource-dt.o
>
>  obj-$(CONFIG_RAS_FMPM) +=3D amd/fmpm.o
>  obj-y                  +=3D amd/atl/
> diff --git a/drivers/ras/esource-dt.c b/drivers/ras/esource-dt.c
> new file mode 100644
> index 000000000000..b575a2258536
> --- /dev/null
> +++ b/drivers/ras/esource-dt.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * DeviceTree provider for firmware-first CPER error source block.
> + *
> + * This driver shares the GHES CPER helpers so we keep the reporting and
> + * notifier behaviour identical to ACPI GHES
> + *
> + * Copyright (C) 2025 ARM Ltd.
> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/panic.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include <acpi/ghes.h>
> +#include <acpi/ghes_cper.h>
> +
> +static atomic_t ghes_ffh_source_ids =3D ATOMIC_INIT(0);
> +
> +struct ghes_ffh_ack {
> +       void __iomem *addr;
> +       u64 preserve;
> +       u64 set;
> +       u8 width;
> +       bool present;
> +};

Please don't use ffh. FFH stands for Fixed Feature Hardware. This is
making it confusing. As per ACPI specification, FFH can be used to
register read/write while handling errors.
I have started feeling that all this churn should be avoided. All the
GHES code is also being moved in the name of CPER helpers.

> +
> +struct ghes_ffh {
> +       struct device *dev;
> +       void __iomem *status;
> +       size_t status_len;
> +
> +       struct ghes_ffh_ack ack;
> +
> +       struct acpi_hest_generic *generic;
> +       struct acpi_hest_generic_status *estatus;
> +
> +       bool sync;
> +       int irq;
> +
> +       /* Serializes access to the firmware-owned buffer. */
> +       spinlock_t lock;
> +};
> +
> +static int ghes_ffh_init_pool(void)
> +{
> +       if (ghes_estatus_pool)
> +               return 0;
> +
> +       return ghes_estatus_pool_init(1);
> +}
> +
> +static int ghes_ffh_copy_status(struct ghes_ffh *ctx)
> +{
> +       memcpy_fromio(ctx->estatus, ctx->status, ctx->status_len);
> +       return 0;
> +}
> +
> +static void ghes_ffh_ack(struct ghes_ffh *ctx)
> +{
> +       u64 val;
> +
> +       if (!ctx->ack.present)
> +               return;
> +
> +       if (ctx->ack.width =3D=3D 64) {
> +               val =3D readq(ctx->ack.addr);
> +               val &=3D ctx->ack.preserve;
> +               val |=3D ctx->ack.set;
> +               writeq(val, ctx->ack.addr);
> +       } else {
> +               val =3D readl(ctx->ack.addr);
> +               val &=3D (u32)ctx->ack.preserve;
> +               val |=3D (u32)ctx->ack.set;
> +               writel(val, ctx->ack.addr);
> +       }
> +}
> +
> +static void ghes_ffh_fatal(struct ghes_ffh *ctx)
> +{
> +       __ghes_print_estatus(KERN_EMERG, ctx->generic, ctx->estatus);
> +       add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> +       panic("GHES: fatal firmware-first CPER record from %s\n",
> +             dev_name(ctx->dev));
> +}
> +
> +static void ghes_ffh_process(struct ghes_ffh *ctx)
> +{
> +       unsigned long flags;
> +       int sev;
> +
> +       spin_lock_irqsave(&ctx->lock, flags);
> +
> +       if (ghes_ffh_copy_status(ctx))
> +               goto out;
> +
> +       sev =3D ghes_severity(ctx->estatus->error_severity);
> +       if (sev >=3D GHES_SEV_PANIC)
> +               ghes_ffh_fatal(ctx);
> +
> +       if (!ghes_estatus_cached(ctx->estatus)) {
> +               if (ghes_print_estatus(NULL, ctx->generic, ctx->estatus))
> +                       ghes_estatus_cache_add(ctx->generic, ctx->estatus=
);
> +       }
> +
> +       ghes_cper_handle_status(ctx->dev, ctx->generic, ctx->estatus, ctx=
->sync);
> +
> +       ghes_ffh_ack(ctx);
> +
> +out:
> +       spin_unlock_irqrestore(&ctx->lock, flags);
> +}
> +
> +static irqreturn_t ghes_ffh_irq(int irq, void *data)
> +{
> +       struct ghes_ffh *ctx =3D data;
> +
> +       ghes_ffh_process(ctx);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int ghes_ffh_init_ack(struct platform_device *pdev,
> +                            struct ghes_ffh *ctx)
> +{
> +       struct resource *res;
> +       size_t size;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (!res)
> +               return 0;
> +
> +       ctx->ack.addr =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(ctx->ack.addr))
> +               return PTR_ERR(ctx->ack.addr);
> +
> +       size =3D resource_size(res);
> +       switch (size) {
> +       case 4:
> +               ctx->ack.width =3D 32;
> +               ctx->ack.preserve =3D ~0U;
> +               break;
> +       case 8:
> +               ctx->ack.width =3D 64;
> +               ctx->ack.preserve =3D ~0ULL;
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unsupported ack resource size %zu\n"=
, size);
> +               return -EINVAL;
> +       }
> +
> +       ctx->ack.set =3D BIT_ULL(0);
> +       ctx->ack.present =3D true;
> +       return 0;
> +}
> +
> +static int ghes_ffh_probe(struct platform_device *pdev)
> +{
> +       struct ghes_ffh *ctx;
> +       struct resource *res;
> +       int rc;
> +
> +       ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&ctx->lock);
> +       ctx->dev =3D &pdev->dev;
> +       ctx->sync =3D of_property_read_bool(pdev->dev.of_node, "arm,sea-n=
otify");
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(&pdev->dev, "status region missing\n");
> +               return -EINVAL;
> +       }
> +
> +       ctx->status_len =3D resource_size(res);
> +       if (!ctx->status_len) {
> +               dev_err(&pdev->dev, "Status region has zero length\n");
> +               return -EINVAL;
> +       }
> +
> +       ctx->status =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(ctx->status))
> +               return PTR_ERR(ctx->status);
> +
> +       rc =3D ghes_ffh_init_ack(pdev, ctx);
> +       if (rc)
> +               return rc;
> +
> +       rc =3D ghes_ffh_init_pool();
> +       if (rc)
> +               return rc;
> +
> +       ctx->estatus =3D devm_kzalloc(&pdev->dev, ctx->status_len, GFP_KE=
RNEL);
> +       if (!ctx->estatus)
> +               return -ENOMEM;
> +
> +       ctx->generic =3D devm_kzalloc(&pdev->dev, sizeof(*ctx->generic), =
GFP_KERNEL);
> +       if (!ctx->generic)
> +               return -ENOMEM;
> +
> +       ctx->generic->header.type =3D ACPI_HEST_TYPE_GENERIC_ERROR;
> +       ctx->generic->header.source_id =3D
> +               atomic_inc_return(&ghes_ffh_source_ids);
> +       ctx->generic->notify.type =3D ctx->sync ?
> +               ACPI_HEST_NOTIFY_SEA : ACPI_HEST_NOTIFY_EXTERNAL;
> +       ctx->generic->error_block_length =3D ctx->status_len;
> +
> +       ctx->irq =3D platform_get_irq_optional(pdev, 0);
> +       if (ctx->irq <=3D 0) {
> +               if (ctx->irq =3D=3D -EPROBE_DEFER)
> +                       return ctx->irq;
> +               dev_err(&pdev->dev, "interrupt is required (%d)\n", ctx->=
irq);
> +               return -EINVAL;
> +       }
> +
> +       rc =3D devm_request_threaded_irq(&pdev->dev, ctx->irq,
> +                                      NULL, ghes_ffh_irq,
> +                                      IRQF_ONESHOT,
> +                                      dev_name(&pdev->dev), ctx);
> +       if (rc)
> +               return rc;
> +
> +       platform_set_drvdata(pdev, ctx);
> +       dev_info(&pdev->dev, "Firmware-first CPER status provider (interr=
upt)\n");
> +       return 0;
> +}
> +
> +static void ghes_ffh_remove(struct platform_device *pdev)
> +{
> +}
> +
> +static const struct of_device_id ghes_ffh_of_match[] =3D {
> +       { .compatible =3D "arm,ras-ffh" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ghes_ffh_of_match);
> +
> +static struct platform_driver ghes_ffh_driver =3D {
> +       .driver =3D {
> +               .name =3D "esource-dt",
> +               .of_match_table =3D ghes_ffh_of_match,
> +       },
> +       .probe =3D ghes_ffh_probe,
> +       .remove =3D ghes_ffh_remove,
> +};
> +
> +module_platform_driver(ghes_ffh_driver);
> +
> +MODULE_AUTHOR("Ahmed Tiba <ahmed.tiba@arm.com>");
> +MODULE_DESCRIPTION("Firmware-first CPER provider for DeviceTree platform=
s");
> +MODULE_LICENSE("GPL");
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index f7c9fba62585..d43185c020ee 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
> @@ -75,6 +75,15 @@ static inline bool is_hest_sync_notify(struct ghes *gh=
es)
>         return notify_type =3D=3D ACPI_HEST_NOTIFY_SEA;
>  }
>
> +static inline u32 cper_estatus_len(struct acpi_hest_generic_status *esta=
tus)
> +{
> +       if (estatus->raw_data_length)
> +               return estatus->raw_data_offset + \
> +                       estatus->raw_data_length;
> +       else
> +               return sizeof(*estatus) + estatus->data_length;
> +}
> +
>  struct ghes_vendor_record_entry {
>         struct work_struct work;
>         int error_severity;
>
> --
> 2.43.0
>
>

