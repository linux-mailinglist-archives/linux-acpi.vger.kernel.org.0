Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E032E279E
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgLXOZE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 09:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgLXOZD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 09:25:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A00C0617A6;
        Thu, 24 Dec 2020 06:24:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y23so1756858wmi.1;
        Thu, 24 Dec 2020 06:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M+N06EmcJFVLj4CN44KRnLg8MB/99NEOfhbL1AkgPbo=;
        b=mdsMzpeGWDSWXjAkbEs6+T3MmkZvHv2GGN3947O4nVnpNrCxD69QpTVwbicNf6/qif
         G7ncpLa4Lv1ixIMDxGgvlDwcbXo60ZlEB7sTj52pkdq5BF8cCHmKTfvhih26z4yv7iL5
         GqPyjm1SOTEXfefif6TaRUxcMU7N2SlT1XYeZ09BPU6iChnAV5eD1x5ckspI9bhhy6PN
         oMLqZFp3MZ2R6DyAC0gHa6jupqL+5+xiL33/AVVNc1GD+90hniALIg8+I/lqfn9NYVqy
         WNoh5Hmym/iBeXUe9RDOw3/MYy6eb+8K2I0li60yydia1IjC+kf+IKSbVX2cwlmJQP1s
         azmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M+N06EmcJFVLj4CN44KRnLg8MB/99NEOfhbL1AkgPbo=;
        b=GuElCHoPMvwOsjDadmjSoA27dfzGXt/3HNaCBNHIMlRTsyS4fxeDYAEQtXA2y+WkpK
         48DO2dal7hLx93hktaYUkkuDfEFzoFeaAfhmzkkhXmNWv8f/MiappJeL2+BEwHRE3UMV
         6ADebZvdEmrVsveOmSooiiZ5s8J+n+QNaRz3aEXuQTei9SRzacDarcCOne3IlBO2aLRZ
         5Tn0fKfau8lzyw29NlvlavHQguZc4Cz6gQ1AdCgQA+32aThBwnjxI3w+D07EsSHPzG7h
         I0atE35Vsv0QArPaHBazkvZ/xDcXASUTHgQWZUHUIbMGGcleeFNh/lTbh/0TZOdVub8N
         70oQ==
X-Gm-Message-State: AOAM533hHUQ8R8oCYGofgO214r0oMtYVXF2LeaLH0ihTO2c5kCBXAAu3
        Zug2K3bwI59xJ21v+IREc2A=
X-Google-Smtp-Source: ABdhPJyyPU4z/SYA/lIq8JzuBtX0l1hBD+x/9V9HufAJW1hUEnYBubQAF3jSek3Rg2I3dccWrin6sQ==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr4604917wml.106.1608819861647;
        Thu, 24 Dec 2020 06:24:21 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id o17sm40499882wrg.32.2020.12.24.06.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 06:24:20 -0800 (PST)
Subject: Re: [PATCH v3 07/14] software_node: Add support for fwnode_graph*()
 family of functions
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-8-djrscally@gmail.com>
 <X+SPUTDn+lPdV4ny@pendragon.ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <fcb0d5b6-db28-ff0a-b998-c46ebad8e759@gmail.com>
Date:   Thu, 24 Dec 2020 14:24:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X+SPUTDn+lPdV4ny@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24/12/2020 12:53, Laurent Pinchart wrote:
>> +	while ((port = software_node_get_next_child(parent, old))) {
>> +		/*
>> +		 * ports have naming style "port@n", so we search for children
>> +		 * that follow that convention (but without assuming anything
>> +		 * about the index number)
>> +		 */
>> +		if (!strncmp(to_swnode(port)->node->name, "port@",
>> +			     FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
> 
> I would either add a macro to replace the prefix ("port@"), or drop
> FWNODE_GRAPH_PORT_NAME_PREFIX_LEN. I think this is the worst of both
> worlds, the string and its length are defined in two different places
> :-)
> 
> I would personally drop the macro, but I don't mind either way as long
> as the string and its length are defined in the same place.

OK, pending outcome of the discussion in the other thread I'll do both
things the same way - whatever the decision there is.


>> +static int
>> +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>> +				   struct fwnode_endpoint *endpoint)
>> +{
>> +	struct swnode *swnode = to_swnode(fwnode);
>> +	int ret;
>> +
>> +	/* Ports have naming style "port@n", we need to select the n */
>> +	ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
>> +			10, &endpoint->port);
> 
> Same here.
> 
> I wonder if we should add a check to ensure parent->node->name is long
> enough (and possibly even start with the right prefix), as otherwise the
> pointer passed to kstrtou32() may be past the end of the string. Maybe
> this is overkill, if we can rely on the fact that software nodes have
> correct names.

Not necessarily actually; ports yes but endpoints no, so I think the
danger is there. I'll add the check.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

