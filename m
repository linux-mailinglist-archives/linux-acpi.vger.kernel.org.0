Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165162DEB72
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 23:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgLRWOj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 17:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgLRWOj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 17:14:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A7C0617A7;
        Fri, 18 Dec 2020 14:13:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t30so3940897wrb.0;
        Fri, 18 Dec 2020 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Isk9hkDKCSvcrvKZcfTXquqYMaga8rBRacQ/xkv2ow=;
        b=HUm1uFM1kzwFx/JnrcT1a7vsbTGYXdKCLNPtq/f7gnBcPMMgiMj3TR62adrCIALs0F
         p41+8BkRRAM9JJMcBOleJtG9wUvNr7mNp/4JeOmkmhFl/F8jz8zv2wlGWQG6R4k9kXlH
         HzlncCW+bkmwR7XQeyvHppYVSQrufic03XV4y1j0a/KXQtvF3xJpvnCyZUZAHBB1Oq4Z
         tXmK9PeGVO4ze+uTRatjqgEWYzMhY34vQJ9MsiQTM10ueKXNkcvyPRf9Qs1JJXcZDYhm
         Nez5rxc37xPSWqJxcjIzb13qYvG34aoEo6pHkE1P9yQp+gqgsuJUq9Lh6fZThl0GZwWp
         xnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Isk9hkDKCSvcrvKZcfTXquqYMaga8rBRacQ/xkv2ow=;
        b=fuYH6H7OSBuTO5Lh9+1Z8tQLBfCCSVFr2l4CT6vKPUwQ+vQPYHCjjllekSevaaqXVa
         La2ZZYhmBs2pXH/Gj6HVlNH1bAAA8BXWZngZlOLInQ/SS785lPMGiTvc7eCV2NqK9Tke
         OJpBexEbWHoUCGuO0DJJRzppMB1CsqC44za7uRmE5iknIBJrfUjMPwLRPNxRB5lNbr4B
         H0eJM7Ns+ExxGYZN5yceQNe8s1BHjpwqZAHUS2M+V3nd/3be1OiYPJRO6O1ndqzc7UDz
         PCZwfT2W2T/FHDgv2Whvvorn1pxKI7rGLaEE99RVkxBFuNgqcaztsGfywdHQI5ewi1Ox
         vQ9Q==
X-Gm-Message-State: AOAM5304ysq2XCSf71PT0cKmz6+A+kdpSOGSJIQpjQe8l0mOCX8yjqDd
        Y4lRjgbc9pkQMhIDnzJBwHo=
X-Google-Smtp-Source: ABdhPJxy2su7mTQxsFPb4gaOIDLeg1e9oOUlPezCiqmBL6fCMdpUZG+mVi17M9D4ZL9Ibwb7Fn2AJw==
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr6625090wrp.121.1608329637286;
        Fri, 18 Dec 2020 14:13:57 -0800 (PST)
Received: from [192.168.1.158] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id c81sm14038810wmd.6.2020.12.18.14.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 14:13:56 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 06/12] software_node: Add support for fwnode_graph*()
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
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-7-djrscally@gmail.com>
 <X9zXPpirfS2mCFk0@pendragon.ideasonboard.com>
Message-ID: <8d448981-ddd5-9e2e-03bc-0a67b318d379@gmail.com>
Date:   Fri, 18 Dec 2020 22:13:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9zXPpirfS2mCFk0@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Laurent - thanks for comments as always

