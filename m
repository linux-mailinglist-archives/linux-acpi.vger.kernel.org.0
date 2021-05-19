Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA5389104
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhESOfK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:35:10 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45881 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhESOfK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2021 10:35:10 -0400
Received: by mail-ot1-f45.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so11904780otc.12
        for <linux-acpi@vger.kernel.org>; Wed, 19 May 2021 07:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7maD6EKPyek/yOnsaJmrwly5GQR//pTUcwCivgUMIQ=;
        b=QLQrnnKb1t32qAO2/KRAcloW+XgFhl8Z1HNZDABvXa1dtI6eE/S8fffWgKpx+50GL1
         JNna1FcX2VX3qSLuYMEND2TnsQ+5f8iQ+B1VigW0VECSQ/gEsCzzG3lMTXhP2Bc28IZF
         u7pxJaLxgAWaIWy2PcUsThz3OcwEMvTARLZxt9YZraEyhgUGymSaqHK7cpXTu1AnMC4u
         ZfmlZnbfsRDRUs97jE5nOdFi811l0js8bxZ5Tjz+xchrNKva1t5k5zSf+UOQxJIZObS1
         KatyQoIdgGPxImC6244jLsXThlb8+I/JquxwheT2fCJzxrvpY8hwH/W9KxZ1LylwtSYN
         A2AA==
X-Gm-Message-State: AOAM531dvkuOyE7aWIWuntOWU6nOutQABwrUNbbIg/KMuIVywQUN4uVs
        /S2cG1vhEMEoeCMM0Qax6UBKtVoLZqujHWn5z0M=
X-Google-Smtp-Source: ABdhPJx9QtvO477TfmyVnrHfCQzEPJj9HYQXKTfV1+Zu18BVVY59kNouQ3ahVnEpgan9HYspclCjP+0kBfL+dkqaGCE=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr3699138otq.260.1621434829298;
 Wed, 19 May 2021 07:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j90nrRG0wP3ARzjgMw8E=VZPQSX7d+SP6K-0oV0vT50w@mail.gmail.com>
In-Reply-To: <CAJZ5v0j90nrRG0wP3ARzjgMw8E=VZPQSX7d+SP6K-0oV0vT50w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 May 2021 16:33:38 +0200
Message-ID: <CAJZ5v0gwDEjC9T7wfCqDr7R0q_ptz2nVU52_8i8noXHPEign1g@mail.gmail.com>
Subject: Re: [RFC] ACPI Code First ECR: _DSC (Deepest State for Configuration)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 22, 2021 at 8:23 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On some systems there are devices that should better be left in their
> current power state before attempting to bind drivers to them in order
> to avoid some undesirable side effects of turning the power on (e.g.
> blinking a privacy LED of a camera that may confuse the user to
> believe that the camera sensor is in use while in fact the camera is
> only being probed by a driver).
>
> To support this use case, define a new device PM object called _DSC
> (Deepest State for Configuration) returning the deepest D-state the
> device can be in before evaluating its _CRS, _PRS and _SRS configuration
> objects.
>
> # Title: Introduce _DSC (Deepest State for Configuration)
>
> # Status: Draft
>
> # Document: ACPI Specification 6.4
>
> # License
> SPDX-License Identifier: CC-BY-4.0
>
> # Submitter:
> * Sponsor: Rafael J. Wysocki, Intel
> * Creators/Contributors:
>     * Rafael J. Wysocki, Intel
>     * Sakari Ailus, Intel
>
> # Summary of the Change
> Introduce a new device PM object called _DSC (Deepest State for Configuration)
> returning the deepest D-state the device can be in before evaluating its _CRS,
> _PRS and _SRS configuration objects.
>
> # Benefits of the Change
> It will allow OSPMs to avoid putting devices into D0 in order to check and set
> their resources if _DSC is present and its return value is greater than 0.  In
> particular, if _DSC returns 4 (assuming that _PR3 is present for the given
> device), the device can remain in D3cold during driver probe and the driver
> should be able to gather all of the information needed by it to operate the
> device without changing its power state.
>
> # Impact of the Change
> Enable certain device power management optimizations.
>
> # References
> Support running driver's probe for a device powered off
> <https://lore.kernel.org/linux-acpi/20210210230800.30291-1-sakari.ailus@linux.intel.com/T/#m24e9f51119cbe6eb39f31c097ea3941d00a0baeb>
>
> # Detailed Description of the Change
>
> * Add a new row to Table 7.3 Device Power Management Child Objects:
>
> > _DSC    Object that evaluates to the device's deepest power state for configuration.
>
> * Add new Section 7.3.27:
>
> > 7.3.27. _DSC (Deepest State for Configuration)
> >
> >This optional object evaluates to an integer that conveys to OSPM the deepest
> >D-state the device can be in before evaluating the \_CRS, \_PRS and \_SRS
> >configuration objects for it.
> >
> >If \_DSC is present and the current power state of the device is not deeper
> >than the one represented by its return value, the device's \_CRS, \_PRS (if
> >present) and \_SRS (if present) configuration objects (see :ref:`device-configuration-objects`)
> >can be safely evaluated without putting the device into D0.
> >
> >Therefore, when present, the \_DSC object allows the OSPM to optimize device
> >power management by avoiding an unnecessary change to device power state that
> >would be otherwise made before evaluating configuration objects for the device.
> >
> >**Arguments:**
> >
> >  None
> >
> >**Return Value:**
> >
> >  An Integer representing the deepest D-state the device can be in during
> >  configuration. If OSPM has not indicated that it supports \_PR3 through the OSPM
> >  Platform-Wide Capabilities (see :ref:`platform-wide-ospm-capabilities`), then
> >  the value "3" corresponds to D3. If it has indicated \_PR3 support, the value
> >  "3" represents D3hot and the value "4" represents D3cold.
> >
> >  The \_DSC return value must represent a D-state that is supported by the
> >  device.  In particular, "4" (D3cold) can be returned only if \_PR3 is present.
> >
> >  \_DSC must return the same integer each time it is evaluated.
> >
> >  The \_DSC return value must not represent a D-state shallower then the one
> >  resulting from turning ON all of the power resources listed by \_PRE (if
> >  present) and evaluating \_PSE (if present).

This ECR has been approved as submitted.
