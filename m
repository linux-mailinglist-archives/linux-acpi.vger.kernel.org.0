Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25277105FF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEAILn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 04:11:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43218 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEAILn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 May 2019 04:11:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so14215233otq.10;
        Wed, 01 May 2019 01:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFB4aM4+JcpNvRnvjtKNssh7m9a9GaZRisGavKOFPKI=;
        b=iMYur87mO8zaamRQ0cdCcPbTtLf731eZvEdJNrmExHL6S/PaRNvOF/cCxmU5YaJ2jt
         qlxhZ8mxxoODmVgToDp2yDHBX1aiuSWnWDu8/HB/LBIV1IjG5Ij62ozg2I56xz1aHpBP
         jleB2R5R0C9Dk5L980/0ZepWjoowEUDPzB12Cr/jt08oYWq+CSbHyc4bmfGhLsm+RBIT
         A16xSx+2uqJjDwU2CCM0Pc9tcW0VBVoCbNX2qVzWAMHO7mhuneL4sYpqS41m8dYlqaNL
         U7Tgeq+R0jspn4SZShKum/fxIT3nLZrNsdWxkH0gBm5jgjxy/RBegiQXtCg6h3ht8NN4
         e/ew==
X-Gm-Message-State: APjAAAWJrofgYY9/cAs/z+mVOpAjwdcNvk55wlLgVKij0cFx+RvU/v9w
        PkuX81EWnxENwidCkIIxg5xOFPZbzYdJiJxp87s=
X-Google-Smtp-Source: APXvYqzR1Q0ES6xxT4dodfDoZJvDTzRUQY5/M28gbUk04gup0u1/uDZhRu/u7OrdgOYLLASscAMOYOTatSORs1PparU=
X-Received: by 2002:a9d:6e17:: with SMTP id e23mr15147617otr.65.1556698302675;
 Wed, 01 May 2019 01:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 May 2019 10:11:31 +0200
Message-ID: <CAJZ5v0hm5RLDRd-T+fwn_JGCZH-++ZhCZjKf7ww1wbj7ax_KLA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / property: fix handling of data_nodes in acpi_get_next_subnode()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 30, 2019 at 5:52 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> When the DSDT tables expose devices with subdevices and a set of
> hierarchical _DSD properties, the data returned by
> acpi_get_next_subnode() is incorrect, with the results suggesting a bad
> pointer assignment. The parser works fine with device_nodes or
> data_nodes, but not with a combination of the two.
>
> The problem is traced to an invalid pointer used when jumping from
> handling device_nodes to data nodes. The existing code looks for data
> nodes below the last subdevice found instead of the common root. Fix
> by forcing the acpi_device pointer to be derived from the same fwnode
> for the two types of subnodes.
>
> This same problem of handling device and data nodes was already fixed
> in a similar way by 'commit bf4703fdd166 ("ACPI / property: fix data
> node parsing in acpi_get_next_subnode()")' but broken later by 'commit
> 34055190b19 ("ACPI / property: Add fwnode_get_next_child_node()")', so
> this should probably go to linux-stable all the way to 4.12
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Applied with the Andy's R-by, but I reformatted the comment to take
fewer lines of code.

Thanks!
