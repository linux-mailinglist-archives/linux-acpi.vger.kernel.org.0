Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3141001A3
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKRJqw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 04:46:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbfKRJqw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Nov 2019 04:46:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI9gNoh018879;
        Mon, 18 Nov 2019 04:45:40 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wayaw6q8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 04:45:40 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAI9jGsP023882;
        Mon, 18 Nov 2019 09:45:43 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 2wa8r5s6hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 09:45:43 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAI9jcZ865864058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 09:45:38 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BE5E6A047;
        Mon, 18 Nov 2019 09:45:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 205FF6A051;
        Mon, 18 Nov 2019 09:45:35 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.246])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 09:45:34 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 15/18] mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
In-Reply-To: <157401275716.43284.13185549705765009174.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401275716.43284.13185549705765009174.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Mon, 18 Nov 2019 15:15:33 +0530
Message-ID: <87wobxh60y.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180087
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Update numa_map_to_online_node() to stop falling back to numa node 0
> when the input is NUMA_NO_NODE. Also, skip the lookup if @node is
> online. This makes the routine compatible with other arch node mapping
> routines.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/mempolicy.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index e2d8dd21ce9d..d618121bcc17 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -137,8 +137,8 @@ int numa_map_to_online_node(int node)
>  {
>  	int min_node;
>  
> -	if (node == NUMA_NO_NODE)
> -		node = 0;
> +	if (node == NUMA_NO_NODE || node_online(node))
> +		return node;
>  
>  	min_node = node;
>  	if (!node_online(node)) {
