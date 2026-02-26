Return-Path: <linux-acpi+bounces-21177-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KwiFQDhn2lLegQAu9opvQ
	(envelope-from <linux-acpi+bounces-21177-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 06:58:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C45DE1A12AC
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 06:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F43130576B3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 05:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99B38A733;
	Thu, 26 Feb 2026 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3WKY9oH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQy1eava"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0638A703
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772085501; cv=pass; b=VpJB3M1hglxslSHdWkT4hu4n4SCkpy+g/JjSqIll++lU1hLWv1W1NUUgG3zDjBcukPmLyA9gRgU5MM7nn04gHUkZB05ogEsUoj4wkGWojP+KClxx+79x2VS7a2FxJXtHs392dN+23i8G+OWY696ZSddsfEGUVnG1ci9F7hem8v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772085501; c=relaxed/simple;
	bh=+uiRQvIVKV/GlsSk9BknRY59jG7QBiEf2fcYYxWccMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW82neOWSb/9h1dVp4x2a8bnlfbdy8jto6l+3oqCaQymoC3cfQN3Wgk6hHOt1fqNxfBsc6TZW+SktWkb3pEtFoW2U2rqs99tXHB5g6Wx3TN6DvLgLhiGaYTYy9pur75NWUDrhdq9SEdVUcYJPgu0QBnRpBkhu7/Dz1Wj3+mdzj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3WKY9oH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQy1eava; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4Vmun1280923
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 05:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06WGVto43FxvVGdmnMyUzlNLnDWIe1ZIbLMXTt3zPbw=; b=o3WKY9oHfg4/cMhI
	gs1+YiPTIqvHlAMO37lS2mfF30HjGxgXsuO77MhchZOFQa+Hxb/d+5ktqn6st+3K
	eGg9/5xd1vo2BkgQCFxeGg7skSZ0x+cZ4iRWu6YjvXJWfhdGS583npPHtVVKdE2g
	neSXgiCS2O08/S35T1587vNbUSMIf1bfsY/pahSfFhmKEBs3CKkEthXJbj3EToTJ
	GTSiUQIURZc4yWAo8ii4059uLYw8ecN7Jaxy9Ubg4Z4jnXOeNp9/loMo73rLRoEy
	bfH9jwDWu3YN3TcaB/NPqXnaiEGisrUXY1bYc+WjuRdZMCuwdFmTGy74lTkMGhxN
	PeOw9Q==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chx39kea7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 05:58:19 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4cf783c73so2967080a34.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 21:58:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772085498; cv=none;
        d=google.com; s=arc-20240605;
        b=bgUnvE5ZxJ1IAnPVzAW4eD/0fnfzEz7ltWW0D+gAFsKEm8+MLf0MERuh4Fwofh2bDJ
         UC/iEbSwgcfgWGJALxsiZLzTGCKHPql6Gvavg8c19Uya/FR/xEvbNdjvlGctNWjeK7yN
         LNkyD32DGrbfU70HoOH6wUSaKgdpi+v3pQzavUq2T/t76qcWrFVrSix2NSjMZ6uHeMKY
         xYk1CUUCkFfv+YI5JeOgPvqMyXzVmmsxKCNoTbz/dqHNh4mB8hDj36JMydzCI4adxelX
         w1IPAFMwadsfQr++2HDcsS9KZFh2d2bF/hcgX4dHWAaY1rtqwgejVYBwy6wcEmBF0EjA
         odCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=06WGVto43FxvVGdmnMyUzlNLnDWIe1ZIbLMXTt3zPbw=;
        fh=2JkAt/ApYjbA742fFdZMG1r38O6+jiZ8HCS6zrLOU+s=;
        b=Mmi2UejCxsmkJC6S6Gu0uI8uu6wY/oywhuXvjS9+yDSm75S05iR7oIeGXaAv8B1TJU
         0U6WTIjSSIkuwqxFPnPbbLAnKm+zsWdC6TS3119zsntdGfMh/pVhykAKvKrmhyDl45Tc
         xshnkOndS6bEwB3A8CAKOXyh9392KUW4W29I7gdey1U9s8aN5fSTeARNUZIy+eqpzLS3
         7hQbdzQWpYzMXcF76DcH5KUfPu4a2gxLyyNGNpbe35unrz1Ze7VLHZZSyIn0KKolXk8P
         KYO2wR/r6i4XEE3rTdkzDwHtXHbkn/ZBpwiK4BEyCETgYwpdJEIAo0s5NeYmBj9gKC2P
         Nu0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772085498; x=1772690298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06WGVto43FxvVGdmnMyUzlNLnDWIe1ZIbLMXTt3zPbw=;
        b=CQy1eava0bzWU4vZMHeMdPD6Wumwajc0uglktfTozhX0kVPWJ0J48w8sAaDY7EAMuy
         cyXdfgHGV4aGlehg3VULid7gFqHW8bBqAoYCqeizjzK+p2aij9tM/yrzU+qEopfIN0am
         q/3y+DLvLq19sSeZfj55vw6hWnQzD1z+ZY25P1U92YQWrrck7YzN0+uE9bf2krSMS2rO
         C2qB/iO9NspZ5Ead778aZOwEkDhjPHo9L3WZYTtLgPDVrjr8f7mbZrGioiNGhrwNnlSO
         W7GmWzo23v4oqIgNWsejMotHvKQy2+4N7U/xxM3OxL0oxAaOiCSh5eWDnSgIWKdeGxMP
         kDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772085498; x=1772690298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06WGVto43FxvVGdmnMyUzlNLnDWIe1ZIbLMXTt3zPbw=;
        b=dR7PTMs+KIbjdkYdEUkFNWZ20HXAFdsio8+Xhvqg6MrGebPVkIDy9ePgaHsKZ8igVc
         EL3k0QPAUqwL7cob8JrJynWOFTnzmwNq0Ua2nujmbUzyqy9h9jAvzj2Vfks9DrCwzyFW
         b0BzNLTtK3yx4zmnoQXIRmAOVmmS2xdSld+ZGf0ADsRNb83+vvM527VDMXfAiYUiie68
         nroaoa7YJDN2wX9Lu8RwOlnXW0JDhQg3Vt3bW43jKce7ga5yS5c9fwrJo28ouYTznjl5
         sfd6j9RE8ap4VjmS87PAl/iebGXEMvm78i/DwHbvf5zzD8TAJsen/3js6YCfnS0dtLCX
         UHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUauSQK1shOaCdslPQZa0abUVwLE7NdHzJrMtXzSjF+JAxUyPzYIuJJ9ckD45foX8Ig4VKeSloRdBdq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+F6AzgF/e4fhIXAnur9n+RrmkZCebTGkLZJI7fgBhsaFDlGMB
	hK0xyiY6RLtJCpU1yZaOd5yN1OpSH1OkaNQpIiTzGMz+lmc0Y7qXcY7DsIy1xOy08TCfZejn1Gs
	qLjePhuyQZMDC3PMrw4FIfk2byAaowWJv79lCGUUjZWQkyraEdgZbXp/hwLsAtfRF4kGVeAJWAR
	rP5jXgCR2vWnw7oO40E0EVCIA+mYgKwk+OAYUCRu0=
X-Gm-Gg: ATEYQzy+uqacTfETp+bhpdHwRL4/24Z+ZbuShZiEtq44bwFthN/LMpgpz7AvW/Fe/Co
	5pBFihbI+e6WEnE+l76aSlCqisbDmIBnlWHV8WJxQrXvOV1A8Rl85osMcOeLAHhaDmXPaqNJ+kd
	MgK7nFyys1afP+P6+pQhWNX2SLME+uv488ACb/aBgyzzmujB6VChwB+p3eOk1co+NmgLcDyLLmB
	Vx8Llk=
X-Received: by 2002:a05:6820:1990:b0:676:6c3c:a1e9 with SMTP id 006d021491bc7-679f3da6aecmr436095eaf.57.1772085498458;
        Wed, 25 Feb 2026 21:58:18 -0800 (PST)
X-Received: by 2002:a05:6820:1990:b0:676:6c3c:a1e9 with SMTP id
 006d021491bc7-679f3da6aecmr436077eaf.57.1772085497991; Wed, 25 Feb 2026
 21:58:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-3-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-3-347fa2d7351b@arm.com>
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 11:28:06 +0530
X-Gm-Features: AaiRm50j2ioKzT8O5WkXwOBzaz_quUV9p2zoAkjwudfimibESDbgnebOCS_fs4k
Message-ID: <CA+Ht8=aL8wp0nwH3vnnm8FnRmfp1nUasfXh3HjeWwi8UadBLOg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] ACPI: APEI: GHES: move CPER read helpers
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
        robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA1MCBTYWx0ZWRfX8EsAKrH9Zmas
 O7rLsxWsljmTvS0CNtwJm6+Oe+9DsDWG9Scj7dXAr4LfaKUxMBSgqkWzU1no0wbwjOdksP4sfsq
 cwSyDuxe9owJe0UikbhCvH5ddiDaUBJlz/wGP/yS3VRGWqtylp6PjXJHY05qUPO1YbuqTV5T9pT
 K3NonSfxHcSvJV+j+g/uA2wI95iP6SXug1RCa3g7EMb/mznkJn6voI/jd5docTup972dyHq1pKx
 50AbwcVLHwT+3ihr/0s+LF2lAxaj6v91iRGhBuxJgw5QL35JNEqM3vV8Rm1FiLZ0Jm2nFP8QVIm
 t8i3IxLRNekp5snTEEOkoFN3tmKpZt9btvQy6gGucvovoiHdA+iOU2nzwnDlDKGCdXK5YO7NzVq
 B3XtJEfwCYplm6t6dN/57W1WtfEB4+g4XV+wrn75qvEDCD8Qs5AJ1Km1rAT44QwyFauHNvh20+K
 9tJLxo2AS+SFDUYw0LQ==
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=699fe0fb cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=7CQSdrXTAAAA:8 a=MJR9BmDR2wurswiG5j0A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 10mE_M0AOfSJMhv-areOAt-MHWyFRZcN
X-Proofpoint-ORIG-GUID: 10mE_M0AOfSJMhv-areOAt-MHWyFRZcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260050
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21177-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:dkim,oss.qualcomm.com:dkim]
X-Rspamd-Queue-Id: C45DE1A12AC
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 7:13=E2=80=AFPM Ahmed Tiba <ahmed.tiba@arm.com> wro=
te:
>
> Relocate the CPER buffer mapping, peek, and clear helpers from ghes.c int=
o
> ghes_cper.c so they can be shared with other firmware-first providers.
> This commit only shuffles code; behavior stays the same.
>
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  drivers/acpi/apei/ghes.c      | 170 +-----------------------------------=
------
>  drivers/acpi/apei/ghes_cper.c | 170 ++++++++++++++++++++++++++++++++++++=
+++++-
>  include/acpi/ghes_cper.h      |  14 ++--
>  3 files changed, 177 insertions(+), 177 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 07b70bcb8342..b159dbee90ac 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -118,26 +118,6 @@ static struct gen_pool *ghes_estatus_pool;
>  static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS=
_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
>
> -static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
> -{
> -       phys_addr_t paddr;
> -       pgprot_t prot;
> -
> -       paddr =3D PFN_PHYS(pfn);
> -       prot =3D arch_apei_get_mem_attribute(paddr);
> -       __set_fixmap(fixmap_idx, paddr, prot);
> -
> -       return (void __iomem *) __fix_to_virt(fixmap_idx);
> -}
> -
> -static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_=
idx)
> -{
> -       int _idx =3D virt_to_fix((unsigned long)vaddr);
> -
> -       WARN_ON_ONCE(fixmap_idx !=3D _idx);
> -       clear_fixmap(fixmap_idx);
> -}
> -
>  int ghes_estatus_pool_init(unsigned int num_ghes)
>  {
>         unsigned long addr, len;
> @@ -193,22 +173,7 @@ static void unmap_gen_v2(struct ghes *ghes)
>         apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
>  }
>
> -static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
> -{
> -       int rc;
> -       u64 val =3D 0;
> -
> -       rc =3D apei_read(&val, &gv2->read_ack_register);
> -       if (rc)
> -               return;
> -
> -       val &=3D gv2->read_ack_preserve << gv2->read_ack_register.bit_off=
set;
> -       val |=3D gv2->read_ack_write    << gv2->read_ack_register.bit_off=
set;
> -
> -       apei_write(val, &gv2->read_ack_register);
> -}
> -
> -static struct ghes *ghes_new(struct acpi_hest_generic *generic)
> +struct ghes *ghes_new(struct acpi_hest_generic *generic)
>  {
>         struct ghes *ghes;
>         unsigned int error_block_length;
> @@ -255,7 +220,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic=
 *generic)
