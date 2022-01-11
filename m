Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8E48AA88
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 10:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiAKJ3p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 04:29:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51766 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236995AbiAKJ3o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jan 2022 04:29:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8ce2c008968;
        Tue, 11 Jan 2022 09:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=fDvzy4+SqqhBg9F9e219SWJU8zO6XwKoRma1JZiKSIk=;
 b=vH0D2qz28h2dJZt5omYup4tLpSl8cj6alG59la3XdYxELBgEbZzHXsylQeE1wJcaTwvI
 o0A1+AGIFURZWkDU5LhCBvoBFZCqUrBA8BYtXKCmaUvvPXJN+F4kDdZGRHjzgpP6A7CC
 MuPFtx5zgCT80ax9qRWOg//on41qeUJUNiHDKzy8ZpIvEaRb6UbUg/0Ak1wrfLJBZUNr
 kNGq4AWN6Zry3EJ9N/AGfcT3WI94F1fBeV8D4tfRbbWxrRVmW1q407ZX2BRFhpBHknp/
 X6uprQ4eYZOYyauNbKJlKHqrX2EHTGLPNb6kWSzh/T/EgPb4I95Fq15OB9MXAQbDOcMi 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtgau51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 09:29:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B9Bxwx013612;
        Tue, 11 Jan 2022 09:29:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by aserp3020.oracle.com with ESMTP id 3df2e4hakh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 09:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddSp+3O6eM1K9mz6A9iF8TlzfR6rL68v1zlZBLFAx6qOFzZA8MKAxqMHZGcs6aEnIzPrDjCbrjzXRzb2+LAA4iGnR+xA1XjfoeKF6WX6zwozoJLYQyR6lA2K47MpfRI0QIHi7CIcZno+AjODMwF7WefCUH3ziI67pMc8TtVeV6WhSn3mYtS+CyR5qL57yBgPofjZSjmfBSxb+gn5Js6t0WBeAZkhdpu+Yfz5AVyHD2eBknSSvByoIFrLybMiHOrfHryAWgNClFFivTNzYGFw1xQK6MPZa2UMrSqIrNDM9inC5t9ma9tHPl9obtustvDxJmP16+OciXYJZor3d+0Vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDvzy4+SqqhBg9F9e219SWJU8zO6XwKoRma1JZiKSIk=;
 b=ZSOiJkS3qNaTIBvj+uLTe624NzRfoluaFkdiPrm/VJa8sJRPFus9kK7E5syKmsmZ1poXp3y41sK8heGZz638+PK902fntPRTicr3XxrJLImJ3pSWZj3L9HLekbuWLo6sXnKr/SPHWqKjfF+rC29+ESs631igTLZj2HjW9QZjTpZ9FDzTk232t7CQdZ2+m4HpcIEjgn9oo8yWc852JdwmB8vxdFtGWXcJD2ttgWFrOYGQdqNr5Xw1UkdZUSajM/jrOJfxDLuqc3HSBRHx3Q5KbCir4PcfJbExyiBJyTAxL1SrbqlsRZxfHdqJohboZsKeA6jYrHnYTs3qdHHdAQ7M7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDvzy4+SqqhBg9F9e219SWJU8zO6XwKoRma1JZiKSIk=;
 b=gmbbSRmvDOVEkFkn1bNw54sWrIVbTsr+8j24tntVQYlUqut3QpnBJmnOzjYpoZRzm17ZccaxjiIDuUIsiZJkx1v++S14NY0ySCG4p+3VzfoBxo7ZSzn6H4ovdMMj0NwK5NDqSxt3BDPACVGUFxyoEm6JRR4i9slYDjFjOWBDDiU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1664.namprd10.prod.outlook.com
 (2603:10b6:301:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 09:29:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 09:29:39 +0000
Date:   Tue, 11 Jan 2022 12:29:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     steven@valvesoftware.com
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] ACPI: CPPC: Implement support for SystemIO registers
Message-ID: <20220111092928.GA24968@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0116.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bf323d4-7df5-4985-81f4-08d9d4e4e437
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1664FEA2F718EAA6946A5F198E519@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqLL/WOzwO2+fMV/uGleVVZzQYHC4cTvcFC5n2UZnT6K0fKW7nv+KdlZVBRnnWcbDKuMFm6xMzwzd4lvMAncG6s+A3Iw2nKvNb/RXmUNvvE2BJnqqj/coXJ3lOtohYkFAVxcio6CGv7VekVbuS7TwM9enyeJY4fgSIyo3hYDF1R+DBRL7Zh51JrYaakTRilWwzx3/m9ClvdLVscSsA1EDXPeEJj0MZjhssWGDIgBJIdUuMrUFJZ12alEoV+3EwWS/dac3OL9W1R6Hvtg+hRE4yXu4kB4P0NayVfv+MsPRb6WDtIO7GqBnKBTvBToC3gDNvoOnXJ3QMDUm8qXFIiNeoVzzAtXqXdvjoQ5Kye9XS17q9hn0f9F9pJzmqcUPKfTqOipmT+E57FXP5VUogvZJQw6anpu8aGreNfR8ldzOiZlkYSlr6so9lIqCQyTtsL5C6YCAOcP0wmM0/nbZPZPrStRO/9aXp0TO33U3rhlRWdLtVCIw3y+3hPsCzkcJg8f8/bqd2A3EehZG91E7UfOKRhDLOVcEd6PRprt63BujVoL804U1lSQN3uiXF/fxMVSDFVuNUAK1yB/O3GcdMsh3ka5qGtmMXPuvifsNQBcOACRKU2+dY8A9c+ORZgtxCXF+OP2YGASdXLL20LpwfhkX3j9viJjvGyTukx29M20Msx8N7y6lm1JTKMycfg/W8hbWJOlrCNchGxILLiANMu6bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(33656002)(4326008)(86362001)(38100700002)(2906002)(1076003)(508600001)(26005)(6916009)(186003)(6506007)(52116002)(6666004)(8936002)(6512007)(66556008)(9686003)(66476007)(8676002)(66946007)(38350700002)(44832011)(5660300002)(33716001)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rEsgUVEO8H0nuQAnXLT3JbIFroXz9AK/ZOyPzfsbNwg8vh1we5OuAFZ2V28m?=
 =?us-ascii?Q?MCTLikhem5EKlx88ieQqyUlMPBgnoJuyYkD26eFiEungGggpi1zJmvE/SXeM?=
 =?us-ascii?Q?3Wjw6UbWU1kSEZ/3x8akm1tKN4zqKAX+mgPK2V0maCiHqN17mNeHiz4diVXY?=
 =?us-ascii?Q?qOd3IMQFcfjQM+ET9ZG74cfhSFiVexaXqEd+1pONdcx3u+64TrqkZGFknRE4?=
 =?us-ascii?Q?jIoKJqqYPfoPlvcJGN8Cd3ARPMCOyjQnAAI0OTBG2X/yPXTNDGuTozi7IWAW?=
 =?us-ascii?Q?fGoqn9qbu80Qgz8UCmWKyuH/4ANi+CM487tgghvhfcwZIFIWMP5nbBlckF+C?=
 =?us-ascii?Q?4JcVSERvoImxYlbzMhszE7uwotHzg+jiDmmXJ8y5433cMLqEeuHSS7B7fTaF?=
 =?us-ascii?Q?WN6SJ0DT1FpEh/xVBAjYb112yXwoCWH4CBCEbo/jGjENUPHMY4KKi+jURBQk?=
 =?us-ascii?Q?euM6voCZgpRNlDq33QR6F78JkNP8fXNONRx8LmKhmScunNrvknaKTuKwpQEB?=
 =?us-ascii?Q?MY+Y6FjsAj6BX9XYAy5BvqHQ3SuM23TeWaDtVUiXuXmR0pd/D+c9p+kcb8XB?=
 =?us-ascii?Q?ejE2m/+gJzfw4rLFvwj+fDhPLkPmvfEcl5wdUtHJ9rdjH5Wf8sVq08QzgStB?=
 =?us-ascii?Q?TAqu+XAdAPiS0YB9hYXnpZ89kPkWLQloUx50ccIeIi7k467Q8nZXzFs0Ca64?=
 =?us-ascii?Q?jAfxTRfF19zGlm+dKWjT4qYe+Jfx4f9KvKo2D2jmy/VnTE3cxAOUq12Scg+p?=
 =?us-ascii?Q?/syUTKaRBmmkEmkJJxVtreZNWXN0e2Lfc+dxaTXJ0xqbwX7TR6sKIFuB1bsa?=
 =?us-ascii?Q?hxOsN47dNsnDpbZdJHhM/gMvcPbngmDqzc2DEtTJf4wJ0fRNGJz3zqFkJr6z?=
 =?us-ascii?Q?FbJ40kxmv+afE2FGdx1xUYCG7NPWJqJHY404Ga0hGLjRKSXjykGC9dOFCfLE?=
 =?us-ascii?Q?0aBf6eQDl2lwhJ2fi4hEHJOclEs1Ikn9Ng+iVbMFHPmDYF6UNaObLVZH1bD8?=
 =?us-ascii?Q?b58IBVcUrZGdtjlyQzCbl24F+H7K66Q2boYWtdx5WsnOG98KlBoOWc+GkYbr?=
 =?us-ascii?Q?VVrRMotjul+cEx91MHdtRL7FV3oolXVc+Zvzd17uDA5ULvxbVnXvB8uCKBlH?=
 =?us-ascii?Q?vq360ci4Rm6U3Rl22n6LHdRfmt+VuozpYO1iSPvDwbd/Hx46c9rIr6xUq1SN?=
 =?us-ascii?Q?hKkpds+loVV9SO+4IkdP8OeIWh7/tbJoyNUb/b9sPyhNf4E2Poe3LhxhGqdt?=
 =?us-ascii?Q?o42jQKeyv+N1FgIMpUuiWFcAgrCEQoQhCkMrlfHmEnk4mCkMiqtokZD0OXWa?=
 =?us-ascii?Q?0MYMVAIVu6J/mxiS9yiHIzzoXp5oE4Gb669JTbBg+0Y5Cgs4JKO9P1v/No23?=
 =?us-ascii?Q?yYbduyu2XArfyCnLEpgynJ2WKYL/7X6L3l67rfKUqExcjHlrYMbg7W3jr7mT?=
 =?us-ascii?Q?XfyPqY+VbQCqm1Q2fcyk9w852Bjym3NpvAhef138kLjYx+ypCFxozQQJj7QI?=
 =?us-ascii?Q?bvltGzDKLqQINmdNiNhSGaSuyX4NK8C8DozQ/xr2TwPjfhPmczWcllYVfBYc?=
 =?us-ascii?Q?J3koguCFMthppFe0uj8XNYlmjFmilCW8TKOWxLEJeVUumYBdiACG42HJZGVm?=
 =?us-ascii?Q?Du7qOm81s8e5GnKiFvEfH+ClcHUPivZ005GyzP7juLa3WXcp/F/WOCzXyreO?=
 =?us-ascii?Q?hK6JQub5mfO4YLPh2X6aBrGXF9s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf323d4-7df5-4985-81f4-08d9d4e4e437
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 09:29:39.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RydoItr9eOQPz4+nxXz4eWiLTFO+70eNzbWgXtoG3CKnBRXhadytlDd8odbMwZzI7VAGbIn6ex6T8gmZRFUMREcLRC3XiWvKWYUANcznqls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=901 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110053
X-Proofpoint-GUID: 2_PFNKcedy641TypvPyb5fC9zmIW7yrx
X-Proofpoint-ORIG-GUID: 2_PFNKcedy641TypvPyb5fC9zmIW7yrx
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Steven Noonan,

