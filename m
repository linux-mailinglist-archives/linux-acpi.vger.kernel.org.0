Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023914BC009
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Feb 2022 19:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiBRS67 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Feb 2022 13:58:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiBRS66 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Feb 2022 13:58:58 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB829E55F
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 10:58:40 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id a6so4061250oid.9
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 10:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KpCzVne1Gz58N6SARjxbFTCJz302oRTwstbeXMAdM6Q=;
        b=bdbTuvm8EhR7ibTXIWua4NuoDT4JYpbH8sHlb7TYbrfJ/Mixb7A27r726gOZ7bY/Be
         un3LIIxds0kLC/KCIlmd5Z6CEs3qEymVveKT4xTZo0WX9LqbaLGyWPj8swHeQNp5tIFW
         gW71m8qGKsRhYqBfU/l59Ng2TFw1bupL4Q+t+FX9eBpIC/uKfIKSPHYj2s1MQ4GSz5qS
         0+nLY4RYnyGM5N9ajfP8pPIEAKsEyVcH6zU4JBVPnj3lh3s5H9u4uj0vX9aZ2bJCumC4
         sUNKYQHDQKDNoVup872h/87P5kvDLrcI5U81XFM368cBTGqsQPiKa44939zeM1btmRy7
         R+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KpCzVne1Gz58N6SARjxbFTCJz302oRTwstbeXMAdM6Q=;
        b=pmDN1mLX+QQKqylG1JcAQcgPJsJwY3d6f+bwi2ocS+eetnUW3AkNHVyrebto4IABJO
         dEcTU8+7j/rLtq3TNM/DUE+m5Ec3GaFJYuZnL9/wYfCLfFmZJqFozOJ8K4eWqisxu2NH
         t62lVExsGZTwkJS9ve/06B+UrKljoovHIuoQFitf1vn0kDG2bqSIdtdgrKJcZ4n7xbpv
         BvZh40mE4JlfxfXppBJV3PKG9qQDQg008vNzZjw4MTi9FlYtTqINlURAG7J8jx3QoGB1
         iDa0gQEJ9kXmzTu64U96ZT3hgN1I/e6ouyKQu8gRAT2Ax0w/SUv314NN2s0E5AP49AmN
         jCig==
X-Gm-Message-State: AOAM531Jdz5k4PskHxm67QcNkTLIzKpOVID7VmPhu2pH4j7INvDS+vCk
        WnlLc6F397qQJW7vIG0wpNXT8w==
X-Google-Smtp-Source: ABdhPJyJJ0FUxp/4FKsJBvxsI8qBwR+/9DIHJHiIGkTECSA06MCw5JbT7Xw12pC7tWwnJNkgXJC6kg==
X-Received: by 2002:a05:6808:209f:b0:2cd:f37:c722 with SMTP id s31-20020a056808209f00b002cd0f37c722mr4195900oiw.45.1645210719989;
        Fri, 18 Feb 2022 10:58:39 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id be19sm2749956oib.31.2022.02.18.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:58:39 -0800 (PST)
Date:   Fri, 18 Feb 2022 11:00:45 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/6] device property: Helper to match multiple
 connections
Message-ID: <Yg/s3eKB2wLEQTgY@ripper>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
 <20220208031944.3444-2-bjorn.andersson@linaro.org>
 <YgOz6K55Oi2Si4pU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgOz6K55Oi2Si4pU@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 09 Feb 04:30 PST 2022, Andy Shevchenko wrote:

> On Mon, Feb 07, 2022 at 07:19:39PM -0800, Bjorn Andersson wrote:
> > In some cases multiple connections with the same connection id
> > needs to be resolved from a fwnode graph.
> > 
> > One such example is when separate hardware is used for performing muxing
> > and/or orientation switching of the SuperSpeed and SBU lines in a USB-C
> 
> USB Type-C ?
> 
> > connector. In this case the connector needs to belong to a graph with
> > multiple matching remote endpoints, and the TypeC controller needs to be
> 
> Type-C ?
> 
> > able to resolve them both.
> > 
> > Add a new API that allows this kind of lookup.
> > 
> > Given that the match() callback returns an opaque reference to something
> > provided by the client it's not possible for the implementation to
> > release the returned object and as such it's not possible to handle
> > errors, which in turn means that it's not possible to query the number
> > of elements or dynamically grow the results array. It's however expected
> > that the number of matches will be reasonably low and that the worst
> > case is known by the caller before hand.
> 
> ...
> 
> > +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> > +		if (count >= matches_len) {
> > +			fwnode_handle_put(ep);
> > +			return count;
> > +		}
> > +
> > +		node = fwnode_graph_get_remote_port_parent(ep);
> > +		if (!fwnode_device_is_available(node)) {
> > +			fwnode_handle_put(node);
> > +			continue;
> > +		}
> > +
> > +		ret = match(node, con_id, data);
> > +		fwnode_handle_put(node);
> 
> > +
> 
> Redundant blank line (it seems the current style w/o this).
> Ditto for the below function.
> 
> > +		if (ret)
> > +			matches[count++] = ret;
> > +	}
> 
> ...
> 
> > +/**
> > + * fwnode_connection_find_matches - Find connections from a device node
> > + * @fwnode: Device node with the connection
> > + * @con_id: Identifier for the connection
> > + * @data: Data for the match function
> > + * @match: Function to check and convert the connection description
> > + * @matches: Array of pointers to fill with matches
> > + * @matches_len: Length of @matches
> > + *
> > + * Find up to @matches_len connections with unique identifier @con_id between
> > + * @fwnode and other device nodes. @match will be used to convert the
> > + * connection description to data the caller is expecting to be returned
> > + * through the @matches array.
> > + *
> > + * Return: Number of matches resolved, of negative errno.
> 
> s/of/or/ ?
> 
> > + */
> > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > +				   const char *con_id, void *data,
> > +				   devcon_match_fn_t match,
> > +				   void **matches, unsigned int matches_len)
> > +{
> > +	unsigned int count;
> > +
> > +	if (!fwnode || !match || !matches)
> 
> !matches case may be still useful to get the count and allocate memory by
> caller. Please, consider this case.
> 

As discussed in previous version, and described in the commit message,
the returned value of "match" is a opaque pointer to something which
has to be passed back to the caller in order to be cleaned up.

E.g. the typec mux code returns a pointer to a typec_mux/switch object
with a refcounted struct device within, or an ERR_PTR().

So unfortunately we can must gather the results into matches and pass it
back to the caller to take consume or clean up.


Thanks for your review, I'll update the patches according to the
other feedback.

Regards,
Bjorn

> > +		return -EINVAL;
> > +
> > +	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > +					    matches, matches_len);
> > +
> > +	return count + fwnode_devcon_matches(fwnode, con_id, data, match,
> > +					     matches + count,
> > +					     matches_len - count);
> 
> I haven't found any explanation what the difference between two counts. Also
> can you define two count variables with distinct names and do something like
> 
> 	count_A = ...
> 
> 	matches += count;
> 	matches_len -= count;
> 
> 	count_B = ...
> 
> 	return count_A + count_B;
> 
> ?
> 
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
