Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B35833B9
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jul 2022 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiG0Tf6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jul 2022 15:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiG0Tfz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2022 15:35:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA04F18B
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jul 2022 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658950553; x=1690486553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3zoGb/toCPz7n3qEjsYx2qqrl7Gy9OYNvSI1RirNNQU=;
  b=iok8xVdDG5aKJMCGHu8mOEmYobWgv8WqUv5jy2z/uuE0jP9diNZ/Cl3t
   HWh2Z/M7poCr7uJVwnwn4hNFZdg2CGCNPCoVkKtdSmNIeYAS20BrHObwL
   r9pqW9a+nIKssGPCMzVM00uJuhVUJmaS+a3v8VkV+uUivIVeaYbp87iW6
   Z/hoLWVdXmQqpxQvmI9N2Pd8h8wJtpHC18jaXlfaPPGcTT92VBIGZ4oME
   goLPHUQDYZBXp6aDaSrN+jbv/vKzx9m5yePJTxt+gx1q0cPH70qOnnOjn
   UEYs6jJtUZEpJaGI4nI4OFEv5zt8cFckUP5oHXTsDEzuIaaiI0SNh5jOK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="350034075"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="350034075"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 12:35:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="550973016"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 12:35:51 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B2B4F20373;
        Wed, 27 Jul 2022 22:35:49 +0300 (EEST)
Date:   Wed, 27 Jul 2022 19:35:49 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 0/8] [PATCH v3 0/8] ACPI: Buffer property and
 reference as string support
Message-ID: <YuGTlawzy1mIAMuZ@paasikivi.fi.intel.com>
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jKOMn3=8XxpD_X5Z2JjyAknpGa-7rVhNZY2gnfAmX76w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jKOMn3=8XxpD_X5Z2JjyAknpGa-7rVhNZY2gnfAmX76w@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 27, 2022 at 09:20:15PM +0200, Rafael J. Wysocki wrote:
> >  drivers/acpi/property.c | 465 +++++++++++++++++++++++++++-------------
> >  include/acpi/acpi_bus.h |   3 +-
> >  include/linux/acpi.h    |   2 +-
> >  3 files changed, 318 insertions(+), 152 deletions(-)
> >
> > --
> 
> The series (including the update of patch [7/8]) has been applied as
> 5.20 material, thanks!

Thank you!

Thanks to Andy for reviews, too!

-- 
Sakari Ailus
