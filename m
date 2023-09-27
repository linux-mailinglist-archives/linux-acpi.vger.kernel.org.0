Return-Path: <linux-acpi+bounces-222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432E87B0A2C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E70172814C7
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084A3C692
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E336FA2
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:28:05 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E505180;
	Wed, 27 Sep 2023 08:28:04 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57b68555467so864268eaf.0;
        Wed, 27 Sep 2023 08:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695828484; x=1696433284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrJ+LVorbFBvQ25l422kAsahBWNHUUbzw/OsuBiPPcI=;
        b=DpnztN081es8uFyzNAZxFKc4eslq+E2tgRNYc546DehO93GSqGMH98Ml6vmVPNmow/
         InGv7s6gwNI360JcfBs+kZKZD6qNuGgGocK3veFQLhzNTizv5JLQnSJVZuk2D4MQQ5vy
         C6z/M4tBf7lCW5K/d6AwuTiyP9QneTXFWisKKhrTY0sC3OdyxpVn3O+fkZfEwqbqT7Ka
         y+CiEBUh71Z+DSrtp/JpsKLedq5tUxcPabEHdzBjyVwd6CwRdbr6w5ai+6vtkcFoVvjw
         it4WGvkbeRFpxEt8gFUnDlwwa5Wwm2UY+e6ziaZxL0I39Sw6tGfUvTXEU0KD6rwUif7Y
         jMYA==
X-Gm-Message-State: AOJu0YySl6GenFN4twSO6h8xjRc/woBphgvuiqS+Ca9BbNT31t6mUSR9
	WfL5ZTEPulg6HEU3LpXjw3OAgvl5trxSrLlB4RI=
X-Google-Smtp-Source: AGHT+IHsKKKybxNHeGTXA++HPKol4GYH13nBVus5vxuKblbsNJopgKj6YjMp+qwFLepHAXHcKGquT1Nw2rA3z57mc0o=
X-Received: by 2002:a4a:e687:0:b0:57b:3b64:7ea5 with SMTP id
 u7-20020a4ae687000000b0057b3b647ea5mr2619493oot.1.1695828483804; Wed, 27 Sep
 2023 08:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1957441.PYKUYFuaPT@kreacher> <2590280.Lt9SDvczpP@kreacher> <9f1374db-f866-ff52-e86c-99fecee24d1b@linaro.org>
In-Reply-To: <9f1374db-f866-ff52-e86c-99fecee24d1b@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Sep 2023 17:27:52 +0200
Message-ID: <CAJZ5v0hw3LGByW=18tiFEB7JQ9rOVo6TqCGhzxWcrUQYb+VGEw@mail.gmail.com>
Subject: Re: [PATCH v1 07/13] thermal: gov_power_allocator: Use trip pointers
 instead of trip indices
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 5:10=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/09/2023 19:55, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Eliminate the __thermal_zone_get_trip() usage that adds unnecessary
> > overhead (due to pointless bounds checking and copying of trip point
> > data) from the power allocator thermal governor and generally make it
> > use trip pointers instead of trip indices where applicable.
>
> Actually the __thermal_zone_get_trip() change was done on purpose to
> replace the 'throttle' callback index parameter by the trip pointer and
> removing those call to __thermal_zone_get_trip() while the code was
> using the trip pointer.
>
> IMO, the changes should focus on changing the trip_index parameter by
> the trip pointer directly in the throttle ops.

So you would like .throttle() to take a trip pointer argument instead
of an index?

The difficulty here is that the user space governor needs to expose
the index to user space anyway, so it would need to find it if it gets
a trip pointer instead.

Not a big deal I suppose, but a bit of extra overhead.

Also it is easier to switch the governors over to using trip pointers
internally and then change the .throttle() argument on top of that.

> The pointer can be
> retrieved in the handle_thermal_trip() function and passed around for
> the rest of the actions on this trip point

Right, except for the user space governor which needs a trip index.
And the indices are used for tracing too.

