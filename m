Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B64ECCE3
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiC3TGd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350524AbiC3TGb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 15:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A5422B21;
        Wed, 30 Mar 2022 12:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A0C60F79;
        Wed, 30 Mar 2022 19:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29904C340EE;
        Wed, 30 Mar 2022 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648667085;
        bh=ig01C5pFWUmFUjaqP015wjbT0PoDutbCBMftVDVTSao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZyC1ypEj8spCnGxuKOvHhc5GTokIvctHb6wanBLpSTXDzCYLhryO0O3M1HBv1jeRu
         pK9rTXL+rz+f6vyJrg3JJkp6PhlUCozKQZKRSdcLwFs9BeBU7gfAtskRSZns51gSzZ
         eVY+i/A3a5QRKUqjM8q4uEjGuvD1RfkYJVj6jtD2fit7HKlmBK/K7PwqOiFplPoQDF
         BfMtqXUKOSotzbEAxhcfRk1IE7v2K5HC2IxCDgwbkcZtfcEcSeiRSkEpXdWygMJiV1
         epiOtU2sgqSbNKK7jl53ekhdv619wMFTc1d/sPeNzruoymdec8rH08/iGwmNN0O6AX
         GfobgOc1AHMuw==
Date:   Wed, 30 Mar 2022 14:04:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/3] acpi: add a helper for retrieving _OSC Control
 DWORDs
Message-ID: <20220330190443.GA1700287@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330181434.1515791-2-vishal.l.verma@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Look at previous subject lines and copy the style instead of making up
something new.

On Wed, Mar 30, 2022 at 12:14:32PM -0600, Vishal Verma wrote:
> During _OSC negotiation, when the 'Control' DWORD is needed from the
> result buffer after running _OSC, a couple of places performed manual
> pointer arithmetic to offset into the right spot in the raw buffer.
> Add a acpi_osc_ctx_get_pci_control() helper to use the #define'd
> DWORD offsets to fetch the DWORDs needed from @acpi_osc_context, and
> replace the above instances of the open-coded arithmetic.

Bjorn