>         return ERR_PTR(rc);
>  }
>
> -static void ghes_fini(struct ghes *ghes)
> +void ghes_fini(struct ghes *ghes)
>  {
>         kfree(ghes->estatus);
>         apei_unmap_generic_address(&ghes->generic->error_status_address);
> @@ -280,137 +245,6 @@ static inline int ghes_severity(int severity)
>         }
>  }

Can it be "ghes_finish"? We already have "creat" without 'e'.

>
> -static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
> -                                 int from_phys,
> -                                 enum fixed_addresses fixmap_idx)
> -{
> -       void __iomem *vaddr;
> -       u64 offset;
> -       u32 trunk;
> -
> -       while (len > 0) {
> -               offset =3D paddr - (paddr & PAGE_MASK);
> -               vaddr =3D ghes_map(PHYS_PFN(paddr), fixmap_idx);
> -               trunk =3D PAGE_SIZE - offset;
> -               trunk =3D min(trunk, len);
> -               if (from_phys)
> -                       memcpy_fromio(buffer, vaddr + offset, trunk);
> -               else
> -                       memcpy_toio(vaddr + offset, buffer, trunk);
> -               len -=3D trunk;
> -               paddr +=3D trunk;
> -               buffer +=3D trunk;
> -               ghes_unmap(vaddr, fixmap_idx);
> -       }
> -}
> -
> -/* Check the top-level record header has an appropriate size. */
> -static int __ghes_check_estatus(struct ghes *ghes,
> -                               struct acpi_hest_generic_status *estatus)
> -{
> -       u32 len =3D cper_estatus_len(estatus);
> -       u32 max_len =3D min(ghes->generic->error_block_length,
> -                         ghes->estatus_length);
> -
> -       if (len < sizeof(*estatus)) {
> -               pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error sta=
tus block!\n");
> -               return -EIO;
> -       }
> -
> -       if (!len || len > max_len) {
> -               pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error statu=
s block length!\n");
> -               return -EIO;
> -       }
> -
> -       if (cper_estatus_check_header(estatus)) {
> -               pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header=
!\n");
> -               return -EIO;
> -       }
> -
> -       return 0;
> -}
> -
> -/* Read the CPER block, returning its address, and header in estatus. */
> -static int __ghes_peek_estatus(struct ghes *ghes,
> -                              struct acpi_hest_generic_status *estatus,
> -                              u64 *buf_paddr, enum fixed_addresses fixma=
p_idx)
> -{
> -       struct acpi_hest_generic *g =3D ghes->generic;
> -       int rc;
> -
> -       rc =3D apei_read(buf_paddr, &g->error_status_address);
> -       if (rc) {
> -               *buf_paddr =3D 0;
> -               pr_warn_ratelimited(FW_WARN GHES_PFX
> -"Failed to read error status block address for hardware error source: %d=
.\n",
> -                                  g->header.source_id);
> -               return -EIO;
> -       }
> -       if (!*buf_paddr)
> -               return -ENOENT;
> -
> -       ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
> -                             fixmap_idx);
> -       if (!estatus->block_status) {
> -               *buf_paddr =3D 0;
> -               return -ENOENT;
> -       }
> -
> -       return 0;
> -}
> -
> -static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
> -                              u64 buf_paddr, enum fixed_addresses fixmap=
_idx,
> -                              size_t buf_len)
> -{
> -       ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx)=
;
> -       if (cper_estatus_check(estatus)) {
> -               pr_warn_ratelimited(FW_WARN GHES_PFX
> -                                   "Failed to read error status block!\n=
");
> -               return -EIO;
> -       }
> -
> -       return 0;
> -}
> -
> -static int ghes_read_estatus(struct ghes *ghes,
> -                            struct acpi_hest_generic_status *estatus,
> -                            u64 *buf_paddr, enum fixed_addresses fixmap_=
idx)
> -{
> -       int rc;
> -
> -       rc =3D __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D __ghes_check_estatus(ghes, estatus);
> -       if (rc)
> -               return rc;
> -
> -       return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
> -                                  cper_estatus_len(estatus));
> -}
> -
> -static void ghes_clear_estatus(struct ghes *ghes,
> -                              struct acpi_hest_generic_status *estatus,
> -                              u64 buf_paddr, enum fixed_addresses fixmap=
_idx)
> -{
> -       estatus->block_status =3D 0;
> -
> -       if (!buf_paddr)
> -               return;
> -
> -       ghes_copy_tofrom_phys(estatus, buf_paddr,
> -                             sizeof(estatus->block_status), 0,
> -                             fixmap_idx);
> -
> -       /*
> -        * GHESv2 type HEST entries introduce support for error acknowled=
gment,
> -        * so only acknowledge the error if this support is present.
> -        */
> -       if (is_hest_type_generic_v2(ghes))
> -               ghes_ack_error(ghes->generic_v2);
> -}
>
>  /**
>   * struct ghes_task_work - for synchronous RAS event
> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.=
c
> index 63047322a3d9..7e0015e960c1 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c

IMO, just "cper.c" would be fine.

> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   *
> - * APEI GHES CPER helper translation unit - staging file for helper move=
s
> + * APEI GHES CPER helper translation unit - code mechanically moved from=
 ghes.c
>   *
>   * Copyright (C) 2026 ARM Ltd.
>   * Author: Ahmed Tiba <ahmed.tiba@arm.com>
> @@ -17,10 +17,176 @@
>  #include <linux/slab.h>
>
>  #include <acpi/apei.h>
> +#include <acpi/ghes_cper.h>
>
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
>
>  #include "apei-internal.h"
>
> -/* Helper bodies will be moved here in follow-up commits. */
> +static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
> +{
> +       phys_addr_t paddr;
> +       pgprot_t prot;
> +
> +       paddr =3D PFN_PHYS(pfn);
> +       prot =3D arch_apei_get_mem_attribute(paddr);
> +       __set_fixmap(fixmap_idx, paddr, prot);
> +
> +       return (void __iomem *) __fix_to_virt(fixmap_idx);
> +}
> +
> +static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_=
idx)
> +{
> +       int _idx =3D virt_to_fix((unsigned long)vaddr);
> +
> +       WARN_ON_ONCE(fixmap_idx !=3D _idx);
> +       clear_fixmap(fixmap_idx);
> +}
> +
> +static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
> +{
> +       int rc;
> +       u64 val =3D 0;
> +
> +       rc =3D apei_read(&val, &gv2->read_ack_register);
> +       if (rc)
> +               return;
> +
> +       val &=3D gv2->read_ack_preserve << gv2->read_ack_register.bit_off=
set;
> +       val |=3D gv2->read_ack_write    << gv2->read_ack_register.bit_off=
set;
> +
> +       apei_write(val, &gv2->read_ack_register);
> +}
> +
> +static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
> +                                 int from_phys,
> +                                 enum fixed_addresses fixmap_idx)
> +{
> +       void __iomem *vaddr;
> +       u64 offset;
> +       u32 trunk;
> +
> +       while (len > 0) {
> +               offset =3D paddr - (paddr & PAGE_MASK);
> +               vaddr =3D ghes_map(PHYS_PFN(paddr), fixmap_idx);
> +               trunk =3D PAGE_SIZE - offset;
> +               trunk =3D min(trunk, len);
> +               if (from_phys)
> +                       memcpy_fromio(buffer, vaddr + offset, trunk);
> +               else
> +                       memcpy_toio(vaddr + offset, buffer, trunk);
> +               len -=3D trunk;
> +               paddr +=3D trunk;
> +               buffer +=3D trunk;
> +               ghes_unmap(vaddr, fixmap_idx);
> +       }
> +}
> +
> +/* Check the top-level record header has an appropriate size. */
> +int __ghes_check_estatus(struct ghes *ghes,
> +                               struct acpi_hest_generic_status *estatus)
> +{
> +       u32 len =3D cper_estatus_len(estatus);
> +       u32 max_len =3D min(ghes->generic->error_block_length,
> +                         ghes->estatus_length);
> +
> +       if (len < sizeof(*estatus)) {
> +               pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error sta=
tus block!\n");
> +               return -EIO;
> +       }
> +
> +       if (!len || len > max_len) {
> +               pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error statu=
s block length!\n");
> +               return -EIO;
> +       }
> +
> +       if (cper_estatus_check_header(estatus)) {
> +               pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header=
!\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +/* Read the CPER block, returning its address, and header in estatus. */
> +int __ghes_peek_estatus(struct ghes *ghes,
> +                              struct acpi_hest_generic_status *estatus,
> +                              u64 *buf_paddr, enum fixed_addresses fixma=
p_idx)
> +{
> +       struct acpi_hest_generic *g =3D ghes->generic;
> +       int rc;
> +
> +       rc =3D apei_read(buf_paddr, &g->error_status_address);
> +       if (rc) {
> +               *buf_paddr =3D 0;
> +               pr_warn_ratelimited(FW_WARN GHES_PFX
> +"Failed to read error status block address for hardware error source: %d=
.\n",
> +                                  g->header.source_id);
> +               return -EIO;
> +       }
> +       if (!*buf_paddr)
> +               return -ENOENT;
> +
> +       ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
> +                             fixmap_idx);
> +       if (!estatus->block_status) {
> +               *buf_paddr =3D 0;
> +               return -ENOENT;
> +       }
> +
> +       return 0;
> +}
> +
> +int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
> +                              u64 buf_paddr, enum fixed_addresses fixmap=
_idx,
> +                              size_t buf_len)
> +{
> +       ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx)=
;
> +       if (cper_estatus_check(estatus)) {
> +               pr_warn_ratelimited(FW_WARN GHES_PFX
> +                                   "Failed to read error status block!\n=
");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +int ghes_read_estatus(struct ghes *ghes,
> +                            struct acpi_hest_generic_status *estatus,
> +                            u64 *buf_paddr, enum fixed_addresses fixmap_=
idx)
> +{
> +       int rc;
> +
> +       rc =3D __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
> +       if (rc)
> +               return rc;
> +
> +       rc =3D __ghes_check_estatus(ghes, estatus);
> +       if (rc)
> +               return rc;
> +
> +       return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
> +                                  cper_estatus_len(estatus));
> +}
> +
> +void ghes_clear_estatus(struct ghes *ghes,
> +                              struct acpi_hest_generic_status *estatus,
> +                              u64 buf_paddr, enum fixed_addresses fixmap=
_idx)
> +{
> +       estatus->block_status =3D 0;
> +
> +       if (!buf_paddr)
> +               return;
> +
> +       ghes_copy_tofrom_phys(estatus, buf_paddr,
> +                             sizeof(estatus->block_status), 0,
> +                             fixmap_idx);
> +
> +       /*
> +        * GHESv2 type HEST entries introduce support for error acknowled=
gment,
> +        * so only acknowledge the error if this support is present.
> +        */
> +       if (is_hest_type_generic_v2(ghes))
> +               ghes_ack_error(ghes->generic_v2);
> +}
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index 2597fbadc4f3..2e3919f0c3e7 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
> @@ -74,21 +74,21 @@ struct ghes_vendor_record_entry {
>         char vendor_record[];
>  };
>

