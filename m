Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3296EAEB0
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Apr 2023 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjDUQHi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Apr 2023 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjDUQHh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2023 12:07:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1821BE2;
        Fri, 21 Apr 2023 09:07:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2zsm236kz67T1b;
        Sat, 22 Apr 2023 00:06:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Apr
 2023 17:07:30 +0100
Date:   Fri, 21 Apr 2023 17:07:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 08/23] cxl: Add support for _DSM Function for
 retrieving QTG ID
Message-ID: <20230421170730.0000201a@Huawei.com>
In-Reply-To: <58afc53f-6050-56bb-25ef-1799ca28c34a@intel.com>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193570968.1178687.16632681494857661844.stgit@djiang5-mobl3>
        <20230420130009.000048c0@Huawei.com>
        <58afc53f-6050-56bb-25ef-1799ca28c34a@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> >> +	}
> >> +
> >> +out:
> >> +	ACPI_FREE(out_obj);
> >> +	return output;
> >> +
> >> +err:
> >> +	ACPI_FREE(out_obj);
> >> +	return ERR_PTR(rc);  
> > 
> > Why not combine these with something like
> > 
> > 	return IS_ERR(rc) ? ERR_PTR(rc) : output;
> > 
> > I'm fine with leaving as it is, if this is common style for these
> > sorts of ACPI functions.  
> 
> I'll combine it. But if I just set output to ERR_PTR(errno) for all the 
> error cases then we can just return output directly without checking?

Excellent point.

> 
> >   
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_evaluate_qtg_dsm, CXL);  
> >   

