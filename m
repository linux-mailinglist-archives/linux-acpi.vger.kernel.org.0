Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B38749CFB
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 15:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGFNHM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGFNHL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 09:07:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A9130;
        Thu,  6 Jul 2023 06:07:10 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-160-25-222.reb.o2.cz [85.160.25.222])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0F3196C8;
        Thu,  6 Jul 2023 15:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688648783;
        bh=kFXYMaRNy692WAO7dygIwPF6OJXZiqQU43YF4ucPeT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gsq1u2aYF0567GL1pMKroC9mPmaVTXiMGAiNWqlnBKpZA6wrRMYooADdxhvSHR1kc
         Z4RCqD6o/mKX0I/tYpPD91g0Y7YvT9yZT1kYph26Th5ZilrKNLkkNIFErpAoEePm8r
         vbDoLzvRae+Z33nWMPxTbuzJXZ0WM1CXS/no9mjI=
Date:   Thu, 6 Jul 2023 16:07:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 17/18] media: atomisp: csi2-bridge: Add dev_name() to
 acpi_handle_info() logging
Message-ID: <20230706130708.GD20921@pendragon.ideasonboard.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-18-hdegoede@redhat.com>
 <ZKaS2UbkbkbfYqAe@smile.fi.intel.com>
 <20230706111224.GA20921@pendragon.ideasonboard.com>
 <ZKayRcm83vMImkte@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKayRcm83vMImkte@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 03:23:33PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 06, 2023 at 02:12:24PM +0300, Laurent Pinchart wrote:
> > On Thu, Jul 06, 2023 at 01:09:29PM +0300, Andy Shevchenko wrote:
> > > On Wed, Jul 05, 2023 at 11:30:09PM +0200, Hans de Goede wrote:
> 
> ...
> 
> > > > -			acpi_handle_info(adev->handle, "Using DSM entry %s=%s\n", key, val);
> > > > +			acpi_handle_info(adev->handle, "%s: Using DSM entry %s=%s\n",
> > > > +					 dev_name(&adev->dev), key, val);
> > > 
> > > Maybe (maybe!) it's a candidate to have something like
> > > 
> > > v4l2_acpi_log_info(adev, ...) which combines both and unloads the code from
> > > thinking about it?
> > 
> > Or acpi_dev_info() that would take an acpi_device pointer.
> 
> (which is an equivalent to the below)
> 
> > Or just just dev_info(&adev->dev) ?
> 
> The point is to print ACPI handle *and* device name. There are no existing
> helpers for that.

Then a new acpi_dev_info(struct acpi_device *adev, ...) could do that.
It shouldn't be V4L2-specific in my opinion.

-- 
Regards,

Laurent Pinchart
