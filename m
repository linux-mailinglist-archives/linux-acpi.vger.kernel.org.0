Return-Path: <linux-acpi+bounces-3443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D88529AA
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 08:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81D21F2105C
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174341755F;
	Tue, 13 Feb 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmxCKeWS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD21754E
	for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2024 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808952; cv=none; b=mAM/KD1YW1K7WrtbCPGowclBUVjPgy3tadeF4SMsC3LHKNTa+eOdpcVWoqTz9yOfe19Fnl3XI7rOWWZWw6duqxxhFHoS3cDr8YlQLpZR87cOB+WzUtK8layNcAz+UTw9QLzVORsiUkPI5my+yoqZFurcEL54MYAiEVc7Tznnf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808952; c=relaxed/simple;
	bh=ozeZ7FqGPCKUWXvXyQuga6WAhbDvE50uGIz70z7K9Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4pLK/uM5H/WiKKSSC0IqAwAiaYhtwpx3AlLoF4uSxHcDNlwQ+B9XlM6AVUAXUqI0QSr29KdUoTvy1TAZiyziiZlBDkCJLkVh3v0tfHgtQok8tzLptnebuUHM9tzyulehTqs6ttddHKdiaSDbTHr/tN941XdA0/fpRtk7QyhTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmxCKeWS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707808948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGhe/YEZnEtGdd9u8LC35GLq72EBNiME+lxjrDlx7s4=;
	b=VmxCKeWSM22xvX9CD2n/jZZBC5m+q8wXxEYejrgtn9wkIHdQhG9YmcGUjtlCW0C3f7/60R
	65VQrSlryCIv292n3kyqyEhb26evNddczz4UohNjj8gVtL7eX4Ydj7Em3rRX9G319v4WrL
	FgEEIDY/Ys+IoxvNmgdkfDpCHLpDvM8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-dvLl1j6GOsOcJxmSRA07rA-1; Tue, 13 Feb 2024 02:22:26 -0500
X-MC-Unique: dvLl1j6GOsOcJxmSRA07rA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bbaf0ee0d9so5929982b6e.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 23:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707808944; x=1708413744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGhe/YEZnEtGdd9u8LC35GLq72EBNiME+lxjrDlx7s4=;
        b=SK6ZstgYR44/i6S/PnoOnQNn/VfmWswWi6B0N9R2tFy6JJYW0WnChzXdcxjwE3qHVQ
         rOyGU3aNTE4ZSmLSDZgIAn38dZxejOVkJNWc9buudrNmq3uJykdgp4YByQ2vjyUVd6cg
         1m6uSPl4PoO01hgnPmZoTZI81yILaCX/U3Zp09qNo4nlCFzu9lc/pnqiamAGNToj5CBn
         SxlNCInermULkqzl16GpE1HyKtI5iq1Grzw2RaZYH57Z/H8AfhJg/E4tui5GrrF5ZNr+
         tVT/3pzvgbhm4NVGq9akhRogiw85vEHCnT2GMJLQfyvG4P7nV/MEyovXxpL9NanvhrhW
         odGg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ExkuGSsX51mB9/q5WPwYp3Xp4nJIPA9jJdI99j7Ph8+6HYgkaKeLzG+KVXGc1/VWfSf9IOnY2eWJunIjLA/GtwX/nA2jCWmKIQ==
X-Gm-Message-State: AOJu0YzXMddbYjty775XnQ5TA+/N+nbs/CCq5XuTKq06A2j8gH2gDMiX
	iH/z+27ZDC+i/b/Ef5skcXy4sAVOuuIm62+e4OLJXPO5evjP8wXMqANxMDhLkm12MGs7B5v3dhn
	RcLJVQ38fjP12dALRJeKlHRjNu+DhmHEXpX1lct/NyIwvg0LicbL1bkCTH44=
X-Received: by 2002:a05:6808:21a3:b0:3bf:e6c5:9b1f with SMTP id be35-20020a05680821a300b003bfe6c59b1fmr11167872oib.43.1707808943954;
        Mon, 12 Feb 2024 23:22:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEigHFXP+2h7Q/N0HEHy6RpNKMeeDNhg5ntkf8WvHxyDqYobAdFtx48sRQblZ+4wCHqA8X5g==
X-Received: by 2002:a05:6808:21a3:b0:3bf:e6c5:9b1f with SMTP id be35-20020a05680821a300b003bfe6c59b1fmr11167851oib.43.1707808943512;
        Mon, 12 Feb 2024 23:22:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkh3GDANAyn31CsDbSSGINl5Qk0DsLS4jKDouEEYysktm4LhSXTreW0BSz9bBaLGM2PH1TEXw8yWTuEJHZqD8SWq5kdBbCef6l9d6bMeylSPkPKn63WKKPyOi/JjGNr19PTQr8J7H2zkugFZyWkVY0e1BGY/KCCJUvL77FVgM/+q3/NPWcD1QD0c/RLfC4vDM4U8fP9fRmsy2vKTCH/FmNWQM0nH+UUll3hP+w8VHDuVMjETcmcWRK+PNel5D6bOBcDxGlMBIgXxIMZ7FPho0sNHelmYHzJojFGk9QQ/kaget2/zK7mO05b7eRzMMzPprfNBiAS7hOPim2q7uvGVPn1e8xPDzDY/BwyA==
Received: from localhost.localdomain ([151.29.75.172])
        by smtp.gmail.com with ESMTPSA id p9-20020ac84609000000b0042c7a76d267sm910557qtn.36.2024.02.12.23.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:22:23 -0800 (PST)
