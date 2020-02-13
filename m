Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A1915CE55
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 23:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBMWxY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 17:53:24 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34558 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMWxX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Feb 2020 17:53:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so7579335oig.1;
        Thu, 13 Feb 2020 14:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0MsZNA+zikNEsKgKngpsTvd+TUGMDouBdzTw78J+Ps=;
        b=LDJH2B/2l/pvKRNaijjnjeaGjiszzm1qrMdoHZgqrVzpJiszDdz5PpCWkP4rFMWz65
         GoPc7n8csaF7zddo42V+V2XYe/dUNCsWfiOxCqQDEKFtfHZy593eBMFy4mXUtvvSi0JF
         uE/soTs0+qBbYXVpwE9z6CluE2acojIiqr/gn6YzkbdFhrx9a54E0NFD+7KtyzygjoKG
         XRVXqPQ7WrPEmHHHA0z2LiydoAeMePFoJGYh8dcl2AnVVHU19fJ99qjD3539rh3Mj3/F
         M3Seuer7qltZ4znXt56mGfsOGvVcXOEPBs7SkKu3w+2oRPxCKsSH0eGPDFZQnx2E0NVt
         wn3A==
X-Gm-Message-State: APjAAAWsNJEq/W3xuDgh5cg6asO2P0snD/+ziVrWHiICHPQSIQ/JkOFD
        RiFV1JniDparKfbrm60JlWBThDucLjM3kePkwRE=
X-Google-Smtp-Source: APXvYqxYRSRulfdfNW1Rxg1ou2/PjO+bhQGRe2/rkk5+xF+UmxvY8pM5qcKxGil9CTur1Gj2cZQURU3q1Ty7LiP0SfY=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr4736182oiy.110.1581634402980;
 Thu, 13 Feb 2020 14:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Feb 2020 23:53:12 +0100
Message-ID: <CAJZ5v0hXQBoo4R-jsf+kY9s+fYj3q==ff2hbiWxx9ECYmXW6MQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ACPI / watchdog: Fix two reported issues
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Tom Abraham <tabraham@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 3:59 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> This is an updated version of the patch series posted here:
>
>   https://lore.kernel.org/linux-watchdog/20200212110540.83559-1-mika.westerberg@linux.intel.com/
>
> This should fix the two issues reported by Jean Delvare. I also addressed
> all the review comments and fixed the bugs in the previous version.
>
> This time I actually tested these on Intel Joule board and the watchdog
> still works as expected.
>
> I'm now including ACPICA maintainers as well to get some feedback regarding
> the first patch of the series.
>
> Mika Westerberg (3):
>   ACPICA: Introduce ACPI_ACCESS_BYTE_WIDTH() macro
>   ACPI / watchdog: Fix gas->access_width usage
>   ACPI / watchdog: Set default timeout in probe

Applied as fixes for 5.6, thanks!
