Return-Path: <linux-acpi+bounces-4922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341A8A2B6B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090E71F22E1F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007851C36;
	Fri, 12 Apr 2024 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IWTIrlwY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A974F5E6
	for <linux-acpi@vger.kernel.org>; Fri, 12 Apr 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914957; cv=none; b=lGlG126q7MPxg/xYBXoGwXdSAk1KYPwcmHyUc6LM4i/S9vZ8gXmFEjxxEWJn3RZZrXM1HD5oBvAOvHHEBUq7B/OcYBUUhc0ZpkYdmexDUlC2RM4nrOIsXjde89tCVjrFWmgU2OkrOnA4c7LFYdpaQIVM9XvHe6b/cLdR3KAq0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914957; c=relaxed/simple;
	bh=ze1DWENhxjeSOlCRPZPYtxubM7dRkcTEXeXj/CC5r3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9nNunqkMtSnJZi7GpI7Zmozl4mkeTv7jz5quLIzMBujFV9Zl37M12v3rzg0scA4cLSNTiUKpsBcPzObsxfP84oJlWQgxDbugqslwAe3lIPtNiZkOPKrG2AehLOi20OhKzWN0gCLS/EI5crIGXwtwTzDInVO6461MST7o5gVD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IWTIrlwY; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22ec61aaf01so418671fac.2
        for <linux-acpi@vger.kernel.org>; Fri, 12 Apr 2024 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712914955; x=1713519755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze1DWENhxjeSOlCRPZPYtxubM7dRkcTEXeXj/CC5r3A=;
        b=IWTIrlwYJ4ebmbn5rm/qdkw/s+/ZIu6L5dHoC/3auUKZAO56T9x4tRxDDyCYaupbKt
         B9Iwu3j1SUy4yRSyZ8exefJsfNwRc9ne+0DMwA1YipgQ9LNDzAtegh/J3SNmkgS+g1a8
         p28Me2LWBqf0zfTn09fpoYwRxpsBVPvNwGKsBKZTFR+QONTglsw4+GvumZN/f4SaYA9i
         W1Iz9taRP5nfNzQw1a1xr2TmKClggCRRAW3tXNBET1zpIAjlSZjqa1PzJOq2lsy8EHpi
         5AoIAljxA6SIsqoNh3YV3FLdOoVxkqYWFVrP6z6AioH3tzJIcFwjrGfCQ2jyE/IjQMlU
         tJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914955; x=1713519755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze1DWENhxjeSOlCRPZPYtxubM7dRkcTEXeXj/CC5r3A=;
        b=PBAqD5Ki29e0WE8cb88MpOYKabCtWaexDDg3kXcY3WjNLgyPQtPSqyIQPy/StT6a9H
         8ePQWYYzMULNB6wqgPwr9bz09KOl8IGsieuas1FF643kqUmOMih/gPhfwgG8HKbqZEKx
         xlxZdnGJgaWqGZM8TyoaphhNxGY+KcxqDBzNGq28ZBl3gHfmnH/+VLlxcjOgPiDjA/kU
         DhDKGLd90ZYbewLTxLkyxOSnf7GMi5eiUveGh/LZ/xeGcKR/zwBWMeC1ihEmTQjdx9+Y
         xkPPZW61w/2UFnzFVTgf8P7voKNAh7h/mOyyRtI5g/g4GvySXcszm2fZFmLZPo+y2ski
         iVuw==
X-Forwarded-Encrypted: i=1; AJvYcCW7e1jrk/A9cl02hnyqReiGYn878Hia9rKxhxQfK3wMw4vtlpxnNwB7dd+6DuP6pa1Wxi4akm8iv5D649x5VO1K1aBgojgXRfdSRA==
X-Gm-Message-State: AOJu0YzHcFTrwuJ4CaPR3zkMasSSFu+OSm38VV3/9OhbYUmTHVTp3cJD
	gz4K64PXSuaZH9QVNG/u7ELeMaWrLhEqKa0eXriuEgF4d48q+vH3t5JUpz5s7YJDEjAUZKs+hxT
	YrS9mFp0LfhTqy+q1IElnJ+3sW6WGYHVBBmaIcQ==
X-Google-Smtp-Source: AGHT+IH/sAzC/4m+8OjoiblQKBrR8gWNhfHFXTBCOEtjXxsaKNwMpXmrJzZaRa5j0HjVtDAPxdFhGnqZozPIYpPkLcA=
X-Received: by 2002:a05:6871:5a05:b0:21e:b4d0:9961 with SMTP id
 on5-20020a0568715a0500b0021eb4d09961mr1977670oac.55.1712914954014; Fri, 12
 Apr 2024 02:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
 <ZhetojJewygmTf6N@bogus> <CAEEQ3wkfHvH4jXNO5NRDf0Fc3xUkY64hp7BDBmgNVdcsmYy-kA@mail.gmail.com>
 <Zhj-4C7xlklG1m5B@bogus>
In-Reply-To: <Zhj-4C7xlklG1m5B@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 12 Apr 2024 17:42:22 +0800
Message-ID: <CAEEQ3wkO4WPaY+bPidg-fDqV5MrQwh8ESbSv-+q8Odhat9XDrQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Fri, Apr 12, 2024 at 5:29=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Fri, Apr 12, 2024 at 10:10:05AM +0800, yunhui cui wrote:
> > Hi Sudeep,
> >
> > On Thu, Apr 11, 2024 at 5:30=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.=
com> wrote:
> > >
> > > On Sun, Apr 07, 2024 at 08:38:28PM +0800, Yunhui Cui wrote:
> > > > When the type and level information of this_leaf cannot be obtained
> > > > from arch, cacheinfo is completely filled in with the content of PP=
TT.
> > > >
> > >
> > > Which platform is this ? Is this arm64 based or something else like R=
ISC-V
> > > based ? That would help to understand some context here.
> > >
> >
> > Thanks for your response, RISC-V currently has this requirement.
> > Please see: https://patchwork.kernel.org/project/linux-riscv/patch/2024=
0407123829.36474-2-cuiyunhui@bytedance.com/
> >
>
> It would be helpful for the review if you have such information in the
> commit message.

Okay, I will update it in the commit message in v2. Do you have some
comments on the content of the patch?

Thanks,
Yunhui

