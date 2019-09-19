Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A60D1B7493
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2019 10:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfISIAU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Sep 2019 04:00:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36316 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfISIAT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Sep 2019 04:00:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so1979742oih.3;
        Thu, 19 Sep 2019 01:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hioETfU5gPztyUmzdSWWdbfkJJTc6dlm5y+dbhCL8R4=;
        b=N2OtSJoNzPDbijtPCMqu/MBOBIWeFBQUdritkXrgkwAWhn/KxsWiHmtg7Q1Ez/1u8B
         yY+UCRmVrOvSEo2KXAfD3r94WkUm9tLfu76UkWQyuLcuJ3AEk1SGRdtU9ukxycb83akc
         cyPzWvi/kVSDZtFWIx+B3btHlg3zaq3B2XgFdLx7aqLN0+6lJfkHwSj1910ovQL8FsSa
         BImG2xPkroMHAS0CtIto/TYcjc4NcdcwJ7sxdRd//ULsHh6ojYCss5H7HjLwxlR4l9mc
         fCCrYko1FAUgK9zB7fyOabzylpevsoDMC27f7l/3QS18ZDOqK/jOefnwCkUIKMk6Zg/z
         Z6rw==
X-Gm-Message-State: APjAAAXGHlWyiCecYhgD22L5hrf+k1MqRbmLxoVhZNy4NIsdQyUs/tXt
        xXlkIEoIhinmeiOe5hcMwrqSxEKqWG9O+NGoi4ZrIA==
X-Google-Smtp-Source: APXvYqylkZhk/PgUvzR9MUbnwm+Jmx9a7SqGV5LCTWYriGa/DgUV0OJhNIYh6ze4wXxDMwE+bw1OTYe6fLzOYlHGG4c=
X-Received: by 2002:aca:db44:: with SMTP id s65mr1289673oig.103.1568880019040;
 Thu, 19 Sep 2019 01:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Sep 2019 10:00:08 +0200
Message-ID: <CAJZ5v0iHv=-t3qA3VBfC6ryPOmC8QW9pxwFvEw6SQQZ3CwsScw@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] Device property improvements, add %pfw format specifier
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 18, 2019 at 3:34 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi all,
>
> This set adds functionality into the device property API (counting a
> node's parents as well as obtaining its name) in order to support printing
> fwnode names using a new conversion specifier "%pfw". The names that are
> produced are equivalent to its OF counterpart "%pOF" on OF systems for the
> two supported modifiers ("f" and "P").
>
> Printing a node's name is something that's been available on OF for a long
> time and if something is converted to device property API (such as the
> V4L2 fwnode framework) it always got removed of a nice feature that was
> sometimes essential in debugging. With this set, that no longer is the
> case.
>
> Note: the set now depends on 2d44d165e939 ("scsi: lpfc: Convert existing
> %pf users to %ps") that is expected from the linux-scsi tree. It is

OK, so I will be expecting a refresh of the series when the above
commit appears in the mainline.

Cheers,
Rafael
