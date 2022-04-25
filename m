Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B605650E7DB
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Apr 2022 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiDYSRF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Apr 2022 14:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbiDYSRF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Apr 2022 14:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046E11117F;
        Mon, 25 Apr 2022 11:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AF2361660;
        Mon, 25 Apr 2022 18:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E03C385A7;
        Mon, 25 Apr 2022 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650910439;
        bh=PKN2TOPhZplmXRWvbfub9SLeqaCp4w91KN14SEiGq2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mp0/uPHxt2BvWD+sQtySMOmUgP63DlgEQxMmrZwf2+0dx6bgm7GTvKEVhvDrc5T4v
         MuQKG3yG+jUKtB7WUslEFCP9iOq9cddoPHYBMebkJczsUMXDFANPlgloqxvO/7Zd9N
         P6Jc1A5goQ32d5dc6D6tvaivl0JsJuDvlx3vxv6hUJiOku7EJzutlxbO2SHJPLFJ6D
         fsvoBd2UOUOp1vyfdQ0SwaqB6hqOlf+3t3FLB0yVM7MfC4/Tr/LUnNIcSXyHEtj0pY
         //Fdey8GTOReQQL+xKTgSAygZzuT+Q9LZgbWjgRpdHV/qqVN3nzNmvxCHgLHRMAFPH
         P5kip87RQxwIw==
Date:   Mon, 25 Apr 2022 13:13:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v6 0/3] PCI/ACPI: add support for CXL _OSC
Message-ID: <20220425181357.GA1647966@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f277b84c2ee770f6a2706744b96fb1dfd6184a7.camel@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 22, 2022 at 10:24:34PM +0000, Verma, Vishal L wrote:
> On Wed, 2022-04-13 at 01:36 -0600, Vishal Verma wrote:
> > Changes since v5[1]:
> > - Collect an reviewed-by tags from Rafael, Adam, and David
> > - Fix a couple of missed s/CXL/extended/ in acpi_bus.h (Rafael)
> 
> Rafael, or Bjorn,
> 
> Dan has offered to take this through cxl.git. Any objections to that -
> would you prefer it to go through either the PCI or ACPI trees instead?

OK by me if Dan or Rafael takes it.
