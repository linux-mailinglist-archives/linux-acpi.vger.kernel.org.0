Return-Path: <linux-acpi+bounces-10174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F99F49C1
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 12:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95EA1888F19
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FB1EE017;
	Tue, 17 Dec 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oexw4MWr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411CB1E6DDD
	for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434602; cv=none; b=mOh1QAvP5cLH0FtXILjKo56vaK/UN7QU7cdOkKuzdguRq+eOhcRaaSjnJK6AFXJ4cs5GExsjTHWHDkMGtp1KTFqKGzhmABCZDrtPp48qNdizHP6aF9BA5h2jHUSz9ZDEo1aQOWNnoatbJka/H/nPVCObtL4zyYSWY60tziFIgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434602; c=relaxed/simple;
	bh=RmSIt/3Ns4FBCqw8NFpzWMRkTFrQMhrc2MyPlmAiKwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOmzhlyMMAgWNpd10psbKxV4lkIOasP9zuh6+m8EyxTPa4m4uvIiKaRzF6y4zGraX3AvIkDOFDJZW19R2wjcmp/2WvdhWIBxzANaqCnRSgoMlSie2C3tGE1oCvrZCmjPLtjETdkn69qsHtGRWro2pbUWTbczF1ORqdf/IR6j5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oexw4MWr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734434599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxFk4ZzElKHondedZg8yku+jbtm7e4uZWvmWgn/Up8c=;
	b=Oexw4MWrnwSUbWnvZtCoBmeQFhE8Wkv5PiMejWjCK+gcdh0Np34qbRq3z43i7PY/ISOTZ+
	WJxZpOkypHa2bQMfwy305R2JpBOMaiL1iNGN47jBk4HxExZ4+fs3LqoNaecZlSBTgT8J/8
	+kvvnsruzrtuVBGvTpRDpH1E3UVtfuw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-uV6VjghuOmSjfXDePoRgtw-1; Tue, 17 Dec 2024 06:23:17 -0500
X-MC-Unique: uV6VjghuOmSjfXDePoRgtw-1
X-Mimecast-MFC-AGG-ID: uV6VjghuOmSjfXDePoRgtw
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467a409b8ddso82437161cf.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2024 03:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434597; x=1735039397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxFk4ZzElKHondedZg8yku+jbtm7e4uZWvmWgn/Up8c=;
        b=SFLYyFxq8/tdA9Uq7VsAx26dbyA2J6d9gVmu8Gn8tk9bHmC+vJsSJcI4pkIlOMYXRC
         Ahu5EFSsNCFXmw6+9BvT37MtfnON+vmz0di4h55KxY9TODxNcgycfzWNqfJ1boM+IAUu
         C9n4ZiyVXJlQOK6HK3G78Mhfn2DvQDcxj6X0MzxR1SR+AypGr1HYcJNsF0PnHiFkFZq/
         q1FN5anKUIyt7PTe0Rl9VtqGmcsDIB2J3t5fgHFt2V9sXN179Y8rxB+QXez+K+J8EtOm
         uc9EDwloyHBa3TsAJmU/X3ln8H4yB3zhVrEs4JUjiTjsI0vZBPOrDU0TM6sfWaLjsxok
         dnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDk7Cg3rsjX6UR+Stktlgdrgt/X30INlkK2mAApxp4IEK5O39Y0K9RPSK3JuoIsFmcbC8q008gfZO2@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCdflgJqn6WwyYbB3Olo/WfT4Zdsjqx2hfM2q2BH8p/zQTCCK
	PCtPKQNB4Z0PjjJKxS7HEQQxH787/KApTi1ppDO7+m4hLYcaHSONKoHdVB6W/peueg6716ZT6aU
	eYLRADpYgz6zVStd4qHecDsk/FTn2PZ/RgqD3O8b0qC7lWDBjOgfobH3yHSE=
