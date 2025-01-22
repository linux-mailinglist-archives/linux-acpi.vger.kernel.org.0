Return-Path: <linux-acpi+bounces-10789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F16A196E4
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 17:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B546A1882A15
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F224215048;
	Wed, 22 Jan 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IcBpHX/V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7A212D69
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jan 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564833; cv=none; b=uC9txuN/gk/6GgEdf49YQWRdmGFBzEwaVq+90J38v8n9DAr3tKC49oWXhWTiY50FBd9Ko6fUADw1LPkdJ+qWm7NBUwggHDeonmiJ7BtQh2X6DQoxZsoGnMqinGJHcTxNpkb/ZDt/jyhIu0N91NCMymoH2lEmSLGLxA2yRypezx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564833; c=relaxed/simple;
	bh=oq4ucEml8Du+AQoyiQsM8vVo8X8eFmZKkyZqTd20htU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiSZYMj+rirATNQD4N9kTHmQlyshe0Wrli3KVeZtI7UcUQUpiSWuzIAjxp7OHoG3a3+Dcl2rLEdoHugQujRibkFiQ2fFb9feMaTPWIRuQUaCIAWD1aix/R+uhvLnwhHuUPudQ352Fhr7EJ/e9ifhcMnNbXuP8uq59KL8jO0wkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IcBpHX/V; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6eb531e13so392263885a.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jan 2025 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737564831; x=1738169631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sYaltL8gZYQo2Yt7u0tbi3ro18skyI7EvhRt4tvdiY=;
        b=IcBpHX/Vr6XNtC5YMZVfuKRCRIr+cLga3H/WlmdrGQ4Q4Ppd1iyP5PL2cgryrPCbqc
         g05H/2tviOmTBgUsBUQZQYCWX0acLYKBwZWlF5RKPP/2iE77ZrMjq/uCzpcb5LPg+9SG
         LQ9UuqjW92iojelpw2wTnCPegEzUyf9CTo9NIz7bvYC4glydYTGQCCSqUxEfJCB47p+n
         h7dJXBmLvlRdoMnmkQ1/6MuX8XwDoCAwtB9zNbPr3yfXK7/omgJskdllJ4+HKyVoFI2g
         iOtJTkEp+0yzTiC7Uac95ue0tRRqBnpAO4gn3rmhRSWSdWMqaPVNRJL2P7Di1XMk1QvC
         Mdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737564831; x=1738169631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sYaltL8gZYQo2Yt7u0tbi3ro18skyI7EvhRt4tvdiY=;
        b=J7KvPGv19wIIkNm3y+5vGcuXnCrbnuPj8xuytGViAYpeMk2QQ3DPr23yME2Xyu6hew
         81IFauDQ3U2N2N75TvrO5hC1rWZgQwaD3nizTAue/hqK4dQrxeDL/JRQp0LHoQdmINiY
         Zxmf8okm6Fh9E5sC3bMsq2kZ9QSXdZLIDYDC2geeenl4BuQ3BsEVF6UZ4G2f1Yc3bqL0
         MiByKYfjCvv5Qiq6UUOz+LZLRwaY1ze6ZEGUQ8Nq9UcXfiqiErjciD2HI2g24e8MEyh5
         pU41Rqu0P5X18TuPn5Bq32r74mE91MRtAHLd+zvRrMyQtalrqCBm+u82LNu/9x1axycn
         2zHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgW+DYqOK9axzElScmqeKU77NGQcc3oYm3W8qj52gbzM143i1R+s1178UzFhe+fvR9XmvUFzatMswY@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGXqZIaxGhWP6W8ONvcjcQXbxRCS35PVLO4q9p74llaVXCy2u
	wSd2wlozAJA8D/q50POihak6pPM0TJKxAMh5iPy2yjJ0E5dl5VPTjD1t/WoxSHE=
X-Gm-Gg: ASbGnct9bjHXb8HxPzC+TSBkbgdPAOcQspbr+NGmd2TSSU0nEmHQXkaGV0G8oC1dDqn
	iA2G/vzd7N7WXuG2a6RF6dfaDTAzl3+Xkr0BcSU8jGloe8sdQiUn6RkYUAen0q7rDtGviUWgcx6
	9r7M09pYc0V5Q9hM685QLb7ZD3T6LYRAMYie5RZa2XzXMr7QM9fBzgUM5oV3i+njYm7SykBzVrU
	TV5ewuVm6P/+mIzIQilc3o1s0CcMA0olFvHyCHksf0InPk68hb9EtPdmhFeYafadHQxN5YZPMsf
	SLtVvW+K/+4vHviD87alBr/+iEUuqxX2AYehN67voHMyS1rx2PQX
X-Google-Smtp-Source: AGHT+IGcrio+LQ+dKFTcjBpIjnWC+goe+/GikhWUO65GzbwEN4Ark8XD1eRKwktGnHdP8xLs9LquMw==
X-Received: by 2002:a05:620a:2986:b0:7ac:a0a5:9bf4 with SMTP id af79cd13be357-7be63246a69mr3897014085a.40.1737564830833;
        Wed, 22 Jan 2025 08:53:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614ef273sm678089685a.98.2025.01.22.08.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 08:53:50 -0800 (PST)
Date: Wed, 22 Jan 2025 11:53:48 -0500
From: Gregory Price <gourry@gourry.net>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>, hyeonggon.yoo@sk.com,
	rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Message-ID: <Z5EinHUAoHgiEL3N@gourry-fedora-PF4VCD3F>
References: <8734hbiq7j.fsf@DESKTOP-5N7EMDA>
 <20250122155935.1282897-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122155935.1282897-1-joshua.hahnjy@gmail.com>

On Wed, Jan 22, 2025 at 07:59:34AM -0800, Joshua Hahn wrote:
> On Wed, 22 Jan 2025 09:37:20 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> > > The current code makes sure that when you switch modes from auto
> > > to manual, it inherits the current state - instead of there being
> > > some hidden state that suddenly takes precedence.
> > 
> > I think that we can do that with two weight arrays.
> > 
> > > So I prefer to just have one IW array and no hidden state.
> > 
> > Then, when we switch from manual to auto mode, where to find
> > auto-generated weights?  Re-calculate them?
> 
> Even in manual mode, incoming bandwidth data is continuously stored.
> This way, when a user does decide to switch back to auto mode later,
> the system doesn't have to retrieve the bandwidth data all over again.
> As for the auto-generated weights, they are re-calculated based solely
> on the bandwidth data available. (I will note that re-calculating
> the weights are very quick, see reduce_interleave_weights)
> 
> Based on your description of the expected behavior, everything you
> listed out is actually what currently happens in the one-layer system.
> Switching from auto --> manual inherits the auto-generated weights, and
> switching from manual --> auto wipes all previous user-stored data.
>

Piling on - the single-layer system is very bluntly simpler (one fewer array)
with the exact same behavior.  Therefore it's better (in my opinion).

But this is all hidden from the user - so I don't care.  If you (Ying)
have strong feelings, we're happy to ship either.

~Gregory