Date: Tue, 13 Feb 2024 08:22:18 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Georges Da Costa <georges.da-costa@irit.fr>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VI edition (OSPM-summit 2024)
Message-ID: <ZcsYqkkMa-4mk4G6@localhost.localdomain>
References: <ZbJHfiWnujLz2Pfm@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbJHfiWnujLz2Pfm@localhost.localdomain>

Hi All,

Gentle reminder that the deadline for submitting topics/presentation is
approaching: 19th of February 2024 (this coming Monday).

So, please go ahead and add your proposal to the shared doc

https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing

or reply in private to this email with details.

Don't hesitate to reach out if you need help!

Best,
Juri

On 25/01/24 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VI
> edition
> 
> May 30-31, 2024
> Institut de Recherche en Informatique de Toulouse
> Toulouse, France
> 
> ---
> 
> .:: FOCUS
> 
> OSPM is moving to France!
> 
> The VI edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Toulouse
> (France) on May 30-31, 2024.
> 
> We welcome anybody interested in having discussions on the broad scope
> of scheduler techniques for reducing energy consumption while meeting
> performance and latency requirements, real-time systems, real-time and
> non-real-time scheduling, tooling, debugging and tracing.
> 
> Feel free to take a look at what happened previous years:
> 
>  I   edition - https://lwn.net/Articles/721573/
>  II  edition - https://lwn.net/Articles/754923/
>  III edition - https://lwn.net/Articles/793281/
>  IV  edition - https://lwn.net/Articles/820337/ (online)
>  V   edition - https://lwn.net/Articles/934142/
>                https://lwn.net/Articles/934459/
>                https://lwn.net/Articles/935180/
> 
> .:: FORMAT
> 
> The summit is organized to cover two days of discussions and talks.
> 
> The list of topics of interest includes (but it is not limited to):
> 
>  * Power management techniques
>  * Scheduling techniques (real-time and non real-time)
>  * Energy consumption and CPU capacity aware scheduling
>  * Real-time virtualization
>  * Mobile/Server power management real-world use cases (successes and
>    failures)
>  * Power management and scheduling tooling (configuration, integration,
>    testing, etc.)
>  * Tracing
>  * Recap/lightning talks
> 
> Presentations (50 min) can cover recently developed technologies,
> ongoing work and new ideas. Please understand that this workshop is not
> intended for presenting sales and marketing pitches.
> 
> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!).
> 
> Registrations open on February 26th, 2024.
> To register fill in the registration form available at
> https://forms.gle/SooSmYMChBcn5rmM8
> 
> While it is not strictly required to submit a topic/presentation (see
> below), registrations with a topic/presentation proposal will take
> precedence.
> 
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation add its details to this list:
> https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing
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
> Deadline for submitting topics/presentations is 19th of February 2024.
> Notifications for accepted topics/presentations will be sent out 26th of
> February 2024.
> 
> .:: VENUE
> 
> The workshop will take place at IRIT [1], University of Toulouse [2],
> France.
> 
> The workshop venue is accessible [3] from downtown, where you can find
> most of the hotels/accommodations suggested below, by metro (line B) in
> 30 minutes [4]. You can reach IRIT by the metro B (approx one every 2
> minutes in rush hours) or by bus (several lines, between 40 and 60
> minutes depending on the line and the traffic). Several buses arrive at
> the metro station of the university. A map of the city center with the
> venue, transportation and food/drinks places is provided here [5].
> 
> It is recommended to pick a hotel close to a “Ligne B” subway station,
> anywhere between “Jean-Jaures” and “Les Carmes”.
> 
> From the station, choose “Ramonville” direction and get off at the
> station “Université Paul Sabatier” [6]. The station is right inside the
> university. From there follow the map [7] to reach the IRIT building
> entrance. 
> 
> Toulouse airport, “Aéroport Toulouse-Blagnac (TLS), Blagnac”, has a lot
> of direct flights from European airports like Paris, Amsterdam, London,
> Munich among others. There is a shuttle “La Navette” [8], every 20
> minutes, bringing you to downtown in more or less 30 minutes depending
> on the traffic. 
> 
> A list of hotels on the metro line B (direct to the workshop location):
> http://www.hotel-oursblanc.com/
> https://www.athome-ah.com/
> https://www.discoverasr.com/fr/citadines/france/citadines-wilson-toulouse
> https://www.pullman-toulouse-centre-ramblas.fr
> 
> [1] https://www.irit.fr/
> [2] https://www.univ-tlse3.fr/
> [3] https://maps.app.goo.gl/rdcrKx6x8ntm4uij6
> [4] https://maps.app.goo.gl/Y8UPRvHmbrjCSnvu5
> [5] https://www.toulouse-visit.com/interactive-map
> [6] https://metro-toulouse.com/ligne-B-metro-toulouse.php
> [7] https://goo.gl/maps/ojiAeQoL5Ewgb2gp7
> [8] https://www.toulouse.aeroport.fr/en/transports/public-transport?tabs4633=tab_4631
> 
> .:: ORGANIZERS
> 
> Juri Lelli (Red Hat)
> Daniel Bristot de Oliveira (Red Hat)
> Daniel Lezcano(Linaro)
> Georges Da Costa (IRIT)
> Tommaso Cucinotta (SSSA)
> Lorenzo Pieralisi (Linaro)


