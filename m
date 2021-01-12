Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8E2F405F
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 01:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbhALXgV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 18:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbhALXgU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 18:36:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC2C061575;
        Tue, 12 Jan 2021 15:35:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g8so3382692wme.1;
        Tue, 12 Jan 2021 15:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=96AFxN9qdBCX705IZeYQUwreVW1FNVIfvYgEDTfoapc=;
        b=EAcYSikfHZcircFSK78lfI+As4BKckcFYYkxNpU2iWOyM0ORpkrMnjQP4o1uDXXu8d
         ITcjJNRNM7ou0ysaQOAh9kO4W7DsOXCSyp1WdD9/36bGoApqH4E9DGeA600ja8EgFRYa
         VESDD4M5SydFu30WecBJL62r9hFe6GR5DsD4WFIwoRa/K4nta9EOpt+Wt3p2R1iVF+uj
         7T9xSWOM9Ap1DLDLtCzOpVT/o3lCK+syGlKmgQQKbXLF8wzLdE7CP23/6AKAHp4ZsKmx
         y+QGzxUDE+g755I7++Z9mwkZKtOgqeEjEBynGthZ6wIoOA95cRRf3J5DVracJdVPhxBw
         kyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=96AFxN9qdBCX705IZeYQUwreVW1FNVIfvYgEDTfoapc=;
        b=E4vOCmWBlXhOZBcFtEzTLI40JLf4++pUsFTFF+3dlLt4acCO3jUqV5Ij941cgONxum
         jEWg/RBkv8SCIHA8j14Nw+gxLhdbyhbltpJ0jQOjsQYaU5HwADXSzZfX9ek4Bv/qqGRD
         +05Y5sdbO/QnauWR6GzjPxJAMLxkUiQmD7NAOPoyzgF2SRc+bMidEjUWFLoXmKE35pj6
         0BVjbrJGI5dIeoWVTxQJJLAth8gY7fEzm+9Cl5VsQUYbPTmZD1Z3hRwqd4EWK4NuEBtN
         C5VP5XZ2YFA8fHHSWJPFqG67U1QajT+QMaeALctaFkLN54tZ5/S24Z1L8hbpJ2faBZr3
         Nr7w==
X-Gm-Message-State: AOAM530HGHL6yAsrUhzNEy3Dnrk4zpPuyreUR+GpLSwFgS+Yg0hByvDa
        BqvDlVH4Vg3r+J5RJbaP35y8zAtzrPR2hg==
X-Google-Smtp-Source: ABdhPJy6vn2CF1xoE9dKg3jChENtseZXZXzBV2rpYPSMu8O38VXZvrNpwnnRLOqBXOynaXloYJYMcw==
X-Received: by 2002:a1c:608b:: with SMTP id u133mr65860wmb.140.1610494539312;
        Tue, 12 Jan 2021 15:35:39 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id b127sm135170wmc.45.2021.01.12.15.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 15:35:38 -0800 (PST)
Subject: Re: [PATCH v5 00/15] Add functionality to ipu3-cio2 driver allowing
 software_node connections to sensors on platforms designed for Windows
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yong.zhi@intel.com, Bingbu Cao <bingbu.cao@intel.com>,
        tian.shu.qiu@intel.com, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <CAJZ5v0gb9c-kWM4aAKm6UqbVKt7dyp6xJS5E=7yoPRnPP+msbw@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <9c451747-410e-3c99-c1a5-87336b71aa7b@gmail.com>
Date:   Tue, 12 Jan 2021 23:35:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gb9c-kWM4aAKm6UqbVKt7dyp6xJS5E=7yoPRnPP+msbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Sakari

On 12/01/2021 19:34, Rafael J. Wysocki wrote:
> <snip>
>> I'm hopeful that most or all of this series could get picked up for 5.12.
>> We touch a few different areas (listed below), but I think the easiest
>> approach would be to merge everything through media tree. Rafael, Greg,
>> Mauro and Sergey; are you ok with that plan, or would you prefer a
>> different approach? Mauro; if that plan is ok (and of course assuming that
>> the rest of the patches are acked by their respective maintainers) could
>> we get a dedicated feature branch just in case the following series ends
>> up being ready in time too?
>>
>> <snip>
> Please feel free to add
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> to all of the device properties patches in this series if that helps.
>
> Thanks!

Thanks very much (and Greg too).


Sakari; unless I'm misunderstanding something, I think this series could
be picked up now, right? Would it be ok to do that through your tree? I
think the idea of a dedicated feature branch can be dropped, I won't
have the second series ready in time for this round anyway.


First time doing this, so if I've missed something please let me know!

