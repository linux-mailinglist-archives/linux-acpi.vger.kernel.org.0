Return-Path: <linux-acpi+bounces-17089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E149B81A78
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 21:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD703BB125
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8930C107;
	Wed, 17 Sep 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxdhUtgA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212B2BD037
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137583; cv=none; b=fPAG+cplvydol4Oa+6M2JSbppzTzWhCf6n9F4e5GOMJUOxCBkee3KFXYXjOnSRBVKZicaKX9BXYczBgVhkvGgWL1r6zCEGXj4vbEXcsf1zNHBoxnNYu+FBTS/MevTwcIzsF4o1qpndp+mIzlqRaHP5RHPCcte9sBBzxtiVaJ7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137583; c=relaxed/simple;
	bh=TO0ApVDKmqJxTJpzI7caOScDCiljntTfRh17Dub5c/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGnmV4GV/sCG3V9d7lyghzFfg6KpAJOISGhdhUqC82BBLE9KGBL+58znlQH+RT9rOA6IUItPOnn03MTtsBRkiQo/aoPaFqJBhpEr8p7KxYemvOgq0aRdjrf59SFKJuqIUaw0O20QUrz/4YN/WxzD6m1V/4/kyaR0IcVzx22cJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxdhUtgA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f2d21cbabso765e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758137579; x=1758742379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RmLnlfE5wdqHFkwFJDCHGu9ac/98s+fF8hA4wv+ATE=;
        b=AxdhUtgAwa68UjenBLwFWCZBNzfgg0lpxLVK8NYud0rs5swfXSS4R8r0Q4eMInX+oX
         rKb5a30hi0ilIsV1xkVs+neknqizXMYYz/05KGwN8mgGw0FgDaJvksVhlp+F3RURcUSM
         +hmegYWnkb/Zm7vvI3s5ONwQ7rpwRRIHKVkiByka8L7m1iHu+889273wy5fx5vVO8pH+
         FogbwDXQyZVtSQnUP30vzkf6n/XO5gENH1Fk/X6Ge/hSwrSXs30oL71hCvUF5uLqqh9m
         0WFUfyQWjcqgC64gis05hxeYIDPeCwJiIyF4jgvbi8GNPbneBCVE9T6kJSabYZcltgL4
         fZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137579; x=1758742379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RmLnlfE5wdqHFkwFJDCHGu9ac/98s+fF8hA4wv+ATE=;
        b=iJ+NxNETZPNa7ojwniYCRYxYTVkjIrjbNOBzMGKNY/SHA6SQZNITJWr3t4gwnvpINr
         zQNuKr7pYmuaslCLb1itP6Rfjwn9Jlo3NKI6WfU1d0vcyRfZZfI49XL9DeSN1cZcVvbG
         zulZiptfQ8l2kXxodjG2jij2W1GE1ECMwarJLSdIM6KY5ks2Qv8UFfC3Zg004/XO6haw
         DeRuFfTzAaFbrZXQqGngjTgjI4JrKy8f5aOfLdk8c1GliLPzwh1otmx/kWAiA5GiqzJN
         dPWtEDvsoTUO9lL4GdqzW6+SBIEas7WZ6wG67BxeM+IsV1G9955FalHkGXcQuPNUEhGM
         qqpA==
X-Forwarded-Encrypted: i=1; AJvYcCW+jXDiLH+pQalSslrHOixskgM9EyvIb/kW20hQAI/Ub0Ox7LA2NymQAyp4WARbGlmufqUTjoqoYnLD@vger.kernel.org
X-Gm-Message-State: AOJu0YxRyMbiiVe6IwTxvfjXHN/A3i8s+nYM7R+afNnMVT20Rhb1Rnrk
	o/sMTLJB6ifJL3HMDcmVN+dk47BlYpVvRGvdiynlmV1spg26QjQB6nMYBlHAsJrlzxv0cYUY1am
	jRClcEXZURvYKmReJcnfVqEQNPSma7rdwwkMXddZB
X-Gm-Gg: ASbGncsXuVz1WRqUjlS/pnHTosfFHNuNyUFjACXkfxRtEXiDaFKAEGNqDVcpxP6m8g/
	XueU/g7rI6Vyg3JHLtdu4o69JCkyLIZaVAYzPtoWPaTFtAn75fYGhKUMgTXAnreIBrF2F/S4BJZ
	jl19skjFRGCB9Soq51TA6izs2mvMmp0HADPBwGG4LTm99LLOI1XEBogzaeLjCT6chLNgMr4mFKZ
	m4ZrlCwG+en0WyifY2rh9FJQymK5matyH0UUwoqOLCl
