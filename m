Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA4E6EE52A
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjDYQAq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Apr 2023 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjDYQAp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2023 12:00:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F033C17A;
        Tue, 25 Apr 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682438444; x=1713974444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wZo7TiYQ+/8MmU6bpEbIFp5SasFLNfv+bfLYt9hVqNs=;
  b=Ix2cLLhBGa2OYr7vfFeRQ/my0fBsUqY0bXa7KfnXrDyj18/3s0kp6zUt
   IP+bfNfbrg9AOJtvzs7Tn5B+QAe4bu+9DtrrQiRxx9Eev3qHZbBDPwaE0
   v66cD3Z3SLz2uqeIyQWIkvEad6ZQE6insIkinz1TK6BOVQwIoutAuGN7X
   /yApEv7bWmRqO5PaPRanNTwQ7acPODnhyEvY5rOCAcRgx1V9/+pqI/6FR
   UFXwV5F8eiZpyAWaDXoIbz3KkyaORcWkkLPAviAnkkWw+tCk83Mi3kv1f
   odNiYz7hhi+K9/wwmXMvegRM6/v9W+57udrJyZNSlZcBKYtC4JP83CwMl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="326417422"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="326417422"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 09:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="670949478"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="670949478"
Received: from dtam1-mobl.amr.corp.intel.com (HELO [10.212.46.134]) ([10.212.46.134])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 09:00:43 -0700
Message-ID: <42b3e292-28b7-f19b-81c3-5bb40974c913@intel.com>
Date:   Tue, 25 Apr 2023 09:00:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 04/23] cxl: Add common helpers for cdat parsing
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
 <644703a1d25c2_1b66294d9@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <644703a1d25c2_1b66294d9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/24/23 3:33 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Add helper functions to parse the CDAT table and provide a callback to
>> parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
>> parsing. The code is patterned after the ACPI table parsing helpers.
> 
> It seems a shame that CDAT is so ACPI-like, but can't reuse the ACPI
> table parsing infrastructure. Can this not be achieved by modifying some
> of the helpers helpers in drivers/acpi/tables.c to take a passed in
> @table_header?

Rafael,
Do you have any issues with adding some endieness support in 
drivers/acpi/tables.c in order to support CDAT parsing by BE hosts? To 
start off with something like below?

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 7b4680da57d7..e63e2daf151d 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -287,6 +287,12 @@ acpi_get_subtable_type(char *id)
         return ACPI_SUBTABLE_COMMON;
  }

+static unsigned long __init_or_acpilib
+acpi_table_get_length(struct acpi_table_header *hdr)
+{
+       return le32_to_cpu((__force __le32)hdr->length);
+}
+
  static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
  {
         return proc->handler || proc->handler_arg;
@@ -337,7 +343,8 @@ static int __init_or_acpilib acpi_parse_entries_array(
         int errs = 0;
         int i;

-       table_end = (unsigned long)table_header + table_header->length;
+       table_end = (unsigned long)table_header +
+                   acpi_table_get_length(table_header);

         /* Parse all entries looking for a match. */

