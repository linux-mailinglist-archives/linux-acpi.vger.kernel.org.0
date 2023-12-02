Return-Path: <linux-acpi+bounces-2090-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4BC801DBA
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 17:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0C0281470
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9E20B3E
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 16:31:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F2129;
	Sat,  2 Dec 2023 06:44:50 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1fb1620a00eso100853fac.1;
        Sat, 02 Dec 2023 06:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701528290; x=1702133090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6sWGUGMGup6OMdqp0W2dtPlrmQ+ed310JeYyFmtHVM=;
        b=FMFI1vo4WK0xAzsZNRajZT5q20oqZ0J9gqi11p5Vd02LwCz1lj4CChWwmocgVTmzUq
         u5wnVBCX7W3PRqSkTP3UNhkggKu4+Ew64c6Iq5wN8RWAzR+YnxFgRQAUqfase87fVRlh
         5QQa7bC9sHujRrsSKc5lF8D2zzFHJV0s5Zc45FqJgeSWrJWrzrv1vRrrYbva9J4WTRWH
         gq8HsDDGxKjRVJfpXKJLe0IaRmC5vVibARLfhRJba2BaRQO5+2Y+YOZ5tStmMg5MLI1P
         zWmkUoKUMcLk9piTHgCFxR9gNvyrg/PoB1QTP1JvSfYvpWXDqEv0LnCSLU6ePeOPiJPv
         03Bw==
X-Gm-Message-State: AOJu0YxtEwHScK0n9rb1dr6trwn2wjNA+lYOl3w40BEmyNiJT7Azoalc
	0Yh67QBnV6HEdkhOAXSACZv73U5YyNfD95sd/N0=
X-Google-Smtp-Source: AGHT+IF1YY0gCQ588kc3Haf8Qdb2gGGwB1Dvj3rr2JK4EqHZOUF7aMm6ILqGW9Jhpv0Xs/OzN+2QydNsfGzUINms9G4=
X-Received: by 2002:a05:6871:e499:b0:1e9:9440:fe4a with SMTP id
 pz25-20020a056871e49900b001e99440fe4amr10010346oac.3.1701528289864; Sat, 02
 Dec 2023 06:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3281896.aeNJFYEL58@kreacher> <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
In-Reply-To: <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 2 Dec 2023 15:44:37 +0100
Message-ID: <CAJZ5v0jeUD4Kt2zR0DPGDnATvfq1wqMv5MX7MifKeKDzSv=AFg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ACPI: OSL: acpi_os_execute() improvements
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 3:31=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> On 11/29/23 14:45, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This series improves acpi_os_execute() on top of
> >
> > https://patchwork.kernel.org/project/linux-acpi/patch/5745568.DvuYhMxLo=
T@kreacher/
> >
> > but only the last patch really depends on it.
> >
> > The first two patches clean up the code somewhat and the third one modi=
fies
> > the function to allow Notify () handlers to run on all CPUs (not on CPU=
0 only).
> >
> > The last patch changes it to use GFP_KERNEL for memory allocations, as =
it does
> > not run in interrupt context any more after the change linked above.
>
> I have added this series, as well as the preceding
> "ACPI: OSL: Use a threaded interrupt handler for SCI"
> patch to my personal tree now, so that it will get tested on various
> devices when I run my personal tree on them.
>
> I'll let you know if I hit any issues caused by this series.

Thank you!

