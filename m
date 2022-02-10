Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B642C4B0F2A
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Feb 2022 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiBJNt2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Feb 2022 08:49:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbiBJNt1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Feb 2022 08:49:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCE137;
        Thu, 10 Feb 2022 05:49:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBEA8B82559;
        Thu, 10 Feb 2022 13:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80A6C004E1;
        Thu, 10 Feb 2022 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644500966;
        bh=pkJgMwC0UXrEQU6Z3PROxsQ48Zm/YeCFFMRVynxtPPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7X5atbBQeGFHdpXiuGJuhrjoPRGK0GDDKZ/8j6PhszIGaFInpNoGJrzR2R9BqLbN
         RxD1kZK8dZ6+AFjOX0HfoyLWyOhrJpsqBMXNeiH5+3Q2cpe9ZrHZfA8YXPzcadD6v3
         gGnXL+h9DkEkjMxx2EpCAgAGYUAXup8OhleRC+uefOL43PJxOVT5Iu4qbOtsK6Pyi/
         fqMcy5L92CCDot20Ngm5ICRE+JJkpyqqHNcAic1K4snj3tiaW5AoPAwprePECjn/YK
         B3UNrMqzRS4AdbNK1PGtSvGW26kLpnbELxFlhufJSWU8rs8VpeySLqQhxfzAM/iW6q
         FsUDeG+ML267A==
Date:   Thu, 10 Feb 2022 19:19:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] soundwire: Replace acpi_bus_get_device()
Message-ID: <YgUX4rRet+p+LVFA@matsya>
References: <3173256.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3173256.44csPzL39Z@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 26-01-22, 20:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.

Applied, thanks

-- 
~Vinod
