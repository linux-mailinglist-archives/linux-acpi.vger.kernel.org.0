Return-Path: <linux-acpi+bounces-20183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0EDD11BBE
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98D6A3043D43
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D7296BA9;
	Mon, 12 Jan 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRanc8tu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVO+Uwz3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3728CF49
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212608; cv=none; b=D9yVyqmc57w/V0EvS8C00Npf9mlF21mN/6031W0RxtL4YdfNnBYUWJ8mP2/XSupHG+9UyNVnY44+vSp5OuLZixwdpcCBc6OSGymCtNFkbKZVTEgDV5MbbJ790WgF5mGQjJu6DRoBfqC+W0ikYxA09XdxBxUeslhfPID5+OPc5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212608; c=relaxed/simple;
	bh=iDFXfwWSoRhROG/Vq0Ji69eB6IojPN4EMOINzPWp4nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzYe6aMa6orQoZ6TNLpQmHG9Zoaf1u+A4wp7X2BLhbygUm/UjUgEV+S1gqm8AiqvOqO7uQwOHCuSldgQS5z8YjIRH93Cb5odvaYHvmwwLvQcp7l03utLQ2eB5yTAVVbxQ73vNCOO8I3ijGcXXzi8kZesMgVYk6nfcFXQj8fWbcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRanc8tu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVO+Uwz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768212606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
	b=ZRanc8tuDBUSAZkvZjkf8D9ZvqxL3jJLQhtfzULfDVhn7GUUR4Lo2VdVWK+aYD59Lg+aMb
	arsphN80FsJldLDsZ6WpStUfPh9pumxZfGkW/7R83riVAU2vGz7OSYN9SXNBWIsSeA5DqE
	jU8tP/QyWguos9dm+vQ2KycCbUTgcH4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-LORvHfhcPqifiz0TyQ_hzQ-1; Mon, 12 Jan 2026 05:10:04 -0500
X-MC-Unique: LORvHfhcPqifiz0TyQ_hzQ-1
X-Mimecast-MFC-AGG-ID: LORvHfhcPqifiz0TyQ_hzQ_1768212603
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d110fabso61684815e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768212603; x=1768817403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
        b=DVO+Uwz3KQoGJMRrvhMReupkOeciWpQhBLtfQSbbK7anl1+oZMq2g7J6emo/51H1X9
         9DeI9eNjGYUC/3GpIPup7MKzKwq1mgmKkBmgfEdyG0ei2f2ZtQXq+oOfxQtN70Eu4NQv
         MCkwBTe4iPWV/BMt7yguYZU7oAuxYCy0seQ6oQwqMG/80vhqtmIuch/xpDPDKRmbWYzr
         CEQgk3pEh+6fNAfMutG5EOQm3UUvNk4W1DGlr7Tgy1eRvUcjMqwU/W6Vo3CMjRcY8A3I
         8bptRGqubjZQFN+uDFnRPaa0tMyQJ2D6rAaZqZLM0J2CdUJqbVQrVKvKmeUdLxYNw+N6
         I5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212603; x=1768817403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
        b=odugT9YS3g/WddhA1U1NssmtfOKj9Y2cyZ5F4ub/OGR89QB2tjAnUk/IELxpcqsUd+
         48y5hmhGKeeYaA+Xz8XtKQiDyYQYcgJi7L9w6QuMOk3g6fV4P2QYkMVGTtOGFOphUdkn
         TNPvRZ/54j3c4HUWuEld/AIMxDt7XpYyV//ntb6M208e34dnbzNDuRAq+kCPa3kcK0TA
         jI3ighVuvxOyEqZGfnmMbEyCiPs2pvrPi35T4LLWI6FH1HueW+0DYA8UmIWBXqvSG7/I
         eLPI7RLoybQZ2057QBIkFCgqp5+QXZE3785AZByvVKgp/bO5TWcgg/FPYedElfyMqc/u
         ZucQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBA6BpFehoJLJqbRl8ylNr4o/TU8dVXrnR6bzB3CM/JzMTIZbaZ5jQNIjCzwdiLcy1SnFLNWEC9uYP@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXI2iOG2BsRqsoZxREggoLGaQ6+zHX6/zvxFfDkPyiTAaLqVK
	4YlMzNn+IwK56jvz44a+0A1pwD2f0L864gjlSQ6lmLM+acafb+KUTjsckPz55qWeYjXXXA9e5v+
	LLWmVH8pHob/tFJhanFAQEP93zR+IHoWhLwGpsP1Ohk4BM+KN/5CcScVk65vZzpw=
X-Gm-Gg: AY/fxX6OaQchevF6OXjhYzmtowNeo2r9NZC+yrqWbWWS4MMizs6nP1IUAQNYbXrk7jb
	J7BvnWF++PNRh3DlBGBFAYkKUqXzsgEJ6ME7czJD7u5udnxpjoDke0/fM0WxPu/rT5Sq1CQP/LE
	HExB2J39Hlvj5SkyhEaozrCWN2s6C7Aa7bK74WLY+9N6z+nVaWX0Bc1hkX+DscHwNaeNV1Unucx
	Vla4F1AuXKb4Zlxx9JOJ5CNszHtjstop2P2qWJvxsfTJsdDF9PkNsrqZJwZ5mRXfiOwe7Js2+eM
	JH4q9srCotT4XmGxiuNaKl5GRA2feO15oLB9Yi71wj4mkLQj/ResMc/defJTFv5/lXJQ/Eo1s5s
	fdpcdeKka6DDIKOzm2c7xisCRgtricLNfAl/p2n/C
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr193390555e9.21.1768212603456;
        Mon, 12 Jan 2026 02:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHxXn/UA4trykZ5T+SQc9F6yA7v1dNyRS4eMXq4oY/fXdGhX4AlgW2jGMNsGOSw5qPOxfWew==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr193390185e9.21.1768212603022;
        Mon, 12 Jan 2026 02:10:03 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm17906870f8f.27.2026.01.12.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:10:02 -0800 (PST)
Date: Mon, 12 Jan 2026 11:10:00 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VIII edition (OSPM-summit 2026)
Message-ID: <aWTIeLbQXalZtOGc@jlelli-thinkpadt14gen4.remote.csb>
References: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>

Hi All!

Happy new year. :-)

On 17/12/25 15:52, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII
> edition
> 
> April 14-16, 2026 - Arm, Cambridge (UK)
> 
> .:: FOCUS
> 
> The VIII edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. The summit will be held at Arm in
> Cambridge (UK) on April 14-16, 2026.
> 
> We welcome anybody interested in having discussions on the broad scope
> of scheduler techniques for reducing energy consumption while meeting
> performance and latency requirements, real-time systems, real-time and
> non-real-time scheduling, tooling, debugging and tracing.
> 

...

> Presentations (50 min) can cover recently developed technologies,
> ongoing work and new ideas. Please understand that this workshop is not
> intended for presenting sales and marketing pitches.
> 
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation use the form available at
> https://forms.gle/dR5FuzQRFNXZEQBb8.
> 
> Or, if you prefer, simply reply (only to me, please :) to this email
> specifying:
> 
> - name/surname
> - affiliation
> - short bio
> - email address
> - title
> - abstract
> 
> The deadline for submitting topics/presentations is January 30, 2026.
> Notifications for accepted topics/presentations will be sent out
> February 6, 2026.

Quick reminder that the deadline for submitting topics is approaching!

Also, I'd like to mention that the proper event website address is

https://retis.santannapisa.it/ospm-summit/

Don't hesitate to reach out if you need any help.

Best,
Juri