The patch a2c8f92bea5f: "ACPI: CPPC: Implement support for SystemIO
registers" from Dec 24, 2021, leads to the following Smatch static
checker warning:

	drivers/acpi/cppc_acpi.c:935 cpc_read()
	warn: passing casted pointer 'val' to 'acpi_os_read_port()' 64 vs 32.

drivers/acpi/cppc_acpi.c
    916 static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
    917 {
    918         int ret_val = 0;
    919         void __iomem *vaddr = NULL;
    920         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
    921         struct cpc_reg *reg = &reg_res->cpc_entry.reg;
    922 
    923         if (reg_res->type == ACPI_TYPE_INTEGER) {
    924                 *val = reg_res->cpc_entry.int_value;
    925                 return ret_val;
    926         }
    927 
    928         *val = 0;
    929 
    930         if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
    931                 u32 width = 8 << (reg->access_width - 1);
    932                 acpi_status status;
    933 
    934                 status = acpi_os_read_port((acpi_io_address)reg->address,
--> 935                                            (u32 *)val, width);
                                                   ^^^^^^^^^^
This code will not work on big endian systems.  You need to pass a real
&u32_tmp and then to *val = u32_tmp;

    936                 if (ACPI_FAILURE(status)) {
    937                         pr_debug("Error: Failed to read SystemIO port %llx\n",
    938                                  reg->address);
    939                         return -EFAULT;
    940                 }
    941 
    942                 return 0;
    943         } else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
    944                 vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
    945         else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
    946                 vaddr = reg_res->sys_mem_vaddr;
    947         else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
    948                 return cpc_read_ffh(cpu, reg, val);
    949         else
    950                 return acpi_os_read_memory((acpi_physical_address)reg->address,
    951                                 val, reg->bit_width);
    952 

regards,
dan carpenter
