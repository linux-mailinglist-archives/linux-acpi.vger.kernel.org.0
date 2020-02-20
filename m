Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D10165A83
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2020 10:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBTJxw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Feb 2020 04:53:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41915 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgBTJxw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Feb 2020 04:53:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so3066300otc.8;
        Thu, 20 Feb 2020 01:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeN19GuMB9ysdWk9mvfpt7TayG82X3Z6MoBxOjoN1DQ=;
        b=aj3HSdcnObpMLp28TZMsunEHb7Q79as1GgDSnPUDnmeqDlwUqh3X2s6AZk+JzsrATG
         H6gVwRT7EZEE7W1Xek/mmnp6uV1kgpBqpOUAUjA7/OJGpPibP4RCe0fXZCFVDlRnJITc
         ZmRUbqXUsefDtI5kZD+qUl+N0a7PgS8jHEC+BVq3iE/x0dKi0LqNzeFCZUTc0pZWRRMv
         IqTQRcP9JPywkQc32E0lTVEa8VOdJ+7c31QrHZRrIaW2ChEXwRJ5jtMyuN7nmqJLi15m
         /3GMHog5o3XEEvXlL+MqUIgPIgsSGI28XcCLB9NeHpLXt2JHTkiG3vr7nzF8wiak9rVR
         Os/A==
X-Gm-Message-State: APjAAAWvVnDdYOp7kiHXD+77UtUh2ChEdQOM/PdafJCBSQVqwnkUfuF2
        5B6VbmlZwT/oFIE7ZIl5dJkGON2PQtNfKr1/Kj4=
X-Google-Smtp-Source: APXvYqxLOo4uzE64DC6gPgGBW4hdqs+4rlt7vt1Fjhxf8+gu4PC1ikAdU8TeWnrzHm8OZrIZcVApDNT1MUzLwx8rN1w=
X-Received: by 2002:a9d:7559:: with SMTP id b25mr22192490otl.189.1582192431589;
 Thu, 20 Feb 2020 01:53:51 -0800 (PST)
MIME-Version: 1.0
References: <98d72d3b-c9eb-36bc-1d68-2c3020bdf9c5@infradead.org>
In-Reply-To: <98d72d3b-c9eb-36bc-1d68-2c3020bdf9c5@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 10:53:39 +0100
Message-ID: <CAJZ5v0hsoYc4CYw90CAQGKpeh=Zt5oC0YWkP-o-t2TuntSng2A@mail.gmail.com>
Subject: Re: [PATCH] Documentation/admin-guide/acpi: fix fan_performance_states.rst
 warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 17, 2020 at 5:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Sphinx format warnings in fan_performace_states.rst
> by adding indentation.
>
> Documentation/admin-guide/acpi/fan_performance_states.rst:21: WARNING: Literal block ends without a blank line; unexpected unindent.
> Documentation/admin-guide/acpi/fan_performance_states.rst:41: WARNING: Literal block expected; none found.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/admin-guide/acpi/fan_performance_states.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- lnx-56-rc2.orig/Documentation/admin-guide/acpi/fan_performance_states.rst
> +++ lnx-56-rc2/Documentation/admin-guide/acpi/fan_performance_states.rst
> @@ -18,7 +18,7 @@ may look as follows::
>
>   $ ls -l /sys/bus/acpi/devices/INT3404:00/
>   total 0
> -...
> + ...
>   -r--r--r-- 1 root root 4096 Dec 13 20:38 state0
>   -r--r--r-- 1 root root 4096 Dec 13 20:38 state1
>   -r--r--r-- 1 root root 4096 Dec 13 20:38 state10
> @@ -38,7 +38,7 @@ where each of the "state*" files represe
>  and contains a colon-separated list of 5 integer numbers (fields) with the
>  following interpretation::
>
> -control_percent:trip_point_index:speed_rpm:noise_level_mdb:power_mw
> +  control_percent:trip_point_index:speed_rpm:noise_level_mdb:power_mw
>
>  * ``control_percent``: The percent value to be used to set the fan speed to a
>    specific level using the _FSL object (0-100).

Applied as a fix for 5.6, thanks!
