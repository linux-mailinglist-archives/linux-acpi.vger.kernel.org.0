Return-Path: <linux-acpi+bounces-15160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA3B057A6
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13197AB2A9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F426E6F1;
	Tue, 15 Jul 2025 10:20:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4C274670;
	Tue, 15 Jul 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574841; cv=none; b=dC5qeFJArxbjsgDJjZiozLiV1ItHqyb6Z5hOlecIldIDiU8Hd+Sc+epYGefNkehNynvCdjF1+7WNDy65emSS72axeBPk+5wFYlHa3UyJcsPR+ZV8HxPgP3KThQxOrmwaLyfygeKkOh40P+XJ6K1jRLWLmKFyfrZ9Hf5FmDSnItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574841; c=relaxed/simple;
	bh=yd41TFE712Y/bFRqCxiGmx0ghvtl3Xu3zBj9HG9TbaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBj0+GuMzHj+GqaZ210HjSumOWUHVvEFNKyRoEXgwaSPAMqa7bqqF1gDWwXPSi3kJKX/i1CW+yCZZ72gO24V4t5N5l6UCmyYtxatsa7g8rx9ZGH2REExPvYbH2t3E9Q2oN4WfcZP011GKqcxVo5+LM5yo4Xxe5fHNsjJva/IhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so1749494a12.0;
        Tue, 15 Jul 2025 03:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574838; x=1753179638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdbUlKo89GUT2GFFy0xJ3nknbIlOKbofILyfW59SRy0=;
        b=OPSI6kRsKh1o65Ml22UtFpQnjGJWk8T+WOev1Vmu2Ql+Rl79VsGC+A1uihFUv12P2f
         yNvEBINiNckSInSs5AoKTDDH8+yDBpq5vzEh2R8qt1jdj2MaslzPauQ/fWO42ofMHyyp
         FA4OrIwtUAthX2d8pvCLVkShfR3X4SsekT0EczTmviexNU94Auy2DCCMF+86r9NM4rUF
         kSZM+npMJp1h4dg5hiQ6sc5E43vSHarKLk25Vbbk1pwBNvYVtzp0nVvRO+qvsSBy9/z+
         UGvyIL9W7rBIwU0uCCzdAa6rSKNMPXQ8R/pQySKNPRbjPH8n3PUNcW2w5spjgGiHV7ez
         Og2A==
X-Forwarded-Encrypted: i=1; AJvYcCUtxSUHYcwY8bRbz0GxVX/s2tkg5Sr3bhyb8rgSJlkggmt5yQAMKJ0cC5Dwlyp7OWJ/Ts/R0GGndCTA@vger.kernel.org, AJvYcCXV5R8h/F6DandRXLaf1CFWAy2eFnPqydeVL28jA1rxgWeLjvrKh+vP0bEGaEIzKGFwecAaJibYb5I0N/Hp@vger.kernel.org
X-Gm-Message-State: AOJu0YwRWItaKs/rP4m8hvLdgJjMIMg//efHILnXAXr4Rlq0HyaEB8W2
	KqUTaqtQCi+5YRhR6l8lxbJKU6JzMCz8VN1hB1NHQQqiAaihCUxF8Bpd
X-Gm-Gg: ASbGncs+Xbwk4j285Xt60dwdFxqh3ccnt3QnWgD6Nxw+2RcxU8kmSs2VuhOxaRtAyXV
	geOvJ65pw4Kbce6lnc88Wcf5Fi5Rqfv2z+pPkQn+GrEe1RyrbC0HOh90J0H8fAgUppexxbMaXT7
	hmPs1bWyNtKe3s4auD1+sM7pVGIoG3b1GNQ+rX1Us4Ej9foqUvW5Kl+2bmnGlX9bBIuxLrnkdM2
	mNycwAlOHAon6XQWfBM4o8hHOul6/ikLMXjfOg6sAOne3piV7GVCd21nsH/5GoN1UImSnodYdUX
	UXV1bwFtLslKeg1O1hcd8Qi/QDidyBSF6wdPAGcyqsFTp/9ZnNvNn1D8PQ5NC7xSIBBW6LZwaRb
	UqwMqf/3zDmqDeYqyyBdA
X-Google-Smtp-Source: AGHT+IGS6mBNikdxOB0R7A3Wc1cgRVtqHvOiuCHl17RaVwd6varOAGIQu/ykD7SPjndmuYx4FDWTOw==
X-Received: by 2002:a05:6402:40d6:b0:600:129:444e with SMTP id 4fb4d7f45d1cf-6126648d8e3mr2488643a12.4.1752574837792;
        Tue, 15 Jul 2025 03:20:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c94f4587sm7018897a12.5.2025.07.15.03.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:20:37 -0700 (PDT)
Date: Tue, 15 Jul 2025 03:20:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>

Hello Borislav,

On Tue, Jul 15, 2025 at 10:29:39AM +0200, Borislav Petkov wrote:
> We have all of that info in rasdaemon. If the machine explodes, one can simply
> read out its database from the core file. 
> 
> And if you don't run rasdaemon, you can read out dmesg from the vmcore where
> the errors should have been dumped anyway.

I approach this from a slightly different perspective, given my
experience overseeing millions of servers and having to diagnose kernel
problems across such a massive fleet.

To be candid, when you’re operating at that scale, kernel crashes and
hardware errors are unfortunately a common occurrence.

For instance, If every investigation (as you suggested above) take just
a couple of minutes, there simply wouldn’t be enough hours in the day,
even working 24x7, to keep up with the volume.

Thanks for the review and suggestions,
--breno

