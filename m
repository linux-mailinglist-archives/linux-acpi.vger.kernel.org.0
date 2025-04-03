Return-Path: <linux-acpi+bounces-12675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBCFA7A159
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 12:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C981759E6
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830E824BBE8;
	Thu,  3 Apr 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMKtZdyJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40724A07E
	for <linux-acpi@vger.kernel.org>; Thu,  3 Apr 2025 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677349; cv=none; b=XOt0T3fCnkEyATrjYnYbqXshK1ER9y2+aJ3jALRyVcSAHJ6EaLQcH3HeK/Uov7O3hM4AxwkO2RLUOt6YMb9BCXXAyq6sP0GdqxPjRfAwzRuASSPkiC8z7RZpktlbaXK9kW1qJwzndNtkcYEA2SL76iSLX+IbjgIBOf//rJFUcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677349; c=relaxed/simple;
	bh=TTun2fI+wjPp/f5wThcc4U4+DSqWm8djxZ/J+Ds9fZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw1BSbqqLKL03dqIpTBANiB48yK3jSLOjARbylzWXiSX023r0mUNs5QwyjXMhB2MMD5IIai3wTjtEWfuoAMyCne151vpdHm/QjbYfslxiGUpfPEF1Q9yDITbwKDLxMM19tEWM+8dwSjPEZ34hItGfMpkayHkXbXzvHdvImhoih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMKtZdyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2E4C4CEE7
	for <linux-acpi@vger.kernel.org>; Thu,  3 Apr 2025 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743677348;
	bh=TTun2fI+wjPp/f5wThcc4U4+DSqWm8djxZ/J+Ds9fZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NMKtZdyJrL8Put3lIEW5riJwCw06ARxrk2FOHeTfHsyZown6icg8UeRDXhhoXedlD
	 GMmaFe7L0pOnwsA1kGkzXUqXw52VvTIQL9ZQq4V6+aO2KqrzNsN1FtRkOlqIbN2rp1
	 f0+xQ/3vkXmioExAHuNN44npi4a34pZMpUBdsGJxXIwYn8IyGumgUo0Hp/8lKjtSMj
	 dLXtfZae+/tZ0NZLGvbSzgHbYKnjPF5f+vj5XNuRlevBalRxg1VE5IZtt/6rj8svKb
	 Op6Y/gumbrYmp0HWGpJgjJC/Av4n7UqOH2+iMOEamWRC1gey3yPXgFXToXxBP7+Gm/
	 mDyRYp51Kl3bA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso426772fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Apr 2025 03:49:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzc5vuvNficZmbhTYtC/LNcqA0qQYjQMoGf5Mdc5Sli0DdtQaVQ
	gwQJDLaOlHwvjCFr7/cgzTivjzT42J5BkuqV5ZNQPr9szN0y8fhD6QcCPlZNBsvH1TU/cMxYg39
	YBnhh5SYgaw2VYYjXF2d5RdZCKRA=
X-Google-Smtp-Source: AGHT+IHIyPEm7yReliRi/GAllmuF9B/3iuT7gwoOQaebvrKhTtwlG4UjSnVRYBqwhYe1ekseMsek0YBveJcFNx9dqFA=
X-Received: by 2002:a05:6871:36c3:b0:2c8:33ab:e80e with SMTP id
 586e51a60fabf-2cbcf5acda8mr11439667fac.19.1743677348110; Thu, 03 Apr 2025
 03:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <548ec422-e504-4171-8780-cbd83f877b3e@mail.com>
In-Reply-To: <548ec422-e504-4171-8780-cbd83f877b3e@mail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 12:48:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hbA6bqxHupTh4NZR-GVSb9M5RL7JSb2yQgvYYJg+z2aQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqxraZCfxx8BCMoe1ujJ2sOLVwprigCeww7Iu6Rhht1AwAeTKjML9VgI94
Message-ID: <CAJZ5v0hbA6bqxHupTh4NZR-GVSb9M5RL7JSb2yQgvYYJg+z2aQ@mail.gmail.com>
Subject: Re: kernel-6.15 randomly shutting down system on bogus power button events
To: Ian Laurie <nixuser@mail.com>
Cc: linux-acpi@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 1:30=E2=80=AFAM Ian Laurie <nixuser@mail.com> wrote:
>
> I am seeing an issue where (in Fedora Rawhide) the following kernels:
>
> kernel-6.15.0-0.rc0.20250327git1a9239bb4253.5.fc43.x86_64
> kernel-6.15.0-0.rc0.20250401git08733088b566.8.fc43.x86_64
>
> are randomly shutting the system down because bogus power button events
> are being received every 10 minutes to about 2 hours.  My actual power
> button generates an event2, while the bogus events are arriving as event1=
.
>
> Latest available 6.14 kernel:
>
> kernel-6.14.0-0.rc7.20250321gitb3ee1e460951.60.fc43.x86_64
>
> does not suffer from this issue.
>
> Using 'sudo evtest --grab /dev/input/event1' I am able to prevent the
> system from shutting down and also record the bogus events.
>
> The RedHat Bugzilla entry has more details and also links to a thread on
> the Fedora test mailing list:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2357044

I would try to revert the following commit and see if that helps:

commit a7e23ec17feecc7bac0d500cea900cace7b50129
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Mon Mar 3 15:27:09 2025 -0600

   ACPI: button: Install notifier for system events as well

   On some systems when the system is put to sleep pressing the ACPI power
   button will cause the EC SCI to try to wake the system by a Notify(DEV, =
0x2)
   with an intention to wake the system up from suspend.

   This behavior matches the ACPI specification in ACPI 6.4 section
   4.8.3.1.1.2 which describes that the AML handler would generate a Notify=
()
   with a code of 0x2 to indicate it was responsible for waking the system.

   This currently doesn't work because acpi_button_add() only configured
   `ACPI_DEVICE_NOTIFY` which means that device handler notifications
   0x80 through 0xFF are handled.

   To fix the wakeups on such systems, adjust the ACPI button handler to
   use `ACPI_ALL_NOTIFY` which will handle all events 0x00 through 0x7F.

