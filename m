Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3072B7112
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 22:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgKQVpd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 16:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgKQVpc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 16:45:32 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90863C0613CF
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2020 13:45:32 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id y4so18260518edy.5
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2020 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lBVBDWK8SCqKzaHy0L/+mLoij0OAwknWiLnXgPeJSM=;
        b=FBb5z0wFGOiQbc45dE0niLuV0rybunP/wEU/0k6b783EPVbzDuRuejCVpDauBALHfc
         +lc+d6XRbgwNlOlzPZ80uZOVCFXlW1F2ThVz/PgWXDMr5Qk2qXUzVeV/mkMEpA6NGBWJ
         /r6IhOXal5Ashs5MZqCi+/Cclekpk1N7Hu9Viof3LXHIYVpqGBDN2fBwVFtEcO1Bg3xL
         tzN0ffs5tPZJKxTNR/PuvOabZJbNfgH+ytvBghZkwTb90HvxcpdUGn1dX3oNF3/DPg4V
         t49QQpzkPhLWrGwW9cDwq4Kw7uQG5EcgkdpwrzO/HDHONv+D/N6z78dNpCEiwy/lcNpB
         TB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lBVBDWK8SCqKzaHy0L/+mLoij0OAwknWiLnXgPeJSM=;
        b=g7qvZ5zB0+Lgvc6j8x5CB7H7OddrYI1kumpdmgDCa4UCF0M1YB9ufhGQo/PCMT8pFA
         E31scC7k7UYDmynTvAO1S6PuqAsCbhLmlUXS8GDRI8D2bmjSyhbo4u7OEdnsO/XA5VbB
         eIq2+iT0sxHhdd+yLmrCB4xKxLbXr88/ViNXbCe+N1Bf97FpNTf5nzsOnEo66gN3+OXz
         jIT4qSqfdN0j/duJ0GM5D864ykmE/KSk271CqggPyKLMqCbmD4//JOMPlZ9sGLzeShWG
         X/eiGzpY2kkS+9KtJ2IpB0RfI2s/UuoqmeP1Hi+kw4t2vgzixmdGE7cBh69ar7EPKAng
         6m/A==
X-Gm-Message-State: AOAM53179vQXLUA1fOMGISc6WXr0Lj/MdwM9k3QcyVyXJHqqw9xEOy8y
        QLGrPycgQVPfc5huIf7o6iEwsNsOJJwM2m7TUIn3lQ==
X-Google-Smtp-Source: ABdhPJyqTIqMdYQYBJBwXDLjTJrIAYOVAjbbvPmUH0FRy9zTiej41mBWzaPPONfsn2ZvoadeWtEkbQOTbaDmxU63dbg=
X-Received: by 2002:a05:6402:b35:: with SMTP id bo21mr24193805edb.52.1605649531304;
 Tue, 17 Nov 2020 13:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-2-ben.widawsky@intel.com> <CAJZ5v0i7fcoBe5o-J7q5fYW_1nUYJ-QdshWOBV5fFf85rD_sDA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i7fcoBe5o-J7q5fYW_1nUYJ-QdshWOBV5fFf85rD_sDA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Nov 2020 13:45:20 -0800
Message-ID: <CAPcyv4i6MCu6RmLCyE+K-j3bbtrYeA+hJXL4+Zy_Tfhmwv2ErA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL interconnect
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 17, 2020 at 6:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
[..]
> > +static struct acpi_driver acpi_cxl_driver = {
>
> First of all, no new acpi_driver instances, pretty please!
>
> acpi_default_enumeration() should create a platform device with the
> ACPI0017 ID for you.  Can't you provide a driver for this one?
>

Ah, yes, I recall we had this discussion around the time the ACPI0012
NFIT driver was developed. IIRC the reason ACPI0012 remaining an
acpi_driver was due to a need to handle ACPI notifications, is that
the deciding factor? ACPI0017 does not have any notifications so it
seems like platform driver is the way to go.