On 18/12/2020 16:22, Laurent Pinchart wrote:
> Hi Daniel,
> 
> Thank you for the patch.
> 
> On Thu, Dec 17, 2020 at 11:43:31PM +0000, Daniel Scally wrote:
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> This implements the remaining .graph_* callbacks in the
>> fwnode operations structure for the software nodes. That makes
>> the fwnode_graph*() functions available in the drivers also
>> when software nodes are used.
>>
>> The implementation tries to mimic the "OF graph" as much as
>> possible, but there is no support for the "reg" device
>> property. The ports will need to have the index in their
>> name which starts with "port@" (for example "port@0", "port@1",
>> ...) and endpoints will use the index of the software node
>> that is given to them during creation. The port nodes can
>> also be grouped under a specially named "ports" subnode,
>> just like in DT, if necessary.
>>
>> The remote-endpoints are reference properties under the
>> endpoint nodes that are named "remote-endpoint".
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Co-developed-by: Daniel Scally <djrscally@gmail.com>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>> Changes in v2:
>>
>> 	- Changed commit to specify port name prefix as port@
>> 	- Accounted for that rename in *parse_endpoint()
>>
>>  drivers/base/swnode.c | 110 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>> index 2b90d380039b..0d14d5ebe441 100644
>> --- a/drivers/base/swnode.c
>> +++ b/drivers/base/swnode.c
>> @@ -540,6 +540,110 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>>  	return 0;
>>  }
>>  
>> +static struct fwnode_handle *
>> +swnode_graph_find_next_port(const struct fwnode_handle *parent,
>> +			    struct fwnode_handle *port)
>> +{
>> +	struct fwnode_handle *old = port;
>> +
>> +	while ((port = software_node_get_next_child(parent, old))) {
>> +		if (!strncmp(to_swnode(port)->node->name, "port", 4))
> 
> Maybe we'll need to limit this to matching on "port" or "port@[0-9]+" to
> avoid false positives, but that can be done later, if needed.

Hmm yeah I guess that's a danger - ok, I'll stick it on the list.


>> +			return port;
>> +		old = port;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct fwnode_handle *
>> +software_node_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>> +				      struct fwnode_handle *endpoint)
>> +{
>> +	struct swnode *swnode = to_swnode(fwnode);
>> +	struct fwnode_handle *old = endpoint;
>> +	struct fwnode_handle *parent;
>> +	struct fwnode_handle *port;
>> +
>> +	if (!swnode)
>> +		return NULL;
>> +
>> +	if (endpoint) {
>> +		port = software_node_get_parent(endpoint);
> 
> Here the reference count to port is incremented.
> 
>> +		parent = software_node_get_parent(port);
>> +	} else {
>> +		parent = software_node_get_named_child_node(fwnode, "ports");
>> +		if (!parent)
>> +			parent = software_node_get(&swnode->fwnode);
>> +
>> +		port = swnode_graph_find_next_port(parent, NULL);
> 
> But here it isn't, software_node_get_next_child() doesn't deal with
> reference counts.

Not as in the kernel right now, but after patch one of this series, it does:

[PATCH v2 01/12] software_node: Fix refcounts in
software_node_get_next_child()

I'm not sure that one linked to the thread correctly, but it's here if
you haven't seen it:

https://lore.kernel.org/linux-media/20201217234337.1983732-2-djrscally@gmail.com/T/#u

The tl;dr of the change is that it will now get() the next node (if
found) and **always** put() if one is passed.


>> +	}
>> +
>> +	for (; port; port = swnode_graph_find_next_port(parent, port)) {
> 
> So if the loop terminates normally, the reference acquired in the first
> branch of the if will be leaked.
> 
>> +		endpoint = software_node_get_next_child(port, old);
>> +		if (endpoint) {
>> +			fwnode_handle_put(port);
> 
> While in this case the reference not acquired in the second branch of
> the if will be released incorrectly.
> 
> I think it's software_node_get_next_child() that needs to be fixed if
> I'm not mistaken.

I think that's all handled in software_node_get_next_child() as amended
by 01/12. The net effect of get_next_endpoint() should be one refcount
increased for any endpoint returned, and 0 change to parent and any ports.


>> +			break;
>> +		}
>> +
>> +		/* No more endpoints for that port, so stop passing old */
>> +		old = NULL;
> 
> I wonder if you could drop the 'old' variable and use 'enpoint' in the
> call to software_node_get_next_child(). You could then drop these two
> lines.

That won't work, because endpoint would at that point not be a child of
the port we're passing, and the function relies on it being one:

	if (!p || list_empty(&p->children) ||
	    (c && list_is_last(&c->entry, &p->children))) {
		fwnode_handle_put(child);
		return NULL;
	}

>> +	}
>> +
>> +	fwnode_handle_put(parent);
>> +
>> +	return endpoint;
>> +}
>> +
>> +static struct fwnode_handle *
>> +software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
>> +{
>> +	struct swnode *swnode = to_swnode(fwnode);
>> +	const struct software_node_ref_args *ref;
>> +	const struct property_entry *prop;
>> +
>> +	if (!swnode)
>> +		return NULL;
>> +
>> +	prop = property_entry_get(swnode->node->properties, "remote-endpoint");
>> +	if (!prop || prop->type != DEV_PROP_REF || prop->is_inline)
>> +		return NULL;
>> +
>> +	ref = prop->pointer;
>> +
>> +	return software_node_get(software_node_fwnode(ref[0].node));
>> +}
>> +
>> +static struct fwnode_handle *
>> +software_node_graph_get_port_parent(struct fwnode_handle *fwnode)
>> +{
>> +	struct swnode *swnode = to_swnode(fwnode);
>> +	struct fwnode_handle *parent;
>> +
>> +	if (!strcmp(swnode->parent->node->name, "ports"))
>> +		parent = &swnode->parent->parent->fwnode;
>> +	else
>> +		parent = &swnode->parent->fwnode;
>> +
>> +	return software_node_get(parent);
>> +}
>> +
>> +static int
>> +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>> +				   struct fwnode_endpoint *endpoint)
>> +{
>> +	struct swnode *swnode = to_swnode(fwnode);
>> +	int ret;
>> +
>> +	ret = kstrtou32(swnode->parent->node->name + 5, 10, &endpoint->port);
>> +	if (ret)
>> +		return ret;
>> +
>> +	endpoint->id = swnode->id;
>> +	endpoint->local_fwnode = fwnode;
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct fwnode_operations software_node_ops = {
>>  	.get = software_node_get,
>>  	.put = software_node_put,
>> @@ -551,7 +655,11 @@ static const struct fwnode_operations software_node_ops = {
>>  	.get_parent = software_node_get_parent,
>>  	.get_next_child_node = software_node_get_next_child,
>>  	.get_named_child_node = software_node_get_named_child_node,
>> -	.get_reference_args = software_node_get_reference_args
>> +	.get_reference_args = software_node_get_reference_args,
>> +	.graph_get_next_endpoint = software_node_graph_get_next_endpoint,
>> +	.graph_get_remote_endpoint = software_node_graph_get_remote_endpoint,
>> +	.graph_get_port_parent = software_node_graph_get_port_parent,
>> +	.graph_parse_endpoint = software_node_graph_parse_endpoint,
>>  };
>>  
>>  /* -------------------------------------------------------------------------- */
> 
