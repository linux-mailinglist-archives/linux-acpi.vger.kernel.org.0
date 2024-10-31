Return-Path: <linux-acpi+bounces-9202-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4645A9B7FF1
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B811EB2104D
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95C1BB6B5;
	Thu, 31 Oct 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gZUtTk+M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89619D89E
	for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391800; cv=none; b=EbxiQMePvuTYzGYlUa6hFDXHy1p9Cgt9AWIGYZ24E31x8tpkqVx6PuIBzGVzjFkCSGYg4qBMW2YJeoS9bJNs/UBOpDGn5HTOvpyUKSwxwLvXXnzxFZFkg1ifmt1TfoYc9EjcF3g1VVLQ5nrUTQEmEYzu4Ep6+QbaF9ZMouT0pTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391800; c=relaxed/simple;
	bh=pHyLyRq9icEl7h1hajof/4uWohbq3D4kb9tZ1Q3TxCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVq5/dmih9LIEPNIoG590N1TpoahZkhpeLPI0e4Du2piHIkGaN/hI6YhDfybFJLNcA4aV8xqHG04xXOJ7XhB66YAK9q3OnyLg/sYWxBITFVHBTlFtr10Ca9aygrEAd0tZdiQkhMRHZj+bbZS5i/ujs9ewvUV5WtK03qJczNbqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gZUtTk+M; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b13ff3141aso83277585a.1
        for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2024 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730391798; x=1730996598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrPPGPtF1r4JJPagnUAwxTz8GU4YzNxLE+E5DMVXteY=;
        b=gZUtTk+MOx/uW8niUvTxtE1mx1wLd06xJ1Fzf0VAq/a37c8IE0CgMYqR/YRIqc/PeM
         glruGuWnZaVdPQYgXSd3r3DDZsdiwdvNZf23sKfX0lOBuS8Dm1Tfrs2zE3gWIWpSm1HO
         40gJLN7nRgORDTZL50O91uX9cXGHJTlcSSEAmpGcUsVvtwFgQqZEoqHtdwYEeITjcdTz
         rUivGBFV+Wb/QTRTLlFvaJ4fh8N4HOouK7EvVs99+cdUHcWmBZtFzO8snywNYcHXDJEI
         8lcg33HHjv7OmW9XiI7evMjeWYFS7jDrcHYJ7lUkI3EcDIG+5cL7Mzp5161pwtp8mvvD
         U12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391798; x=1730996598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrPPGPtF1r4JJPagnUAwxTz8GU4YzNxLE+E5DMVXteY=;
        b=DanBL7K5JGD/imH5tfI5zMm5trsGp2RbNix/sx+aDSKcAe3gYGAzG3Mjp7/wlrjqCL
         sQtrWsySsikyimOhZ4VxAWp80Vjvfnqt6X3JhGINDzDDBMYbfC1POSktXG9V0CTUjEor
         IBN5XSzO+ZWDcotf5SE/2NxLh+FWreDdUU9ZkLD72VXv/EvIOsylOVEsyADbJtWWhx+b
         S7OmJd/yw+XwSTUkbbzbPehTiwKyRCaeDXVHHEOeeEZMvpyFgL0AjGDGU1anjgouW1lc
         P7xt4eEykUbsIsTMlpbM7GTvhibFSROFS7pVTNyRH+jP00eggyIad4aEXunuhmkIh0sP
         S3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUQLoiO/dA2cp3RRTWzXRXJK1UrY2Bziypsc2U4krBWN3P/JOpDS+uJfVmtmIT7pdyPutNf2IuhcJgL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44NunfCJG+0oFFo1LgLSJp8tw5YMsBE9of9sZS08SOaylMGAk
	5q9ApRFq+wjCaiCDbrpzvP5ay/2pFWuU6yPelQoeM61BcrTc93YXduEIuXeno48=
X-Google-Smtp-Source: AGHT+IG0mJPHTCww3DZQuqv9nxseKwFokKX1MWnv7+XcE4NElcJk7zAVUMyfqkFKAZ8kX5Mw9dP5qg==
X-Received: by 2002:a05:620a:318b:b0:7a4:d685:caa9 with SMTP id af79cd13be357-7b1aee2c038mr1047669385a.48.1730391797615;
        Thu, 31 Oct 2024 09:23:17 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39ebab8sm83428485a.8.2024.10.31.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:23:17 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:23:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH v4 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <ZyOu-7MeTYGa7tf9@PC2K9PVX.TheFacebook.com>
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-2-gourry@gourry.net>
 <ZyOUp5Juz5x3Ivrn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyOUp5Juz5x3Ivrn@kernel.org>

On Thu, Oct 31, 2024 at 04:31:03PM +0200, Mike Rapoport wrote:
> On Tue, Oct 29, 2024 at 04:20:39PM -0400, Gregory Price wrote:
> > + * Return: 0 on success
> > + *	   -EINVAL if size is 0 or not pow2 aligned
> > + *	   -EBUSY if value has already been probed
> > + */
> > +static size_t memory_block_advised_sz;
> > +static bool memory_block_advised_size_queried;
> 
> kernel-doc will be unhappy about variable declarations between the doc
> block and the function it describes
> 

Yup, that was the warning I was waiting to clear KLP.

Learning new things n.n;; - new version shortly

~Gregory

