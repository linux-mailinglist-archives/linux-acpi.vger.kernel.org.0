Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0724D4196
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 08:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiCJHLm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 02:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiCJHLm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 02:11:42 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E569D0C2
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 23:10:42 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9223768AFE; Thu, 10 Mar 2022 08:10:39 +0100 (CET)
Date:   Thu, 10 Mar 2022 08:10:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     nvdimm@lists.linux.dev, robert.hu@linux.intel.com,
        vishal.l.verma@intel.com, hch@lst.de, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/6] nvdimm/namespace: Delete blk namespace
 consideration in shared paths
Message-ID: <20220310071039.GC25138@lst.de>
References: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com> <164688417214.2879318.4698377272678028573.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164688417214.2879318.4698377272678028573.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
