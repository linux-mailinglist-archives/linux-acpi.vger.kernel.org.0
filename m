Return-Path: <linux-acpi+bounces-9868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C89DFDD9
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 10:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B58B220E2
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8121FBE91;
	Mon,  2 Dec 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcHgQhy4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27121FBCB1
	for <linux-acpi@vger.kernel.org>; Mon,  2 Dec 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133324; cv=none; b=tKuGEn+BJH1iXW8ZXlGfTa1HgdE7KRcyVogaiZcY3eGSLrzNixfnDR0ph9ejSi6U42g3OOXx5qrMxcbgnKVP2j3wZzJUiPJgIh4qc/9XSkDaeMf1807K5P5/9kzdsjY91nj+Q7KDQR+oM7IOHfFauicrRz00V/WwT/Ez68YXvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133324; c=relaxed/simple;
	bh=giKLGGK03twsti8r6koMTfcd/cXGRA56MS0yGykpzlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8JXjJuqdpsZVNcl2XyYDE35TJC+atfsVxCGfmXtBKa6bCO1Hh2kpLH5LVUoA21fVfO4paGZvRmgB0Y+DGiR4iV9TXVchcuyMlnTXc9woZCKKQkqSRqBTAaP6+uo4pz2AtiknDaIQNeOkd6mItzn/JL0lAjIKmvOnX5JVJLa2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcHgQhy4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733133322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09MvrDFOXfmr7yZyk+mt+cZonVT5Z8HMfNE6DtwKO3c=;
	b=bcHgQhy4kM+tYLLK6+zEvLkK5DT0JIW0pbZ3AVd/6HTeu6bScttzHqdWq3qnNgiGcTWtpE
	vLpJdJgEQ2Bp4Z+0ZXkhsiQoDopsSz0p1WwlYOcihaKFKJ/V40xCza/dlVehqGlX8yA5o9
	u1LMvpCxungmnK+xIuDPmgdhX19qzZY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-ilk0akWFNsiKpAWpmDeyhw-1; Mon, 02 Dec 2024 04:55:20 -0500
X-MC-Unique: ilk0akWFNsiKpAWpmDeyhw-1
X-Mimecast-MFC-AGG-ID: ilk0akWFNsiKpAWpmDeyhw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a90fecfeso29904415e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 02 Dec 2024 01:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133319; x=1733738119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09MvrDFOXfmr7yZyk+mt+cZonVT5Z8HMfNE6DtwKO3c=;
        b=kp2QYxZmOY0KkkqlLwC79Z7ilKfnvOB7lG/EzvvrC3fP4CvEoJ5PsmcxbbgFqo2xya
         BdIwdCBT96yweb9E8gg1xBx3s4B4cbIp456B65ceIisd7rULjEOGJMirpjlq9zADDBGK
         4mASluK0F4rBXIwVTDSo4noYajoB4H159hxse2M/otqEV2kxX2S6n80emFNHyapCqVm4
         Y13QYO94N5Bwc6mTshWyYGTBL+ba6t/Hg0z9gLZnunCLm46wfdlCC8xAYRBLkn3SgnZN
         XM5e+Zc3FIy7+OJa6nm/mbJOtuYtU1zN7zNZJ1pzjLcTRDNartAg5Ee3kWI1pUia61Jw
         9Hbg==
X-Forwarded-Encrypted: i=1; AJvYcCWV0jy4yGmV8ALYGwLdLccVIB38fx2ok7XBsebnJpc80dLnf0+5dlVK6zLcD/fJ/IJBstfq9TKKCZci@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYfa5Ahm+H2370TN7tDyszZ4dlA1YInV8pTCs1CZSUnyqtfaG
	uW9R7a3Nf81EA2+xwoDl5FY5T7QjbNmCqkL7O3/JyvulPh+s0F4aU2KEpxg0UbhwaCiwpaPqjIC
	hkEX2J+FOSv/NOolOiWm5QuRO8v5pc5gEqYdAViQiBpLP4tjdLUmdukd90u8=
X-Gm-Gg: ASbGncu+PFSn3Rqn8qE5uMCtFvA8EYNFU9CCbt8VnLOtNhOxHVUOswmy/XKN+o+stg0
	3w566Wx0lAC4I4edeIh2nzA3ribaYa3y7VndwCMzJHfrmSbIc8NoiIswhfMYugsvXHbW6ySGq23
	M3lSJ3+6nbqJFjY9/bV/Bo7Tz+FMCK+VcwDq8mwyY3lycATh5bhjkwZLaDw6FNSe0f4I1lw7dp0
	rwWyA4t88tM8y+alLgugTmxU8PXFLFPPHVcj/zcaEAS8kJLnVJ9MxJcWp9ndsUUXClq4y5cOjvY
	bCs=
