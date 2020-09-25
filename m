Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5052278D43
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgIYPyt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 11:54:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45957 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIYPyt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 11:54:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id z26so3220701oih.12;
        Fri, 25 Sep 2020 08:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVNYTU7FFF/E24r0BcwvcVIDxk8lN5sG1MykDbolNLA=;
        b=jYrvVKFQe2qJHA6ItYQIxnOXro2fjGKnPvAwbQ/dOHlc50Elu1ow22dCrNbrQv09c2
         uGh1nI6Fr5tBde1SR2f4ZSygOwhXVxJeXfDF17+BJBxQBzX4x+uiQZ/Z4HAVTjQV+3pp
         7J1cBGpnBHPQhtA+ZS/m4nEEZXw0C6aWfpCAtPPfbaf4wbLk0uWkyfza/X2YHu/oO8MF
         qkZYUoLmjN1CKlOmJvKxQy9l8GM5Zzkl2IL271FdV2mlFIpiwIw7jbqEF7d3q4m98ep4
         Nit2GVVI25Z7vZ7AhHsnBUEDEYH2U0wjTHntGKA9AYfd/sefFaEGD+meevb6RKxdLtFk
         QTIA==
X-Gm-Message-State: AOAM533JO//w6/e7UZ6iBqGEXD8+x1vnQz8Ua/XL1DElQsA68Z5gT1EP
        FubrahGPsllWNq2bma2Q2SHHCKlUBjhwMChwBxI=
X-Google-Smtp-Source: ABdhPJwA87XyLesdGbcVmPTUB0mdllEgSKlEKtHEJMchgrhO/ZZmK2DjFvpSWzdq69C+mYCWdh91vz96JnkaxDsqCe4=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr53765oid.110.1601049288619;
 Fri, 25 Sep 2020 08:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200825135951.53340-1-heikki.krogerus@linux.intel.com> <20200825135951.53340-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20200825135951.53340-2-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 17:54:37 +0200
Message-ID: <CAJZ5v0jT7Xdcm1WVvAV9okkoicnEsFEvnLSLLNx6eJHMNxwX+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] software node: Power management operations for
 software nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 25, 2020 at 3:59 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Adding separate PM operations vector for the software nodes.
> The software node specific PM operations make it possible to
> handle most PM related quirks separately in their own
> functions instead of conditionally in the device driver's
> generic PM functions (and in some cases all over the
> driver). The software node specific PM operations will also
> reduce the need to pass platform data in some cases, for
> example from a core MFD driver to the child device drivers,
> as from now on the core MFD driver will be able to implement
> the PM quirks directly for the child devices without the
> need to touch the drivers of those child devices.
>
> If a software node includes the PM operations, those PM
> operations are always executed separately on top of the
> other PM operations of the device, so the software node will
> never replace any of the "normal" PM operations of the
> device (including the PM domain's operations, class's or
> bus's PM operations, the device drivers own operations, or
> any other).

This isn't consistent with the code changes AFAICS.

The swnode PM operations are implemented as a PM domain ops, which
means that they will be executed instead of any other existing ops
rather than in addition to those.

For example, software_node_prepare() will skip bus type ops if they
are present and there is no "primary" PM domain which seems not
intended.

Also some comments might help to understand the design.

Cheers!
