Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A8B2DEB7B
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 23:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgLRWTt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 17:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRWTs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 17:19:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801CDC0617A7;
        Fri, 18 Dec 2020 14:19:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k10so3768059wmi.3;
        Fri, 18 Dec 2020 14:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x/94YNNiolq8vj5aoNjfHROfwjty9nvcB9ZmsWJnn6E=;
        b=gZ5OyJ8SUDw44HZrie6znkHNo30liOtiSG+DFVx/lE0esnCmLPrYs+OieomvTCv4g1
         fRCb6QxQ6MXsq/rw7ru4jYRzNiH16ZUE9At39dBXRFJsEAMMJtMpdNeDcAMDGhLnMxeY
         FKqzhJO9cjoI6+YsqD/tt0mNxGylqtDQduoAwKj5mRR9U9kfZeT1gMirsr/H9E7njhvO
         gy5bO2oiPy//C/Wo3g2L8Rd9Q3K2P33Y+0IXxQvmdAr7BJ2JoA7vV9fLaxadec4JqX7u
         6YnsmwRu3UU1v/7u0B44Caro/9MWKSE0nu/Q5ysgSgaZj/Yr8krUN3dQYhFBrEWLOr3w
         Cphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/94YNNiolq8vj5aoNjfHROfwjty9nvcB9ZmsWJnn6E=;
        b=nxgKVU2XQCuh2H+VGsXbumHaQd92BdgxDfrS1l4sFlFmCsMF5EfgqCUjgCOkmpSoe/
         umOjBwT2Tvg9LUqB0c61W4aaa5AGoPXXSf86NOtlWx1awfPOjtLefFbPi/4tpVAkpOVl
         EtYudUeP+D4O+LzQnQVAdey/47rWTMn8l6oj5G+kaJEm4gDZjiabPODUyxDL7LA6C5vk
         628ynlenX7p8sEXqLNDZ+XShkoS826QLSD5tQ2I5VMvtFi3+ZcaHzD15IQy80D0F6Pu8
         YZ7zBojfmSi0ADlzadO5/VRlSor+KnU5O7dKALzgCwtPvVu6S3/HVYmWVpnIil/domKO
         mX5A==
X-Gm-Message-State: AOAM531by7OtF5ieRGXAg9Ij+QGYWA9e9Ti9Eqn2nY0lJmUtpdiqGS/K
        D3X4queAM1FrndjRJ+tRiBw=
X-Google-Smtp-Source: ABdhPJyAwkfZFJcQS5wCOZ1Oz3+vF0eyE+5R3e4S6l6DNlGX0ehsbOaRwR6Xdcs9eWPK72y8lZejjA==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr5897806wmm.72.1608329947288;
        Fri, 18 Dec 2020 14:19:07 -0800 (PST)
Received: from [192.168.1.158] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id h3sm13760827wmm.4.2020.12.18.14.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 14:19:06 -0800 (PST)
Subject: Re: [PATCH v2 04/12] software_node: Enforce parent before child
 ordering of nodes arrays
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
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-5-djrscally@gmail.com>
 <X9zSfPUmHL3kho+D@pendragon.ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <0b7cac02-ea34-6068-a1f6-de4bb34dca5a@gmail.com>
Date:   Fri, 18 Dec 2020 22:19:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9zSfPUmHL3kho+D@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Laurent

On 18/12/2020 16:02, Laurent Pinchart wrote:
> Hi Daniel,
> 
> Thank you for the patch.
> 
> On Thu, Dec 17, 2020 at 11:43:29PM +0000, Daniel Scally wrote:
>> Registering software_nodes with the .parent member set to point to a
>> currently unregistered software_node has the potential for problems,
>> so enforce parent -> child ordering in arrays passed in to
>> software_node_register_nodes().
>>
>> Software nodes that are children of another software node should be
>> unregistered before their parent. To allow easy unregistering of an array
>> of software_nodes ordered parent to child, reverse the order in which
>> software_node_unregister_nodes() unregisters software_nodes.
>>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>> Changes in v2:
>>
>> 	- Squashed the patches that originally touched these separately
>> 	- Updated documentation
>>
>>  drivers/base/swnode.c | 43 ++++++++++++++++++++++++++++++-------------
>>  1 file changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>> index 615a0c93e116..cfd1faea48a7 100644
>> --- a/drivers/base/swnode.c
>> +++ b/drivers/base/swnode.c
>> @@ -692,7 +692,10 @@ swnode_register(const struct software_node *node, struct swnode *parent,
>>   * software_node_register_nodes - Register an array of software nodes
>>   * @nodes: Zero terminated array of software nodes to be registered
>>   *
>> - * Register multiple software nodes at once.
>> + * Register multiple software nodes at once. If any node in the array
>> + * has it's .parent pointer set, then it's parent **must** have been
>> + * registered before it is; either outside of this function or by
>> + * ordering the array such that parent comes before child.
>>   */
>>  int software_node_register_nodes(const struct software_node *nodes)
>>  {
>> @@ -700,33 +703,47 @@ int software_node_register_nodes(const struct software_node *nodes)
>>  	int i;
>>  
>>  	for (i = 0; nodes[i].name; i++) {
>> -		ret = software_node_register(&nodes[i]);
>> -		if (ret) {
>> -			software_node_unregister_nodes(nodes);
>> -			return ret;
>> +		const struct software_node *parent = nodes[i].parent;
>> +
>> +		if (parent && !software_node_to_swnode(parent)) {
>> +			ret = -EINVAL;
>> +			goto err_unregister_nodes;
>>  		}
>> +
>> +		ret = software_node_register(&nodes[i]);
>> +		if (ret)
>> +			goto err_unregister_nodes;
>>  	}
>>  
>>  	return 0;
>> +
>> +err_unregister_nodes:
>> +	software_node_unregister_nodes(nodes);
>> +	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(software_node_register_nodes);
>>  
>>  /**
>>   * software_node_unregister_nodes - Unregister an array of software nodes
>> - * @nodes: Zero terminated array of software nodes to be unregistered
>> + * @nodes: Zero terminated array of software nodes to be unregistered.
> 
> Not sure if this is needed.

Hah, of course. Hangover from the last version (when I had made that
line two sentences)
> 
>>   *
>> - * Unregister multiple software nodes at once.
>> + * Unregister multiple software nodes at once. If parent pointers are set up
>> + * in any of the software nodes then the array MUST be ordered such that
> 
> I'd either replace **must** above with MUST, or use **must** here. I'm
> not sure if kerneldoc handles emphasis with **must**, if it does that
> seems a bit nicer to me, but it's really up to you.

Honestly I haven't delved into kerneldoc yet, but either way I think
**must** is better in both places - will change.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thank you!
> 
>> + * parents come before their children.
>>   *
>> - * NOTE: Be careful using this call if the nodes had parent pointers set up in
>> - * them before registering.  If so, it is wiser to remove the nodes
>> - * individually, in the correct order (child before parent) instead of relying
>> - * on the sequential order of the list of nodes in the array.
>> + * NOTE: If you are uncertain whether the array is ordered such that
>> + * parents will be unregistered before their children, it is wiser to
>> + * remove the nodes individually, in the correct order (child before
>> + * parent).
>>   */
>>  void software_node_unregister_nodes(const struct software_node *nodes)
>>  {
>> -	int i;
>> +	unsigned int i = 0;
>> +
>> +	while (nodes[i].name)
>> +		i++;
>>  
>> -	for (i = 0; nodes[i].name; i++)
>> +	while (i--)
>>  		software_node_unregister(&nodes[i]);
>>  }
>>  EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
> 
