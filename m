Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6976682BD8
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2019 08:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfHFGlb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Aug 2019 02:41:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36548 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbfHFGlb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Aug 2019 02:41:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so40947402pfl.3;
        Mon, 05 Aug 2019 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7Wxe/wopuDLr6j5LeIpmGJxa41bzUArxht2aFk5QSM=;
        b=PQB59KqEEQ6y0YFrHhLO6+txcqFbBih2qQcVtibs659NMIAQoA/YBANqsk+eX0SCuW
         sbY5s48PsWRf99yFceRWzXQadQVb8U2KdQ8q5N/UC+OS70N9ZV3HvwGvO+3M/Xch9BlK
         anE08yqAnkcZ18O26SB/+Gjcpq4K06YY9aZnWnTdy+Wa0fG6zxZ9XbgvfBHtwfHLtab3
         jt8HleZQrIUDKrcyd0EKiknFIxmyoeclUXM7WGS+onyhFtjlcA3xbvW/hYQGqUM1DSzg
         4NZvoLpj01Kft8IYBqifjDaNJ0jIAe5TExtcC+IIoWzOyo6kpNrriZw+LRDwaIOTZ9AJ
         +UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7Wxe/wopuDLr6j5LeIpmGJxa41bzUArxht2aFk5QSM=;
        b=DTbH6xCZGp9ZsdtS5MLdgsfwBvX+1BNfm2nS6RHCSJ2p0rMAp/tiOHpQcbwXSIIxv+
         +3YCQwlsBe7JrO1PxjmbI4xojGRGA+eCKENUtR+Og2DhpNUDWPkPP12rqaKudMcybFmT
         H3ORoQwABq4iGCPIgJv/2hnW87Y7yo34S/cuh/mktK6y/Yf6Kz6jjUveVhvHvWyiMCDq
         VLIeQ84+S9M3yenc6TUCxfusJLGvHMV9o0kg1YfNp6RGt2GIscAXI6fbwCOoxhtSouzZ
         FDVI/pBzPlu1PRMiHkJk2fmlVwUhH6b3L8Eu0RO7I3MD5gS4TaVFXPMIvFRtJhBKMSNT
         T+ag==
X-Gm-Message-State: APjAAAUR2yPpN/0IFFS6qcVnQy90L4dYUNg3+I3VH/no7weeIwQ/42MW
        sphu8uzfjh0RL8/7Q51htJFbBJIuO5GE5zWKTeE=
X-Google-Smtp-Source: APXvYqwNrBeCBFk00MAwOwazzhjYBhn+KfLDMNZ9dnhN85lTl19ENdSbslLn8ga+DxdlH5db2IF4JBnKiLNcySs6fRY=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr1658530pgj.4.1565073690207;
 Mon, 05 Aug 2019 23:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190805233505.21167-1-slongerbeam@gmail.com> <20190805233505.21167-5-slongerbeam@gmail.com>
In-Reply-To: <20190805233505.21167-5-slongerbeam@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Aug 2019 09:41:18 +0300
Message-ID: <CAHp75VcOh8bOf_s6t0ehwGtcYn64QFGj303SVvpHrztEOhTRgg@mail.gmail.com>
Subject: Re: [PATCH 04/22] media: Move v4l2_fwnode_parse_link from v4l2 to
 driver base
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 6, 2019 at 2:37 AM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
> There is nothing v4l2-specific about v4l2_fwnode_{parse|put}_link().
> Make these functions more generally available by moving them to driver
> base, with the appropriate name changes to the functions and struct.
>
> In the process embed a 'struct fwnode_endpoint' in 'struct fwnode_link'
> for both sides of the link, and make use of fwnode_graph_parse_endpoint()
> to fully parse both endpoints. Rename members local_node and
> remote_node to more descriptive local_port_parent and
> remote_port_parent.
>

May I ask if it's going to be used outside of v4l2?
Any user in mind?

-- 
With Best Regards,
Andy Shevchenko
