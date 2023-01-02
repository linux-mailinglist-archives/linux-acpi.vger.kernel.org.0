Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25865B13D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jan 2023 12:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjABLha (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Jan 2023 06:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjABLh3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jan 2023 06:37:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E64F7D
        for <linux-acpi@vger.kernel.org>; Mon,  2 Jan 2023 03:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672659449; x=1704195449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Obpxi8nIQdEsgeDUNZ98cHiFIOUIrb4Nv0hFiyDo/Jo=;
  b=Lo2oYK3ssNBLPJmVUd6nHHpqb5PL8qZqQ+rrK+qYyc4Adqiq7Mb7Kq5d
   muSbGgXsjQOuUm3OFluRL1oZYYh07xtsdMLCK86nwtNU69RtaUNjQD4gf
   zE+BfMTkc1t/r5NFiGUl8nmlHZYgo3m67XgXCAI+7ioXOdOJgZWTqPbW4
   aQCyv+XiP5hDABqOetZ3E6QAsWid/KCf+1pE0V6OQu5fgN/vY1/9E/h9b
   eCdIt1IN8EhFnt5y5jZCDSnntq5irflIc3rAmiT6eHQbPimLgF3SJyLj/
   xvlhmkhbkrsCpwnr0B0Nc/AIB+o0xnbfDVInh493D+XrGfBlbcp7J9O+0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="320183191"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="320183191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 03:37:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="717776195"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="717776195"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 03:37:27 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 302392017A;
        Mon,  2 Jan 2023 13:37:25 +0200 (EET)
Date:   Mon, 2 Jan 2023 11:37:25 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/1] ACPI: acpica: Constify pathname argument for
 acpi_get_handle()
Message-ID: <Y7LB9R7YkF8KGBv8@paasikivi.fi.intel.com>
References: <20221220150126.1624988-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0gdFdPjAc-aLZBDJAkZ1jjGdigBjX9RzWwTdokH_sCwhw@mail.gmail.com>
 <CAJZ5v0guBgiRn2E_MG+uNqVVmgd0iHPHHwUPK1b1jBG3xz3PHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0guBgiRn2E_MG+uNqVVmgd0iHPHHwUPK1b1jBG3xz3PHQ@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 30, 2022 at 06:53:44PM +0100, Rafael J. Wysocki wrote:
> Applied now, thanks!

Thank you, Rafael!

-- 
Sakari Ailus