X-Google-Smtp-Source: AGHT+IGEb9fQVFGlEJXvdZv7glWzKfh9yb2g3ypJs/1z3YlFmIJ1fCW1zhKyPJig4x9nGqaEce6mvh0neogmq1REEMo=
X-Received: by 2002:a05:600c:4927:b0:45f:5b02:b0cb with SMTP id
 5b1f17b1804b1-46149490f52mr1528735e9.0.1758137578779; Wed, 17 Sep 2025
 12:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMiu_Uku6Y5ZbuhM@hpe.com> <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
 <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com> <aMsDJ3EU1zVJ00cX@hpe.com> <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com>
In-Reply-To: <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 17 Sep 2025 12:32:47 -0700
X-Gm-Features: AS18NWA8ltNJ-1yAPEykUi8kpppNk1zprgJjx3ovrdKhQKA72C47t087_EGFCP8
Message-ID: <CACw3F52p45t3iSZPjx_Lq9kBn1ZGTDZsxk+iQ-xFA1zdvdqqrw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: David Hildenbrand <david@redhat.com>, Kyle Meyer <kyle.meyer@hpe.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org, corbet@lwn.net, 
	linmiaohe@huawei.com, shuah@kernel.org, tony.luck@intel.com, 
	jane.chu@oracle.com, Liam.Howlett@oracle.com, bp@alien8.de, 
	hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org, 
	laoar.shao@gmail.com, lorenzo.stoakes@oracle.com, mclapinski@google.com, 
	mhocko@suse.com, nao.horiguchi@gmail.com, osalvador@suse.de, 
	rafael.j.wysocki@intel.com, rppt@kernel.org, russ.anderson@hpe.com, 
	shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:05=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 17.09.25 20:51, Kyle Meyer wrote:
> > On Wed, Sep 17, 2025 at 09:02:55AM +0200, David Hildenbrand wrote:
> >>
> >>>> +
> >>>> +  0 - Enable soft offline
> >>>> +  1 - Disable soft offline for HugeTLB pages
> >>>> +
> >>>> +Supported values::
> >>>> +
> >>>> +  0 - Soft offline is disabled
> >>>> +  1 - Soft offline is enabled
> >>>> +  3 - Soft offline is enabled (disabled for HugeTLB pages)
> >>>
> >>> This looks very adhoc even though existing behavior is preserved.
> >>>
> >>> - Are HugeTLB pages the only page types to be considered ?
> >>> - How the remaining bits here are going to be used later ?
> >>>
> >>
> >> What I proposed (that could be better documented here) is that all oth=
er
> >> bits except the first one will be a disable mask when bit 0 is set.
> >>
> >> 2 - ... but yet disabled for hugetlb
> >> 4 - ... but yet disabled for $WHATEVER
> >> 8 - ... but yet disabled for $WHATEVERELSE
> >>
> >>> Also without a bit-wise usage roadmap, is not changing a procfs
> >>> interface (ABI) bit problematic ?
> >>
> >> For now we failed setting it to values that are neither 0 or 1, IIUC
> >> set_enable_soft_offline() correctly?
> >
> > Yes, -EINVAL will be returned.
> >
> >> So there should not be any problem, or which scenario do you have in m=
ind?
> >
> > Here's an alternative approach.
> >
> > Do not modify the existing sysctl parameter:
> >
> > /proc/sys/vm/enable_soft_offline
> >
> > 0 - Soft offline is disabled
> > 1 - Soft offline is enabled
> >
> > Instead, introduce a new sysctl parameter:
> >
> > /proc/sys/vm/enable_soft_offline_hugetlb
> >
> > 0 - Soft offline is disabled for HugeTLB pages
> > 1 - Soft offline is enabled for HugeTLB pages
> >
> > and note in documentation that this setting only takes effect if
> > enable_soft_offline is enabled.
> >
> > Anshuman (and David), would you prefer this?
>
> Hmm, at least I don't particularly like that. For each new exception we

+1. Given /proc/sys/vm/enable_soft_offline is extensible, I would
prefer a compact userspace API.

> would create a new file, and the file has weird semantics such that it
> has no meaning when enable_soft_offline=3D0.
>
> --
> Cheers
>
> David / dhildenb
>

