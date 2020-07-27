Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5922EC90
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgG0Mu4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 08:50:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40264 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgG0Mu4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 08:50:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RCfY28076525;
        Mon, 27 Jul 2020 12:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Q5F30uW4IQ0ZgkPtFoSw0X2abrC47hDOq4jrQqiRNkk=;
 b=MNcYdYf3+AXI9uyHhVuAH5IO6qJgdhOa/djzWnCFm+u452d2HnokpzwtKjFl07HvL2Bh
 jwNaSP0LLHy6hg+nbypeOtLAc9Vt8k91Dl2GI9UAdVO1Q1kHHlpA83b5qTGvdfSvCV1y
 fQWsDipOaLD+c33iMimaUzu+KNvyawymBI8lQfgxuXK9m7ctmN9A2JGM7tiGqeyIr5/P
 e2clQ21cgwKCwszGWPkIXl4xITysNC88GP45YXGvfhNbbirEla9TD5vksBR34cI/jz/+
 Z+peXV/Z9yy/P9mBQsgZL34xhL1Ea+UoO8TYdtuoimSnPIIhhFocSbBnW8kvFu4aY81f vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1j9af2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 12:50:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RCiU29028786;
        Mon, 27 Jul 2020 12:48:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32hu5qtv1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 12:48:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06RCmoLf025014;
        Mon, 27 Jul 2020 12:48:50 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 05:48:49 -0700
Date:   Mon, 27 Jul 2020 15:48:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     garritfra <garritfranke@gmail.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, trivial@kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] trivial: acpi: replace some bitshifts with BIT macro
Message-ID: <20200727124842.GC1913@kadam>
References: <alpine.DEB.2.21.2007241806070.2834@hadrien>
 <20200724161111.17531-1-garritfranke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724161111.17531-1-garritfranke@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=862 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=872
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270094
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is buggy.  See my comments to v1.

regards,
dan carpenter