X-Received: by 2002:a05:600c:1c09:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-434a9de8cc2mr172537475e9.23.1733133319111;
        Mon, 02 Dec 2024 01:55:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdrZW7CnHqIPba+h3rdUQEPKdX49BX6A51BtPfyAqpRIpHzFbEJP1x+SVenKFW+la85OBsJA==
X-Received: by 2002:a05:600c:1c09:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-434a9de8cc2mr172537265e9.23.1733133318732;
        Mon, 02 Dec 2024 01:55:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.75.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm144865155e9.15.2024.12.02.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:55:17 -0800 (PST)
Date: Mon, 2 Dec 2024 10:55:16 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Frauke =?iso-8859-1?Q?J=E4ger?= <frauke@linutronix.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VII edition (OSPM-summit 2025)
Message-ID: <Z02EBA_0SwWPhTAi@jlelli-thinkpadt14gen4.remote.csb>
References: <ZytlAkTiuZApK23Y@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZytlAkTiuZApK23Y@jlelli-thinkpadt14gen4.remote.csb>

Hello Everybody,

Quick reminder that deadline for topics submission is approaching
(December 9, 2024 - next Monday).

Please use the form to submit your topic(s) or reply to me privately
with topic's details.

https://forms.gle/Vbvpxsh8pqBffx8b6

Don't wait until last minute or Santa will add you to the naughty list!

Best,
Juri

On 06/11/24 13:45, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VII edition
> 
> March 18-20, 2025
> Alte Fabrik
> Uhldingen-Mühlhofen, Germany
> 
> ---
> 
> .:: FOCUS
> 
> OSPM is moving to Germany!
> 
> The VII edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Uhldingen
> (Germany) on March 18-20, 2025.
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
>  VI  edition - https://lwn.net/Articles/981371/
> 
> .:: FORMAT
> 
> The summit is organized to cover three days of discussions and talks.
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
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation use the form available at
> https://forms.gle/Vbvpxsh8pqBffx8b6.
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
> Deadline for submitting topics/presentations is December 9, 2024.
> Notifications for accepted topics/presentations will be sent out
> December 16, 2024.
> 
> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!).
> 
> Registrations open on December 16, 2024.
> To register fill in the registration form available at
> https://forms.gle/Yvk7aS79pvNR6hbv8.
> 
> While it is not strictly required to submit a topic/presentation,
> registrations with a topic/presentation proposal will take precedence.
> 
> .:: VENUE
> 
> The conference will take place at Alte Fabrik [1], Daisendorfer Str. 4,
> 88689 Uhldingen-Mühlhofen, Germany
> 
> The conference venue is located in a 2 minute walking distance [2] to
> the Hotel Sternen [3] that has been pre-reserved for the participants.
> Since it is a very rural area, we recommend booking this hotel as it is
> close to the conference room. The price ranges per night incl. breakfast
> between 85€ (Standard Single Room) up to 149€ (Junior Suite). There is
> an availability of 37 rooms in the hotel. Another 13 rooms are
> pre-reserved in the Hotel Kreuz which is also a 5min walking distance to
> the conference location [4]. Cost is 75€ inkl. breakfast. Please choose
> your hotel (and room) and arrange booking yourself. We recommend arrival
> on March 17 and departure on March 21 due to the length of the trip.
> 
> Please use the code ‘LINUTRONIX’ when booking your hotel room. 
> Deadline for hotel booking in Hotel Sternen is February 28, 2025.
> Deadline for hotel booking in Hotel Kreuz is January 17, 2025.  
> After these dates, cancellations are not free of charge anymore.
> 
> You can reach Uhldingen-Mühlhofen best from Zürich Airport [5] or
> Friedrichshafen Airport [6]. From both airports there are train and/or
> bus connections to Uhldingen-Mühlhofen which you can check here [7]. The
> rides are quite long, so another possibility is to organize yourself in
> groups and share a taxi/shuttle [8].
> 
> [1] https://www.fabrik-muehlhofen.de/
> [2] https://maps.app.goo.gl/S6cnTgx1KJAGRkMr7
> [3] https://www.steAlte Fabrik Mühlhofenrnen-muehlhofen.de/
> [4] https://www.bodensee-hotel-kreuz.de/
> [5] https://www.flughafen-zuerich.ch/de/passagiere/praktisches/parking-und-transport/zug-tram-und-bus
> [6] https://www.bodensee-airport.eu/passagiere-besucher/anreise-parken-uebernachten/
> [7] https://www.bahn.de/
> [8] https://airporttaxi24.ch/?gad_source=1&gclid=EAIaIQobChMIo_y9l56iiQMVfp6DBx16NxPtEAAYAiAAEgJOO_D_BwE
> 
> .:: ORGANIZERS
> 
> Juri Lelli (Red Hat)
> Frauke Jäger (Linutronix)
> Tommaso Cucinotta (SSSA)
> Lorenzo Pieralisi (Linaro)


