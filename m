Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B1E46F1
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 11:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438249AbfJYJTM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 05:19:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41231 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfJYJTM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 05:19:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id 94so1541587oty.8
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2019 02:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eO6kpTIXKYcY4ou5sdoReZQ7k/e/XcEWAgmC5JAEAbM=;
        b=fV6IEAYaHlzpVZucCQyxW4MSRUc3HT9DYR9EkiR3DJsF7wAbG6UAc2WkzrK8zWqjeL
         Je/Qmq9Fj7nf0cJ7dF2+gWDZTHrM4kLoEjFouGOcrPN5kTrGRYeZMIbq96noZvlExpqi
         /uxOpCRGkjonJP4jbgYqGikdDF0oXmRbp4MWE9Y4lCGH0t0mfg6RloR9lkYkAlsvvn5N
         HRHrXJDIsQTBkpl9M5UtwCZVeuNX144MTG3nch2O8imHVacVjtZhi4v2ckxD1hKDDUVO
         lCqsQKUU1oJlAOpLI2hoI461xLanrnBVKfbBXUp0MJ3zGykl9gh00t5afoqz17J+KUVQ
         bWgg==
X-Gm-Message-State: APjAAAU7WNldy6uAd5UCi2btw20dcr6nyzTwdQ+2QBzba2B/f50SFWE3
        j3//kRDFX6+J0A1pfQOUKFSSHqQfIynZAXU039I=
X-Google-Smtp-Source: APXvYqw+T996enm3bzg1Ug2Oo2tklbN/dna8OVt4+rhQ0y1BHc9Za+kliY9otnBdocuRbRwJN4vOZ4SgESoxaqQGiTc=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr1982615oth.266.1571995151487;
 Fri, 25 Oct 2019 02:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191024185556.4606-1-erik.schmauss@intel.com>
In-Reply-To: <20191024185556.4606-1-erik.schmauss@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Oct 2019 11:19:00 +0200
Message-ID: <CAJZ5v0gqN3yGcLLVntYQgwxVsUhbEZ8L0UJNXOh=xA6nmgTQLA@mail.gmail.com>
Subject: Re: [PATCH 00/12] ACPICA version 20191018
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2019 at 9:13 PM Erik Schmauss <erik.schmauss@intel.com> wrote:
>
> This patchset contains the linuxized patches for ACPICA version
> 20191018. There are several debugger changes but they are meant for
> acpiexec at this time. acpi_load_table definition has been modified and
> a new acpi_unload_table has been added. These new interfaces can be used
> as a part of config fs to load and unload tables.
>
> Other than that, Bob has run clang on our code base and removed several
> compiler warnings.
>
> This patchset is also available here:
> https://github.com/SchmErik/linux/tree/v20191018
>
> Bob Moore (5):
>   ACPICA: Results from Clang changes/fixes From Clang V5.0.1. Mostly
>     "set but never read" warnings.
>   ACPICA: Win OSL: Replace get_tick_count with get_tick_count64
>   ACPICA: More Clang changes - V8.0.1 Fixed all "dead assignment"
>     warnings.
>   ACPICA: Add new external interface, acpi_unload_table
>   ACPICA: Update version to 20191018
>
> Erik Schmauss (6):
>   ACPICA: utilities: add flag to only display data when dumping buffers
>   ACPICA: Debugger: add command to dump all fields of a particular
>     subtype
>   ACPICA: debugger: surround field unit output with braces '{'
>   ACPICA: debugger: add field unit support for acpi_db_get_next_token
>   ACPICA: acpiexec: initialize all simple types and field units from
>     user input
>   ACPICA: debugger: remove leading whitespaces when converting a string
>     to a buffer
>
> Nikolaus Voss (1):
>   ACPICA: make acpi_load_table() return table index

Queuing up as 5.5 material with some minor subject/changelog modifications.

Thanks!
