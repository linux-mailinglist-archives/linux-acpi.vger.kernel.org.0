Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0F83756
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2019 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfHFQxw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Aug 2019 12:53:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34285 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfHFQxw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Aug 2019 12:53:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so88635084wrm.1;
        Tue, 06 Aug 2019 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gxNkkJD3b/WJ2BCN1yM/UBEgODs/xbGIxyPlrinnovU=;
        b=YDWulAFE5M1Cj2s64V8j8s4cLZ1QNjqZ5aD10HE/qncnQNsNiWNP1srKy9Z936zPzZ
         GfLtuLfTfrrKO3l7ixtUHK6aIHkRVgaik5+aOyFeBIxlxV7xPMyeKBLP45ubBVWxqsvG
         wv/eUSKpDGVhO/g1WIJNOS0+R9Wfm8cnW8QIO5tIdAWAE7WTYI7POS3z35s1jXLnCod4
         CWXJQqx3mhYa908hr5zPh9VqNo/osxl0WXgr26ayPgSZw6kCEbUbyRkHjfamOz2yZxLr
         yYLSsxfbZ8JDyt/lxippVAe3faaTsN4WpYs1vq6t0UsM2gnR9HGI8OGgrzC6l8M2QSke
         UBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gxNkkJD3b/WJ2BCN1yM/UBEgODs/xbGIxyPlrinnovU=;
        b=QdON+hfanZRqD8cCT+topmyEO3sUEoaRjRnbCJzwxR7wzyRKdss6V4z/oGqbcYIJuj
         yEAaQiUcSup0dOdcD9704qezWV+sWG1649aB0XfFkQQJR04fHe/YGNfYFqsFg8i0ZOfn
         E7m3K+9bmLrM6UFrpV53BF3uGz9DFUIKFAUGrwC7iCjQbypQLGew8GOwizn2+GhNsm/J
         cxaYwQfOU0PC0Sq6CiBr7fimv4dj1maER6Z2UMwo7zjXBU2FJLcJZzN4gGa9IqGb50gr
         7+4FW0NFPgS4au0CWlzRToaxcQhXO5aRkb/kCss2WZ0RUdgZXmmDnGd2yFpHBmEeq7PW
         FVPw==
X-Gm-Message-State: APjAAAUkO6rERWhiSm/BEasrlWqr0J7WYWt6A4e5dn83yDbPHg6cB6uQ
        MwfZoOfZmUvpESFBrb9ez0bB0zkX
X-Google-Smtp-Source: APXvYqwkEM8/7FtU/qIz2EzqolfwDqNOFGtE+29zXZgsxLDAnchWnPtpfHMtQFGIzAti+86XMVHClQ==
X-Received: by 2002:adf:ec49:: with SMTP id w9mr5292515wrn.303.1565110429245;
        Tue, 06 Aug 2019 09:53:49 -0700 (PDT)
Received: from [172.30.90.245] (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id l15sm2581667wrq.64.2019.08.06.09.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 09:53:48 -0700 (PDT)
Subject: Re: [PATCH 04/22] media: Move v4l2_fwnode_parse_link from v4l2 to
 driver base
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <20190805233505.21167-1-slongerbeam@gmail.com>
 <20190805233505.21167-5-slongerbeam@gmail.com>
 <CAHp75VcOh8bOf_s6t0ehwGtcYn64QFGj303SVvpHrztEOhTRgg@mail.gmail.com>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <4750b347-b421-6569-600f-0ced8406460e@gmail.com>
Date:   Tue, 6 Aug 2019 09:53:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcOh8bOf_s6t0ehwGtcYn64QFGj303SVvpHrztEOhTRgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On 8/5/19 11:41 PM, Andy Shevchenko wrote:
> On Tue, Aug 6, 2019 at 2:37 AM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>> There is nothing v4l2-specific about v4l2_fwnode_{parse|put}_link().
>> Make these functions more generally available by moving them to driver
>> base, with the appropriate name changes to the functions and struct.
>>
>> In the process embed a 'struct fwnode_endpoint' in 'struct fwnode_link'
>> for both sides of the link, and make use of fwnode_graph_parse_endpoint()
>> to fully parse both endpoints. Rename members local_node and
>> remote_node to more descriptive local_port_parent and
>> remote_port_parent.
>>
> May I ask if it's going to be used outside of v4l2?

It could be, I can see fwnode_graph_parse_link() being useful in DRM, 
for example. But at this, only media core and v4l2 are making use of it.

This patch was created so that fwnode links can be parsed in a new media 
core function that forms media links from fwnode links.

The full patchset doesn't seem to be up yet, but see [1] for the cover 
letter.

Steve

[1] https://www.mail-archive.com/linux-media@vger.kernel.org/msg148910.html
