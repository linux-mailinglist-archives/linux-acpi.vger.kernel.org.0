Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6FA3A935D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 08:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhFPG5x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 02:57:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:63504 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhFPG5i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 02:57:38 -0400
IronPort-SDR: CnSQUQD18y2E8YhrtmaYn/6isv4JsDLzLV7EJDPYl5zkNOFRtFd93sS3sZAW/xjyGj19iLtUSL
 WbcaQLQ3JVTQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206084504"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="206084504"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 23:55:32 -0700
IronPort-SDR: KV3BD7ZhGV1XRJRvJj0dt4O2b00BFbeYM7BM4gavKuHwzUYRDB2M5dfv/QB7op6wcfiivzTi8+
 rVN9ROxeuixw==
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="637372913"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 23:55:28 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 2E927202D5;
        Wed, 16 Jun 2021 09:55:26 +0300 (EEST)
Date:   Wed, 16 Jun 2021 09:55:26 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/29] docs: firmware-guide: acpi: avoid using ReST
 :doc:`foo` markup
Message-ID: <20210616065526.GB3@paasikivi.fi.intel.com>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
 <7162043c18f1ea96c446b332400e44e8087ba142.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7162043c18f1ea96c446b332400e44e8087ba142.1623824363.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 08:27:32AM +0200, Mauro Carvalho Chehab wrote:
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