ditto. "include/acpi/cper.h"

> -static struct ghes *ghes_new(struct acpi_hest_generic *generic);
> -static void ghes_fini(struct ghes *ghes);
> +struct ghes *ghes_new(struct acpi_hest_generic *generic);
> +void ghes_fini(struct ghes *ghes);
>
> -static int ghes_read_estatus(struct ghes *ghes,
> +int ghes_read_estatus(struct ghes *ghes,
>                       struct acpi_hest_generic_status *estatus,
>                       u64 *buf_paddr, enum fixed_addresses fixmap_idx);
> -static void ghes_clear_estatus(struct ghes *ghes,
> +void ghes_clear_estatus(struct ghes *ghes,
>                         struct acpi_hest_generic_status *estatus,
>                         u64 buf_paddr, enum fixed_addresses fixmap_idx);
> -static int __ghes_peek_estatus(struct ghes *ghes,
> +int __ghes_peek_estatus(struct ghes *ghes,
>                         struct acpi_hest_generic_status *estatus,
>                         u64 *buf_paddr, enum fixed_addresses fixmap_idx);
> -static int __ghes_check_estatus(struct ghes *ghes,
> +int __ghes_check_estatus(struct ghes *ghes,
>                          struct acpi_hest_generic_status *estatus);
> -static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
> +int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>                         u64 buf_paddr, enum fixed_addresses fixmap_idx,
>                         size_t buf_len);
>
>
> --
> 2.43.0
>
>

