Return-Path: <linux-acpi+bounces-21517-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI6fHQYPrmn7/AEAu9opvQ
	(envelope-from <linux-acpi+bounces-21517-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 01:06:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3DA232D73
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 01:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BC43300613C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ACB13AA2F;
	Mon,  9 Mar 2026 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q5Mq8Zim"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E886329
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773014786; cv=none; b=T8vUKYlZlE1x5YPtWIjFEYS4M0ZefEHocKHQ9wq4WQmfUjsccDQR18SD/U9+287pB7uuQo7WqceGNCy4czI2S6/mwBtzaL/EZWaOb9CvEpt7taO1ziYk/r3Ry2/Hnwd9P5fkhvHRxhWMO+Vot0U3jY9qQTRWsSUl2opo2KWuShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773014786; c=relaxed/simple;
	bh=GWAy4SlMgiiwMcJuaHhTNI8/YoEwWVInasLRrMpru8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kde6Ob/f2abUs/u30evct6uwJ44ao167Cvlrz7e2XSDJkIrHYrG9wglvuuEFZ6oGcv5J/sc2emx6JE0Wi3HyXCjjgTcxI0dLT0dfO6xjtJHHHSSpXyaStGi4iB6x1QEAcKKnZ1tuCQDutng2sRe/ddRk+RU03AkALuRHGi8QG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q5Mq8Zim; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a1347051aso104061576d6.2
        for <linux-acpi@vger.kernel.org>; Sun, 08 Mar 2026 17:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773014784; x=1773619584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E63/CSKkVqJAC9JwqiUKsNfXHYaOZS6yvHj9VcfqZOQ=;
        b=q5Mq8ZimzAmQAvCl4LRsYoTfV8vKR4edPgDtkja/uvxinS/YTlrSoXy6ixxBCHJN0e
         NzJjMTDQty/4gfg4cpWdquehDv45bIs0UYwUFnpm43PIxbCDr3z2i/29fM6uFTro6TqW
         NRC8dC0A/eeAvX0J8g6v2GV2JpP4jyc3nPluHR9UMt88tFfEbFekp9KroRcaRutDKo3t
         2UoNEbkhh5Gdf46Ff9trb3uBrH+yRIaK0rEy3eqZf7Wge+Kj8dWcs3TvG2/AikkSrG2t
         Bv7euFGgUXvxItk3PFESsO0lhhkPj5vDmHt5SWzcR43MJvBiCfq9KseLj4YMswakJ/jE
         NQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773014784; x=1773619584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E63/CSKkVqJAC9JwqiUKsNfXHYaOZS6yvHj9VcfqZOQ=;
        b=bcC+FIQGJP1TgOCDAsCYitjuhx+Mr5i2rOxzgnKE2MBeD+pDXatflmbkL+jqLgcbGC
         AnBE0i0FizkrhG4Vv9GGXm3UlwFS4QdNohxwXmANKQql3Efh7e9E3vxO5retzJ9YJia+
         zXvU7La0hh47K3x7C5EjGFvMkTTyt1yqw2eWiFffXkUAaslyMTC920mT9hBJ6XFf6lju
         T1ydZnLJdTD83YPwv9/hJ8OBAY2uJoYtuBLVSJYKno6KtwiFvcODY6paSaToHoyfVkwN
         NPExdZ9NdLHny4JWVEr4y9hg2u2TIktePcsgl3NFgt7KaUmrjGnpNP/D7O5YS6bKw4eJ
         nXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxG+eyHr3jCUciTAlfvHyzS5pTnYTAP5Bzg/D8ayr9EDzGaOm1tQ0ZcceXdTYlPxVaCUpD7/BHexPs@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNexQgeDEnUbswmiOS4ybNVWsXwHDpA5UpsbZH2aWH97qbgP0
	zFbxD8I90E6WS/XpBHLAo6L+q9rJwuXGc5Tay/f4dap2tgwR9gK5oE7rtZAKignU0IU=
X-Gm-Gg: ATEYQzwAx+W3U9T1zZvYt7op+hwPn6ScHlLvqJGeM81nd4pxWPJSLoX2dRDVzb5NYEP
	XyYjlkzuTEp+zJSfvQsJ2kNPOD3yevDKISstNNWGhxPhjAVCs7wcMEodvndYgpLCpNbi92xbNuz
	b5Gts3bgTZ2gb7zHGstn7MrwanVFsDe3rDaVF3DQ/5pLfL0XqtiZnWGeMS672TenMSO10GnKeDt
	hmO+mhTauk+FMZ8ynImROHxBbNHboGTykbahOnAW4cTACjgjDPlT0PuKJvWyghO1M7GBTE2NM8U
	xSaOwzCPZ+62L3X/V4SuBk5BKfTTdxTyQWXjdX7D0vVBxZvO2lPH0sKGi5mjEydt3hId2nFjAOq
	vLBtwVxPMNnd7vPjBt+ZnzE/9RIeN5knleX2IhHxA3xc9ezquxvqDpsGzkQ4RikYo8T4/sQPObw
	8KMPit/MsmyhAKxv2lvbcBWZDqsyd7BbCyi+rXNFI8DFeDeQlePHgBGmBVsZWJnDPJRnnMz/X+d
	UwCQXvPgg==
X-Received: by 2002:a05:6214:f6a:b0:89a:7d9:34a0 with SMTP id 6a1803df08f44-89a30a8006emr148896126d6.29.1773014784142;
        Sun, 08 Mar 2026 17:06:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ec97dsm66613336d6.42.2026.03.08.17.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:06:23 -0700 (PDT)
Date: Sun, 8 Mar 2026 20:06:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Kai Huang <kai.huang@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	nunodasneves@linux.microsoft.com, xueshuai@linux.alibaba.com,
	thorsten.blum@linux.dev, wangyuquan1236@phytium.com.cn,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is
 on
Message-ID: <aa4O_TC7Kzbov6bv@gourry-fedora-PF4VCD3F>
References: <20260308222313.14014-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308222313.14014-1-kai.huang@intel.com>
X-Rspamd-Queue-Id: 1B3DA232D73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21517-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,gourry.net:dkim,gourry.net:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:23:13AM +1300, Kai Huang wrote:
> On CXL platforms, the Static Resource Affinity Table (SRAT) may not
> cover memory affinity information for all the CXL memory regions.  Since
> each CXL memory region is enumerated via a CXL Fixed Memory Window
> Structure (CFMWS), during early boot the kernel parses the CFMWS tables
> to find all CXL memory regions and sets a NUMA node for each of them.
> This memory affinity information of CXL memory regions is later used by
> the CXL ACPI driver.
> 
... snip ...
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

lgtm

Reviewed-by: Gregory Price <gourry@gourry.net>