X-Gm-Gg: ASbGncvDSdtmr2WlujMfYcB31V2cf46urXhraNAhhS5JXY2A3nJ/IoQZMUX6ThzkJXB
	k06GhZ2iAN1UNxKbi123AOe7oqk0/+Uauz4d1jTOYqnQ7vyl3To07DD7il9TPReqFa1QZcIgyaC
	f8CMlsBTuWgfH6WpXdlqhJ26BO4UgzzfOp5ATIkUVGiIypqxaprp9YaRxX2YcyJJeMfFVn/BUVO
	0DgiZwEdXMUdglA4bc6dx+GJ3QML+ST4H1dSITAdKLUdwVFNVQXmYcbEDNFpMnFJh79a6/3mkVb
	KEBbiPKLdbrHGQKuqOY8gedTP1WbsjIRoNTyVa6AonE=
X-Received: by 2002:ac8:7c49:0:b0:467:603d:1cd5 with SMTP id d75a77b69052e-468f8dd49eamr46825261cf.26.1734434597070;
        Tue, 17 Dec 2024 03:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDlnfHsZwL618rCmU7oi6Y1uHEhl66Xxg1NEAZrBlzi7MfB/k934xEyHJarN/SUCDyDssw+A==
X-Received: by 2002:ac8:7c49:0:b0:467:603d:1cd5 with SMTP id d75a77b69052e-468f8dd49eamr46824991cf.26.1734434596710;
        Tue, 17 Dec 2024 03:23:16 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-40-237-196.as13285.net. [80.40.237.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2c72fa9sm37976241cf.12.2024.12.17.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:23:15 -0800 (PST)
Date: Tue, 17 Dec 2024 11:23:11 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Frauke =?iso-8859-1?Q?J=E4ger?= <frauke@linutronix.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Registration open for OSPM-summit 2025
Message-ID: <Z2FfH3JK7yMt20Td@jlelli-thinkpadt14gen4.remote.csb>
References: <ZytlAkTiuZApK23Y@jlelli-thinkpadt14gen4.remote.csb>
 <Z02EBA_0SwWPhTAi@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z02EBA_0SwWPhTAi@jlelli-thinkpadt14gen4.remote.csb>

Hello,

Last reminder for this edition, promise.

Registration is now open!

Please use the following form to register

https://forms.gle/Yvk7aS79pvNR6hbv8

Please share the word and see you soon!

Best,
Juri

On 02/12/24 10:55, Juri Lelli wrote:
> Hello Everybody,
> 
> Quick reminder that deadline for topics submission is approaching
> (December 9, 2024 - next Monday).
> 
> Please use the form to submit your topic(s) or reply to me privately
> with topic's details.
> 
> https://forms.gle/Vbvpxsh8pqBffx8b6
> 
> Don't wait until last minute or Santa will add you to the naughty list!
> 
> Best,
> Juri
> 
> On 06/11/24 13:45, Juri Lelli wrote:
> > Power Management and Scheduling in the Linux Kernel (OSPM-summit) VII edition
> > 
> > March 18-20, 2025
> > Alte Fabrik
> > Uhldingen-Mühlhofen, Germany
> > 
> > ---
> > 
> > .:: FOCUS
> > 
> > OSPM is moving to Germany!
> > 
> > The VII edition of the Power Management and Scheduling in the Linux
> > Kernel (OSPM) summit aims at fostering discussions on power management
> > and (real-time) scheduling techniques. Summit will be held in Uhldingen
> > (Germany) on March 18-20, 2025.
> > 
> > We welcome anybody interested in having discussions on the broad scope
> > of scheduler techniques for reducing energy consumption while meeting
> > performance and latency requirements, real-time systems, real-time and
> > non-real-time scheduling, tooling, debugging and tracing.
> > 
> > Feel free to take a look at what happened previous years:
> > 
> >  I   edition - https://lwn.net/Articles/721573/
> >  II  edition - https://lwn.net/Articles/754923/
> >  III edition - https://lwn.net/Articles/793281/
> >  IV  edition - https://lwn.net/Articles/820337/ (online)
> >  V   edition - https://lwn.net/Articles/934142/
> >                https://lwn.net/Articles/934459/
> >                https://lwn.net/Articles/935180/
> >  VI  edition - https://lwn.net/Articles/981371/
> > 
> > .:: FORMAT
> > 
> > The summit is organized to cover three days of discussions and talks.
> > 
> > The list of topics of interest includes (but it is not limited to):
> > 
> >  * Power management techniques
> >  * Scheduling techniques (real-time and non real-time)
> >  * Energy consumption and CPU capacity aware scheduling
> >  * Real-time virtualization
> >  * Mobile/Server power management real-world use cases (successes and
> >    failures)
> >  * Power management and scheduling tooling (configuration, integration,
> >    testing, etc.)
> >  * Tracing
> >  * Recap/lightning talks
> > 
> > Presentations (50 min) can cover recently developed technologies,
> > ongoing work and new ideas. Please understand that this workshop is not
> > intended for presenting sales and marketing pitches.
> > 
> > .:: SUBMIT A TOPIC/PRESENTATION
> > 
> > To submit a topic/presentation use the form available at
> > https://forms.gle/Vbvpxsh8pqBffx8b6.
> > 
> > Or, if you prefer, simply reply (only to me, please :) to this email
> > specifying:
> > 
> > - name/surname
> > - affiliation
> > - short bio
> > - email address
> > - title
> > - abstract
> > 
> > Deadline for submitting topics/presentations is December 9, 2024.
> > Notifications for accepted topics/presentations will be sent out
> > December 16, 2024.
> > 
> > .:: ATTENDING
> > 
> > Attending the OSPM-summit is free of charge, but registration to the
> > event is mandatory. The event can allow a maximum of 50 people (so, be
> > sure to register early!).
> > 
> > Registrations open on December 16, 2024.
> > To register fill in the registration form available at
> > https://forms.gle/Yvk7aS79pvNR6hbv8.
> > 
> > While it is not strictly required to submit a topic/presentation,
> > registrations with a topic/presentation proposal will take precedence.
> > 
> > .:: VENUE
> > 
> > The conference will take place at Alte Fabrik [1], Daisendorfer Str. 4,
> > 88689 Uhldingen-Mühlhofen, Germany
> > 
> > The conference venue is located in a 2 minute walking distance [2] to
> > the Hotel Sternen [3] that has been pre-reserved for the participants.
> > Since it is a very rural area, we recommend booking this hotel as it is
> > close to the conference room. The price ranges per night incl. breakfast
> > between 85€ (Standard Single Room) up to 149€ (Junior Suite). There is
> > an availability of 37 rooms in the hotel. Another 13 rooms are
> > pre-reserved in the Hotel Kreuz which is also a 5min walking distance to
> > the conference location [4]. Cost is 75€ inkl. breakfast. Please choose
> > your hotel (and room) and arrange booking yourself. We recommend arrival
> > on March 17 and departure on March 21 due to the length of the trip.
> > 
> > Please use the code ‘LINUTRONIX’ when booking your hotel room. 
> > Deadline for hotel booking in Hotel Sternen is February 28, 2025.
> > Deadline for hotel booking in Hotel Kreuz is January 17, 2025.  
> > After these dates, cancellations are not free of charge anymore.
> > 
> > You can reach Uhldingen-Mühlhofen best from Zürich Airport [5] or
> > Friedrichshafen Airport [6]. From both airports there are train and/or
> > bus connections to Uhldingen-Mühlhofen which you can check here [7]. The
> > rides are quite long, so another possibility is to organize yourself in
> > groups and share a taxi/shuttle [8].
> > 
> > [1] https://www.fabrik-muehlhofen.de/
> > [2] https://maps.app.goo.gl/S6cnTgx1KJAGRkMr7
> > [3] https://www.steAlte Fabrik Mühlhofenrnen-muehlhofen.de/
> > [4] https://www.bodensee-hotel-kreuz.de/
> > [5] https://www.flughafen-zuerich.ch/de/passagiere/praktisches/parking-und-transport/zug-tram-und-bus
> > [6] https://www.bodensee-airport.eu/passagiere-besucher/anreise-parken-uebernachten/
> > [7] https://www.bahn.de/
> > [8] https://airporttaxi24.ch/?gad_source=1&gclid=EAIaIQobChMIo_y9l56iiQMVfp6DBx16NxPtEAAYAiAAEgJOO_D_BwE
> > 
> > .:: ORGANIZERS
> > 
> > Juri Lelli (Red Hat)
> > Frauke Jäger (Linutronix)
> > Tommaso Cucinotta (SSSA)
> > Lorenzo Pieralisi (Linaro)


