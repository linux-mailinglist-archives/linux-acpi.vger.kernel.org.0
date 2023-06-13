Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EB72DBCA
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jun 2023 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbjFMH61 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Jun 2023 03:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbjFMH56 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jun 2023 03:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF0C1FC1;
        Tue, 13 Jun 2023 00:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F74C62A2C;
        Tue, 13 Jun 2023 07:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410FFC433EF;
        Tue, 13 Jun 2023 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686643028;
        bh=XZcRKllUDNwn2KB+yvdCn+WcXnldLMqtBn28JoqAwAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVLOG4lJhh5nhCufoSbyVcE1QEDmhGeLg1W0JkZcRgXj1ET7Sg9f+xe2zE/Q197Y3
         pJg0YJSvPPbAtn3qdfzqKSme8VbbTLoDV4NQKASwOWwN3eeLPOztUFwZQedHvBrXNt
         2fFpF4Vqqn/rcBe0SNOrl9X+LuZBUDWMB49GFaP8=
Date:   Tue, 13 Jun 2023 09:57:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        rafael@kernel.org, jonathan.cameron@huawei.com
Subject: Re: [PATCH v2] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
Message-ID: <2023061331-napkin-disburse-915d@gregkh>
References: <168660916231.1965241.248859226126456131.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168660916231.1965241.248859226126456131.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 12, 2023 at 03:32:42PM -0700, Dave Jiang wrote:
> Dan Williams suggested changing the struct 'node_hmem_attrs' to
> 'access_coordinates' [1]. The struct is a container of r/w-latency and
> r/w-bandwidth numbers. Moving forward, this container will also be used by
> CXL to store the performance characteristics of each link hop in
> the PCIE/CXL topology. So, where node_hmem_attrs is just the access
> parameters of a memory-node, access_coordinates applies more broadly
> to hardware topology characteristics. The observation is that seemed like
> an excercise in having the application identify "where" it falls on a
> spectrum of bandwidth and latency needs. For the tuple of read/write-latency
> and read/write-bandwidth, "coordinates" is not a perfect fit. Sometimes it
> is just conveying values in isolation and not a "location" relative to
> other performance points, but in the end this data is used to identify the
> performance operation point of a given memory-node. [2]
> 
> Link: http://lore.kernel.org/r/64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch/
> Link: https://lore.kernel.org/linux-cxl/645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Hi Greg and Rafael,
> please consider ACK this patch and Dan can take it through the
> CXL upstream tree. The remaining ACPI [1] and CXL [2] patches for enabling
> CXL QoS class data have dependency on this patch. Thank you!
> 
> [1]: https://lore.kernel.org/linux-cxl/168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3/T/#t
> [2]: https://lore.kernel.org/linux-cxl/168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3/T/#t

Isn't this going to conflict with the version that I have in the
driver-core-next tree as commit 7810f4dc8795 ("base/node: Use 'property'
to identify an access parameter")?

Or was that a different thing?

thanks,

greg k-h
