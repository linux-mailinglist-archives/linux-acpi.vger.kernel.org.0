Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4932E6C5E
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgL1Wze (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 17:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbgL1WiW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 17:38:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF9EC061793;
        Mon, 28 Dec 2020 14:37:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q18so12696370wrn.1;
        Mon, 28 Dec 2020 14:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cAeYGJr64qM0J3cdUpSC1dxJIeDEv7wZv2g1KK2WMMg=;
        b=dnGS/5FXPPzqgLVq8xXScoVyFGMeV8K6XsxEUPVluPEma6sUdvZKM80nVrAVFtnM/O
         0rj2IMM+HP1RCIGgr582ATwDAp1s5zZ2v0fhZ8N0hZriQ7ZlYEa+K9Uc0Txtf5uu1/Eq
         k6q2M7m6FLWIdJmrL53J1lOntfLv1hxCYrzwo5avwYscFKkq31WMB+3X0D11CvCdjTw5
         Btrm9ljDANWofBjSansLml5CSAVnVRQwRIDTW49UJg2S9CNgmTK2VkQnUa/KgyHP6DqV
         G+7YyCdqb62lBCF0aWbMzcl017zNTWqI9a9A6mfCj2rTNQeNCDOqF/LHAgeK5xVBQKcq
         XFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cAeYGJr64qM0J3cdUpSC1dxJIeDEv7wZv2g1KK2WMMg=;
        b=MdKQ2UxQNwj45oTxfA+kuxuMM52z2jNMs/abP+6UMcpPbVjNdV5UwJcfugMLhiltHA
         jH7E6g+OOcLI5/hObmbo6c5+Qev7nulKq21wYUvyRSrFme41gVImUGZrnSwXyUqyzKfL
         4kM/WvkVjH+CQtTYELcIlb3KJ0SHWP7SDCnpny/xQsVVdTQU90q/n7QBTTXLKfaq/RnP
         oTE8HFwHIaPMpYT/Gu9d08pSRHdneoMabDpSs/hQeD4VwL0k3ZAGI1qHM0c+v/RROsnJ
         6UpMghMUN+cNqCrlgO0Pg/wROCP62/iYV3Bm6Og/risiHEj2LYkH6PJ0kd0SggImQM0z
         ZoEQ==
X-Gm-Message-State: AOAM5300e6o05og/QoTVpHjJh3pxMd/v4vDi76JsvDyr+DfSsvHfk3zD
        5rWKemNdqJSaczIqM4SVEzw=
X-Google-Smtp-Source: ABdhPJwYZOC20R+KxVh6WIxIwMGw6u/XrQTn7/CHjpU7BqRPjo6ICMdePCC5PQ/uQ8EQ/yVP0jag9g==
X-Received: by 2002:a5d:528a:: with SMTP id c10mr45712570wrv.117.1609195060468;
        Mon, 28 Dec 2020 14:37:40 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id k10sm54929429wrq.38.2020.12.28.14.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 14:37:39 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com>
Message-ID: <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
Date:   Mon, 28 Dec 2020 22:37:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228170521.GZ26370@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari, thanks for comments

On 28/12/2020 17:05, Sakari Ailus wrote:
> Hi Andy, Daniel,
> 
> On Thu, Dec 24, 2020 at 02:54:44PM +0200, Andy Shevchenko wrote:
>>> +static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
>>> +{
>>> +       snprintf(sensor->node_names.remote_port, sizeof(sensor->node_names.remote_port),
>>> +                FWNODE_GRAPH_PORT_NAME_FORMAT, sensor->ssdb.link);
>>> +       snprintf(sensor->node_names.port, sizeof(sensor->node_names.port),
>>> +                FWNODE_GRAPH_PORT_NAME_FORMAT, 0); /* Always port 0 */
>>> +       snprintf(sensor->node_names.endpoint, sizeof(sensor->node_names.endpoint),
>>> +                FWNODE_GRAPH_ENDPOINT_NAME_FORMAT, 0); /* And endpoint 0 */
> 
> Please wrap before 80, there's no need here to do otherwise. You could
> argue about cio2_bridge_create_fwnode_properties() though. I might just
> wrap that, too.
> 
> Applies to the rest of the patch.

I shall wrap such cases then - I thought I read somewhere that the
wrapped line needed to be shorter than the parent which is why I wrapped
after 80...but I can't find the reference now so possibly I imagined that.

>>> +static int cio2_bridge_connect_sensors(struct cio2_bridge *bridge,
>>> +                                      struct pci_dev *cio2)
>>> +{
>>> +       struct fwnode_handle *fwnode;
>>> +       struct cio2_sensor *sensor;
>>> +       struct acpi_device *adev;
>>> +       unsigned int i;
>>> +       int ret = 0;
>>
>> You may drop this assignment and...
>>
>>> +       for (i = 0; i < ARRAY_SIZE(cio2_supported_sensors); i++) {
>>> +               const struct cio2_sensor_config *cfg = &cio2_supported_sensors[i];
> 
> You could move the inner loop into a new function called e.g.
> cio2_bridge_connect_sensor.

Yeah good idea, I'll do that.

>>> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
>>> new file mode 100644
>>> index 000000000000..004b608f322f
>>> --- /dev/null
>>> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
>>> @@ -0,0 +1,122 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/* Author: Dan Scally <djrscally@gmail.com> */
>>> +#ifndef __CIO2_BRIDGE_H
>>> +#define __CIO2_BRIDGE_H
>>> +
>>> +#include <linux/property.h>
>>> +
>>> +#define CIO2_HID                               "INT343E"
>>> +#define CIO2_NUM_PORTS                         4
> 
> This is already defined in ipu3-cio2.h. Could you include that instead?

Yes; but I'd need to also include media/v4l2-device.h and
media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
moment). It didn't seem worth it; but I can move those two includes from
the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h

Which do you prefer?

>>> +#define MAX_NUM_LINK_FREQS                     3
>>> +
>>> +#define CIO2_SENSOR_CONFIG(_HID, _NR, ...)     \
>>> +       {                                       \
>>> +               .hid = _HID,                    \
>>> +               .nr_link_freqs = _NR,           \
>>> +               .link_freqs = { __VA_ARGS__ }   \
>>> +       }
>>> +
>>> +#define NODE_SENSOR(_HID, _PROPS)              \
>>> +       ((const struct software_node) {         \
>>> +               .name = _HID,                   \
>>> +               .properties = _PROPS,           \
>>> +       })
>>> +
>>> +#define NODE_PORT(_PORT, _SENSOR_NODE)         \
>>> +       ((const struct software_node) {         \
>>> +               _PORT,                          \
>>> +               _SENSOR_NODE,                   \
> 
> Could you use explicit assignments to fields here, please?
> 
>>> +       })
>>> +
>>> +#define NODE_ENDPOINT(_EP, _PORT, _PROPS)      \
>>> +       ((const struct software_node) {         \
>>> +               _EP,                            \
>>> +               _PORT,                          \
>>> +               _PROPS,                         \
> 
> Ditto.
> 

Will do

