Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC658479301
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Dec 2021 18:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhLQRnN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Dec 2021 12:43:13 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39783 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbhLQRnN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Dec 2021 12:43:13 -0500
Received: by mail-ot1-f48.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso3786763ots.6
        for <linux-acpi@vger.kernel.org>; Fri, 17 Dec 2021 09:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3XJSf+uDdydMRdnuBW6CMjcIOoTqzpT4+pMBpA9NSI=;
        b=6i+fenoFi+Pp0LFaIDDy0J99Gawq8GAzZSi6mK3FfFDlWy/reylUFr9d6IgPN+H1oB
         48uyVhYUE1fQpV0QRZHAgnKKVIq8GG1XksSL+w3Hf1MiM4CzhbxdM2Ca+XxAuM0sGOyz
         ZPqiPhqIZa5mWJMw4bwjHoGJvPlrO33l161YWiHm4DUmVZJYTEKrRjvFTdpfP4aBe+8D
         iCG9qRrzTxbOX1pdiAIL5caPM/ogmOFEpuPEj0V6uOLAo9c1UX/M3n5npIt89kJPRZZy
         vPG3j0JQ/e05LD5CfyynRWWsxJ6ucP4MO2kpgpeWiiNF3llh9/9shMnYy8NMb9jr5dSC
         B9Pw==
X-Gm-Message-State: AOAM532rxBU3eW2ALREPE8J6/Tz4w6Et3RfSyuhbjgmmvb9ET8s31/+w
        6dF351CmPHTJzk0yI3OSo5xMwqV0VtDj6KFMGaQ=
X-Google-Smtp-Source: ABdhPJz9qmREp2ExE6gi3+w6gTMEjj7eAmt0E9b6axMNpIreUTaS2hViumiZGa2mXLEWXc8CUPn9b7rkTSIqOehzRgQ=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr2926899otf.198.1639762992904;
 Fri, 17 Dec 2021 09:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 18:43:01 +0100
Message-ID: <CAJZ5v0gh2aFpde+_9mY7xePpU2nFyo91LNStEydmUJ7OQURnTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Small device property fixes and improvements
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 1, 2021 at 1:58 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hello everyone,
>
> Here's a few small fixes and improvements for device properties.
>
> since v1:
>
> - Use labelled references.
>
> - Avoid using continue in fwnode_graph_get_endpoint_count().
>
> - Rewrap lines in data node reference example.
>
> Sakari Ailus (7):
>   device property: Fix fwnode_graph_devcon_match() fwnode leak
>   device property: Fix documentation for FWNODE_GRAPH_DEVICE_DISABLED
>   Documentation: ACPI: Fix data node reference documentation
>   Documentation: ACPI: Update references
>   device property: Implement fwnode_graph_get_endpoint_count()
>   device property: Use fwnode_graph_for_each_endpoint() macro
>   device property: Drop fwnode_graph_get_remote_node()

All applied as 5.17 material, thanks!
